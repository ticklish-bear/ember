import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:ember/models/cycle.dart';
import 'package:ember/models/day_entry.dart';
import 'package:ember/services/stm_engine.dart';

// ---------------------------------------------------------------------------
// Backtest suite for the STM evaluation engine.
//
// Strategy: feed the engine full multi-day cycles with known, hand-verified
// expected outcomes (textbook AG NFP charts and edge cases), then assert the
// outputs. A final fuzz pass generates thousands of random cycles and asserts
// the SAFETY INVARIANT that matters for contraception:
//
//   A day may only be flagged infertilePostOvulation when BOTH the temperature
//   shift is confirmed AND Peak Day + 3 has passed, and only from the later of
//   the two markers onward. Temperature OR mucus alone is never sufficient.
//
// The dangerous failure mode is a false "infertile". These tests are built to
// catch exactly that.
// ---------------------------------------------------------------------------

final _base = DateTime(2024, 1, 1);

DayEntry day(
  int d, {
  double? temp,
  bool excluded = false,
  MucusType mucus = MucusType.unrecorded,
  BleedingType bleeding = BleedingType.none,
  bool peak = false,
}) {
  return DayEntry(
    cycleId: 1,
    date: _base.add(Duration(days: d - 1)),
    cycleDay: d,
    temperature: temp,
    temperatureExcluded: excluded,
    mucusType: mucus,
    bleeding: bleeding,
    isPeakDay: peak,
  );
}

/// Open cycle whose evaluated range equals [lastDay] (startDate back-dated so
/// "today" is lastDay). length left null to mirror a real current cycle.
Cycle openCycle(int lastDay) {
  return Cycle(
    id: 1,
    startDate: DateTime.now().subtract(Duration(days: lastDay - 1)),
  );
}

/// Build N completed previous cycles of the given lengths.
List<Cycle> completed(List<int> lengths) {
  return [
    for (var i = 0; i < lengths.length; i++)
      Cycle(
        id: 100 + i,
        startDate: _base.add(Duration(days: i * 40)),
        length: lengths[i],
      ),
  ];
}

void main() {
  final engine = StmEngine();

  // -------------------------------------------------------------------------
  group('Textbook 28-day cycle (AG NFP)', () {
    // Clear biphasic temperatures + clear mucus build-up and dry-down.
    final entries = <DayEntry>[
      day(1, temp: 36.5, bleeding: BleedingType.heavy),
      day(2, temp: 36.4, bleeding: BleedingType.medium),
      day(3, temp: 36.5, bleeding: BleedingType.medium),
      day(4, temp: 36.4, bleeding: BleedingType.light),
      day(5, temp: 36.5, bleeding: BleedingType.spotting),
      day(6, temp: 36.45, mucus: MucusType.dry),
      day(7, temp: 36.5, mucus: MucusType.dry),
      day(8, temp: 36.4, mucus: MucusType.nothing),
      day(9, temp: 36.45, mucus: MucusType.moist),
      day(10, temp: 36.5, mucus: MucusType.wet), // first fertile mucus (q3)
      day(11, temp: 36.4, mucus: MucusType.eggWhite),
      day(12, temp: 36.45, mucus: MucusType.eggWhite),
      day(13, temp: 36.5, mucus: MucusType.eggWhite), // Peak Day (last q4)
      day(14, temp: 36.7, mucus: MucusType.moist), // first high temp, mucus drops
      day(15, temp: 36.75, mucus: MucusType.dry),
      day(16, temp: 36.8, mucus: MucusType.dry), // 3rd high (>= cl+0.2) -> confirmed
      day(17, temp: 36.75, mucus: MucusType.dry),
      day(18, temp: 36.8, mucus: MucusType.dry),
    ];
    final eval = engine.evaluate(openCycle(18), entries);

    test('detects coverline at 36.5', () {
      expect(eval.coverline, 36.5);
    });
    test('first high temp on day 14', () {
      expect(eval.firstHighTempDay, 14);
    });
    test('temperature shift confirmed on day 16', () {
      expect(eval.temperatureShiftConfirmedDay, 16);
    });
    test('Peak Day auto-detected on day 13', () {
      expect(eval.peakDay, 13);
    });
    test('post-ov infertility begins day 16 (later of peak+3=16, shift=16)', () {
      expect(eval.postPeakInfertileFrom, 16);
    });
    test('days 16-18 are infertile post-ovulation', () {
      for (final d in [16, 17, 18]) {
        expect(eval.dayStatuses[d], FertilityStatus.infertilePostOvulation,
            reason: 'day $d');
      }
    });
    test('days 1-5 are menstruation', () {
      for (final d in [1, 2, 3, 4, 5]) {
        expect(eval.dayStatuses[d], FertilityStatus.menstruation);
      }
    });
    test('fertile window days 6-15 are NOT marked infertile', () {
      for (var d = 6; d <= 15; d++) {
        expect(eval.dayStatuses[d], isNot(FertilityStatus.infertilePostOvulation),
            reason: 'day $d must not be infertile pre-confirmation');
        expect(eval.dayStatuses[d], isNot(FertilityStatus.infertilePreOvulation),
            reason: 'day $d is after the 5-day rule');
      }
    });
  });

  // -------------------------------------------------------------------------
  group('Double-check safety (the critical invariant)', () {
    test('temperature shift WITHOUT any mucus -> NO post-ov infertility', () {
      // Clear biphasic temps, mucus never recorded.
      final entries = [
        for (var d = 1; d <= 9; d++) day(d, temp: 36.4),
        day(10, temp: 36.7),
        day(11, temp: 36.75),
        day(12, temp: 36.8), // confirmed shift
        day(13, temp: 36.8),
      ];
      final eval = engine.evaluate(openCycle(13), entries);
      expect(eval.temperatureShiftConfirmedDay, isNotNull,
          reason: 'temp shift should be detected');
      expect(eval.peakDay, isNull, reason: 'no mucus -> no peak');
      expect(eval.postPeakInfertileFrom, isNull,
          reason: 'one check only -> infertility NOT confirmed');
      final anyInfertile = eval.dayStatuses.values
          .any((s) => s == FertilityStatus.infertilePostOvulation);
      expect(anyInfertile, isFalse,
          reason: 'SAFETY: temp alone must never confirm infertility');
    });

    test('mucus Peak WITHOUT temperature shift -> NO post-ov infertility', () {
      // Clear mucus pattern, but flat temps (no shift).
      final entries = [
        day(1, temp: 36.5, bleeding: BleedingType.medium),
        day(2, temp: 36.5, bleeding: BleedingType.light),
        day(6, temp: 36.5, mucus: MucusType.moist),
        day(7, temp: 36.5, mucus: MucusType.wet),
        day(8, temp: 36.5, mucus: MucusType.eggWhite), // peak
        day(9, temp: 36.5, mucus: MucusType.dry),
        day(10, temp: 36.5, mucus: MucusType.dry),
        day(11, temp: 36.5, mucus: MucusType.dry),
        day(12, temp: 36.5, mucus: MucusType.dry),
      ];
      final eval = engine.evaluate(openCycle(12), entries);
      expect(eval.peakDay, 8, reason: 'peak should be detected');
      expect(eval.temperatureShiftConfirmedDay, isNull,
          reason: 'flat temps -> no shift');
      expect(eval.postPeakInfertileFrom, isNull);
      final anyInfertile = eval.dayStatuses.values
          .any((s) => s == FertilityStatus.infertilePostOvulation);
      expect(anyInfertile, isFalse,
          reason: 'SAFETY: mucus alone must never confirm infertility');
    });

    test('partial check is surfaced as fertileWaitingForDoubleCheck', () {
      // Temp shift present, no mucus -> the post-shift days should be flagged
      // as waiting (still fertile), never infertile.
      final entries = [
        for (var d = 1; d <= 9; d++) day(d, temp: 36.4),
        day(10, temp: 36.7),
        day(11, temp: 36.75),
        day(12, temp: 36.8),
        day(13, temp: 36.8),
      ];
      final eval = engine.evaluate(openCycle(13), entries);
      expect(eval.dayStatuses[12], FertilityStatus.fertileWaitingForDoubleCheck);
      expect(eval.dayStatuses[13], FertilityStatus.fertileWaitingForDoubleCheck);
    });
  });

  // -------------------------------------------------------------------------
  group('3-over-6 rule precision', () {
    test('3rd temp only +0.15 above coverline -> shift NOT confirmed', () {
      final entries = [
        for (var d = 1; d <= 9; d++) day(d, temp: 36.5),
        day(10, temp: 36.6),
        day(11, temp: 36.6),
        day(12, temp: 36.65), // only +0.15 above coverline 36.5
        day(13, temp: 36.65),
        // mucus so that the only thing missing is the temp criterion
        day(8, temp: 36.5, mucus: MucusType.eggWhite),
        day(9, temp: 36.5, mucus: MucusType.dry),
      ];
      final eval = engine.evaluate(openCycle(13), entries);
      expect(eval.temperatureShiftConfirmedDay, isNull,
          reason: '0.15 < required 0.2 rise');
    });

    test('3rd temp exactly +0.2 above coverline -> shift confirmed', () {
      final entries = [
        for (var d = 1; d <= 9; d++) day(d, temp: 36.5),
        day(10, temp: 36.6),
        day(11, temp: 36.65),
        day(12, temp: 36.7), // exactly +0.2
        day(13, temp: 36.7),
      ];
      final eval = engine.evaluate(openCycle(13), entries);
      expect(eval.temperatureShiftConfirmedDay, 12);
      expect(eval.coverline, 36.5);
    });

    test('gap in high phase (missing day) -> shift not confirmed there', () {
      // High temps on days 10, 11, 13 (day 12 missing) -> no 3 consecutive.
      final entries = [
        for (var d = 1; d <= 9; d++) day(d, temp: 36.4),
        day(10, temp: 36.7),
        day(11, temp: 36.75),
        // day 12 intentionally missing
        day(13, temp: 36.8),
      ];
      final eval = engine.evaluate(openCycle(13), entries);
      expect(eval.temperatureShiftConfirmedDay, isNull,
          reason: 'high phase must be 3 consecutive calendar days');
    });

    test('excluded (disturbed) temperature is ignored', () {
      // A spuriously high temp on day 8 is excluded; without it there is no
      // false low-phase coverline inflation and no false shift.
      final entries = [
        for (var d = 1; d <= 7; d++) day(d, temp: 36.4),
        day(8, temp: 37.2, excluded: true), // fever, excluded
        day(9, temp: 36.4),
        day(10, temp: 36.45),
        day(11, temp: 36.4),
      ];
      final eval = engine.evaluate(openCycle(11), entries);
      // Only 10 valid temps, all low -> no shift, no false infertility.
      expect(eval.temperatureShiftConfirmedDay, isNull);
      final anyInfertile = eval.dayStatuses.values
          .any((s) => s == FertilityStatus.infertilePostOvulation);
      expect(anyInfertile, isFalse);
    });
  });

  // -------------------------------------------------------------------------
  group('Later-of-two marker', () {
    test('shift later than peak+3 -> infertility starts at shift', () {
      final entries = [
        day(1, bleeding: BleedingType.medium),
        // peak early: day 8
        day(6, temp: 36.4, mucus: MucusType.wet),
        day(7, temp: 36.4, mucus: MucusType.eggWhite),
        day(8, temp: 36.4, mucus: MucusType.eggWhite), // peak
        day(9, temp: 36.4, mucus: MucusType.dry),
        day(10, temp: 36.4),
        day(11, temp: 36.4),
        // shift much later: high temps days 17,18,19
        day(12, temp: 36.4),
        day(13, temp: 36.4),
        day(14, temp: 36.4),
        day(15, temp: 36.4),
        day(16, temp: 36.4),
        day(17, temp: 36.7),
        day(18, temp: 36.75),
        day(19, temp: 36.8), // confirmed day 19
      ];
      final eval = engine.evaluate(openCycle(19), entries);
      expect(eval.peakDay, 8);
      expect(eval.temperatureShiftConfirmedDay, 19);
      // peak+3 = 11, shift = 19 -> later is 19
      expect(eval.postPeakInfertileFrom, 19);
      expect(eval.dayStatuses[18], isNot(FertilityStatus.infertilePostOvulation));
      expect(eval.dayStatuses[19], FertilityStatus.infertilePostOvulation);
    });

    test('peak+3 later than shift -> infertility starts at peak+3', () {
      final entries = [
        day(1, bleeding: BleedingType.medium),
        // early shift: high temps days 9,10,11
        for (var d = 2; d <= 8; d++) day(d, temp: 36.4),
        day(9, temp: 36.7),
        day(10, temp: 36.75),
        day(11, temp: 36.8), // confirmed day 11
        day(12, temp: 36.8),
        day(13, temp: 36.8),
        // late peak: eggwhite day 14, drop day 15
        day(13, temp: 36.8, mucus: MucusType.eggWhite),
        day(14, temp: 36.8, mucus: MucusType.eggWhite), // peak
        day(15, temp: 36.8, mucus: MucusType.dry),
      ];
      final eval = engine.evaluate(openCycle(15), entries);
      expect(eval.temperatureShiftConfirmedDay, 11);
      expect(eval.peakDay, 14);
      // peak+3 = 17, shift = 11 -> later is 17 -> beyond the cycle range here
      expect(eval.postPeakInfertileFrom, 17);
      // Because 17 > lastDay 15, NO day is infertile yet (correctly waiting).
      final anyInfertile = eval.dayStatuses.values
          .any((s) => s == FertilityStatus.infertilePostOvulation);
      expect(anyInfertile, isFalse,
          reason: 'peak+3 not yet reached -> not infertile');
    });
  });

  // -------------------------------------------------------------------------
  group('Cervical mucus override (pre-ovulatory)', () {
    test('fertile mucus on day 4 overrides the 5-day rule', () {
      final entries = [
        day(1, bleeding: BleedingType.heavy),
        day(2, bleeding: BleedingType.medium),
        day(3, mucus: MucusType.moist),
        day(4, mucus: MucusType.eggWhite), // fertile mucus early!
        day(5, mucus: MucusType.eggWhite),
      ];
      final eval = engine.evaluate(openCycle(5), entries);
      // Day 5 must NOT be infertile pre-ov because fertile mucus appeared day 4.
      expect(eval.dayStatuses[5], isNot(FertilityStatus.infertilePreOvulation),
          reason: 'mucus override: fertile mucus ends the infertile phase');
      expect(eval.dayStatuses[4], isNot(FertilityStatus.infertilePreOvulation));
    });
  });

  // -------------------------------------------------------------------------
  group('Pre-ovulatory rule hierarchy', () {
    test('beginner (no history) -> 5-day rule', () {
      final eval = engine.evaluate(openCycle(10), [day(1, temp: 36.5)]);
      expect(eval.lastInfertilePreOvDay, 5);
      expect(eval.appliedPreOvRule, PreOvRule.fiveDayRule);
    });

    test('all cycles >= 26 days -> Rötzer 6-day rule', () {
      final prev = completed(List.filled(6, 28));
      final eval = engine.evaluate(openCycle(10), [day(1, temp: 36.5)],
          previousCycles: prev);
      expect(eval.appliedPreOvRule, PreOvRule.roetzerSixDayRule);
      expect(eval.lastInfertilePreOvDay, 6);
    });

    test('minus-20 rule with 12+ cycles (shortest 24 -> day 4)', () {
      final lengths = [24, 27, 28, 29, 30, 28, 27, 26, 31, 28, 29, 27];
      final eval = engine.evaluate(openCycle(10), [day(1, temp: 36.5)],
          previousCycles: completed(lengths));
      expect(eval.appliedPreOvRule, PreOvRule.minus20Rule);
      expect(eval.minus20Value, 4); // 24 - 20
      expect(eval.lastInfertilePreOvDay, 4);
    });

    test('minus-8 wins when stricter than minus-20', () {
      // 12 long cycles (shortest 30 -> minus20 = 10) but an early temp rise.
      final lengths = List.filled(12, 30);
      // 12 first-high-temp days, earliest = 11 -> minus8 = 3
      final shiftDays = [11, 13, 14, 12, 15, 13, 14, 13, 12, 14, 15, 13];
      final eval = engine.evaluate(
        openCycle(10),
        [day(1, temp: 36.5)],
        previousCycles: completed(lengths),
        previousTempShiftDays: shiftDays,
      );
      expect(eval.minus20Value, 10); // 30 - 20
      expect(eval.minus8Value, 3); // 11 - 8
      expect(eval.appliedPreOvRule, PreOvRule.minus8Rule);
      expect(eval.lastInfertilePreOvDay, 3,
          reason: 'most conservative (smallest) rule wins');
    });

    test('pre-ov boundary never drops below day 1', () {
      // Extremely short cycles -> minus20 would be negative; clamp to 1.
      final lengths = List.filled(12, 20); // 20 - 20 = 0 -> clamp 1
      final eval = engine.evaluate(openCycle(10), [day(1, temp: 36.5)],
          previousCycles: completed(lengths));
      expect(eval.lastInfertilePreOvDay, greaterThanOrEqualTo(1));
    });
  });

  // -------------------------------------------------------------------------
  group('Fix A regression: Peak Day with charting gaps', () {
    test('egg-white then a 7-day mucus gap then one dry day -> NO peak', () {
      // The exact case that previously confirmed infertility prematurely.
      final entries = [
        for (var d = 1; d <= 9; d++) day(d, temp: 36.4),
        day(10, temp: 36.45, mucus: MucusType.eggWhite),
        day(11, temp: 36.7),
        day(12, temp: 36.75),
        day(13, temp: 36.8), // temp shift confirmed
        // days 14-17: nothing recorded (gap)
        day(18, temp: 36.8, mucus: MucusType.dry),
      ];
      final eval = engine.evaluate(openCycle(18), entries);
      expect(eval.temperatureShiftConfirmedDay, 12,
          reason: 'temp side is unaffected by the fix');
      expect(eval.peakDay, isNull,
          reason: 'drop not observed on day 11 -> peak unconfirmed');
      expect(eval.postPeakInfertileFrom, isNull);
      final anyInfertile = eval.dayStatuses.values
          .any((s) => s == FertilityStatus.infertilePostOvulation);
      expect(anyInfertile, isFalse,
          reason: 'no premature infertility from a stale peak');
    });

    test('drop observed on the very next day -> peak still detected', () {
      final entries = [
        day(6, mucus: MucusType.wet),
        day(7, mucus: MucusType.eggWhite),
        day(8, mucus: MucusType.eggWhite), // peak
        day(9, mucus: MucusType.dry), // observed next-day drop
      ];
      final eval = engine.evaluate(openCycle(9), entries);
      expect(eval.peakDay, 8);
    });

    test('one-day gap right after peak candidate -> not confirmed there', () {
      // egg-white day 8, day 9 missing, dry day 10.
      final entries = [
        day(6, mucus: MucusType.wet),
        day(7, mucus: MucusType.eggWhite),
        day(8, mucus: MucusType.eggWhite),
        day(10, mucus: MucusType.dry), // gap at day 9
      ];
      final eval = engine.evaluate(openCycle(10), entries);
      expect(eval.peakDay, isNull);
    });
  });

  // -------------------------------------------------------------------------
  group('Incomplete / inconsistent input', () {
    test('empty cycle -> empty evaluation, no crash', () {
      final eval = engine.evaluate(openCycle(10), const []);
      expect(eval.dayStatuses, isEmpty);
      expect(eval.coverline, isNull);
      expect(eval.peakDay, isNull);
    });

    test('no temperatures at all -> no shift, no infertility', () {
      final entries = [
        for (var d = 1; d <= 14; d++)
          day(d, mucus: d == 8 ? MucusType.eggWhite : MucusType.dry),
      ];
      final eval = engine.evaluate(openCycle(14), entries);
      expect(eval.temperatureShiftConfirmedDay, isNull);
      expect(
          eval.dayStatuses.values
              .any((s) => s == FertilityStatus.infertilePostOvulation),
          isFalse);
    });

    test('all mucus unrecorded -> no peak, no infertility', () {
      final entries = [
        for (var d = 1; d <= 9; d++) day(d, temp: 36.4),
        day(10, temp: 36.7),
        day(11, temp: 36.75),
        day(12, temp: 36.8),
      ];
      final eval = engine.evaluate(openCycle(12), entries);
      expect(eval.peakDay, isNull);
      expect(eval.postPeakInfertileFrom, isNull);
    });

    test('fewer than 9 temperatures -> shift never confirmed', () {
      final entries = [
        for (var d = 1; d <= 8; d++) day(d, temp: 36.4 + (d > 5 ? 0.4 : 0)),
      ];
      final eval = engine.evaluate(openCycle(8), entries);
      expect(eval.temperatureShiftConfirmedDay, isNull);
    });

    test('entries supplied out of order -> sorted internally', () {
      final shuffled = [
        day(16, temp: 36.8, mucus: MucusType.dry),
        day(1, bleeding: BleedingType.medium),
        day(13, temp: 36.4, mucus: MucusType.eggWhite), // clearly low temp
        day(14, temp: 36.7, mucus: MucusType.moist),
        day(15, temp: 36.75, mucus: MucusType.dry),
        for (var d = 2; d <= 12; d++) day(d, temp: 36.4),
      ];
      final eval = engine.evaluate(openCycle(16), shuffled);
      expect(eval.temperatureShiftConfirmedDay, 16);
      expect(eval.peakDay, 13);
    });

    test('duplicate cycleDay entries -> no crash', () {
      final entries = [
        day(1, temp: 36.4),
        day(1, temp: 36.5), // duplicate day
        day(2, temp: 36.4),
        day(2, mucus: MucusType.eggWhite), // duplicate day
        for (var d = 3; d <= 12; d++) day(d, temp: 36.4),
      ];
      // Must simply not throw.
      final eval = engine.evaluate(openCycle(12), entries);
      expect(eval, isNotNull);
    });

    test('mid-cycle breakthrough bleeding -> marked menstruation, safe', () {
      final entries = [
        for (var d = 1; d <= 9; d++) day(d, temp: 36.4),
        day(10, temp: 36.4, bleeding: BleedingType.spotting), // breakthrough
        day(11, temp: 36.4),
        day(12, temp: 36.4),
      ];
      final eval = engine.evaluate(openCycle(12), entries);
      expect(eval.dayStatuses[10], FertilityStatus.menstruation);
      expect(
          eval.dayStatuses.values
              .any((s) => s == FertilityStatus.infertilePostOvulation),
          isFalse);
    });

    test('excluded outlier temperature cannot create a false shift', () {
      final entries = [
        for (var d = 1; d <= 8; d++) day(d, temp: 36.4),
        day(9, temp: 39.0, excluded: true), // fever spike, excluded
        day(10, temp: 36.4),
        day(11, temp: 36.4),
        day(12, temp: 36.4),
      ];
      final eval = engine.evaluate(openCycle(12), entries);
      expect(eval.temperatureShiftConfirmedDay, isNull);
    });

    test('manual Peak Day flag is honored even without mucus data', () {
      final entries = [
        for (var d = 1; d <= 9; d++) day(d, temp: 36.4),
        day(10, temp: 36.7),
        day(11, temp: 36.75),
        day(12, temp: 36.8),
        DayEntry(
          cycleId: 1,
          date: _base.add(const Duration(days: 8)),
          cycleDay: 9,
          isPeakDay: true,
        ),
      ];
      final eval = engine.evaluate(openCycle(13), entries);
      expect(eval.peakDay, 9, reason: 'manual override wins');
    });
  });

  // -------------------------------------------------------------------------
  group('SAFETY FUZZ: 5000 random cycles', () {
    test('infertilePostOvulation only ever appears after a full double-check',
        () {
      final rng = Random(20240620); // fixed seed -> reproducible
      var cyclesWithInfertile = 0;

      for (var iter = 0; iter < 5000; iter++) {
        final n = 20 + rng.nextInt(20); // 20-39 day cycle
        final entries = <DayEntry>[];
        for (var d = 1; d <= n; d++) {
          // Random-ish biphasic-ish temps, sometimes with gaps.
          final hasTemp = rng.nextDouble() > 0.15;
          final t = 36.2 + rng.nextDouble() * 0.8; // 36.2 - 37.0
          final mucusRoll = rng.nextInt(7);
          entries.add(day(
            d,
            temp: hasTemp ? double.parse(t.toStringAsFixed(2)) : null,
            excluded: rng.nextDouble() > 0.95,
            mucus: MucusType.values[mucusRoll],
            bleeding: d <= 4 ? BleedingType.medium : BleedingType.none,
          ));
        }

        final eval = engine.evaluate(openCycle(n), entries);

        final infertileDays = eval.dayStatuses.entries
            .where((e) => e.value == FertilityStatus.infertilePostOvulation)
            .map((e) => e.key)
            .toList();

        if (infertileDays.isEmpty) continue;
        cyclesWithInfertile++;

        // INVARIANT 1: both checks must be present.
        expect(eval.temperatureShiftConfirmedDay, isNotNull,
            reason: 'iter $iter: infertile without temp shift');
        expect(eval.peakDay, isNotNull,
            reason: 'iter $iter: infertile without Peak Day');

        // INVARIANT 2: the start equals the LATER of the two markers.
        final expectedStart = max(
          eval.peakDay! + 3,
          eval.temperatureShiftConfirmedDay!,
        );
        expect(eval.postPeakInfertileFrom, expectedStart,
            reason: 'iter $iter: start must be later-of-two');

        // INVARIANT 3: no infertile day earlier than that start.
        for (final d in infertileDays) {
          expect(d, greaterThanOrEqualTo(expectedStart),
              reason: 'iter $iter: day $d infertile before confirmation');
        }

        // INVARIANT 4: post-ov infertile region is contiguous to cycle end.
        infertileDays.sort();
        expect(infertileDays.first, expectedStart);
        expect(infertileDays.last, n);
        for (var i = 0; i < infertileDays.length - 1; i++) {
          // contiguous unless a later bleeding day intervened (none here post-ov)
          expect(infertileDays[i + 1] - infertileDays[i], 1,
              reason: 'iter $iter: infertile region must be contiguous');
        }
      }

      // Sanity: the fuzz actually exercised the infertile path sometimes.
      expect(cyclesWithInfertile, greaterThan(0),
          reason: 'fuzz never produced an infertile phase — test is vacuous');
      // ignore: avoid_print
      print('Fuzz: $cyclesWithInfertile/5000 cycles produced a post-ov '
          'infertile phase, all passed the safety invariant.');
    });
  });
}

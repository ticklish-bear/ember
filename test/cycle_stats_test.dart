import 'package:flutter_test/flutter_test.dart';
import 'package:crest/models/cycle.dart';
import 'package:crest/services/cycle_stats.dart';

// Verifies every statistic shown on the Statistics screen. The math is pure,
// so these run without a database. Reference values are hand-computed.

Cycle c({int? length, int? shiftDay, DateTime? start}) => Cycle(
      startDate: start ?? DateTime(2024, 1, 1),
      length: length,
      temperatureShiftDay: shiftDay,
    );

void main() {
  group('cycleLengths filtering', () {
    test('excludes null and non-positive lengths', () {
      final cycles = [
        c(length: 28),
        c(length: null), // open cycle
        c(length: 0), // invalid
        c(length: -3), // invalid
        c(length: 30),
      ];
      expect(CycleStats.cycleLengths(cycles), [28, 30]);
      expect(CycleStats.completedCycleCount(cycles), 2,
          reason: 'count must match the filtered lengths exactly');
    });

    test('empty list -> empty / null everywhere', () {
      final none = <Cycle>[];
      expect(CycleStats.cycleLengths(none), isEmpty);
      expect(CycleStats.averageCycleLength(none), isNull);
      expect(CycleStats.shortestCycle(none), isNull);
      expect(CycleStats.longestCycle(none), isNull);
      expect(CycleStats.cycleLengthStdDev(none), isNull);
      expect(CycleStats.averageTempShiftDay(none), isNull);
      expect(CycleStats.completedCycleCount(none), 0);
    });
  });

  group('average / shortest / longest', () {
    final cycles = [
      c(length: 27),
      c(length: 29),
      c(length: 28),
      c(length: 30),
      c(length: 26),
    ];

    test('average', () {
      expect(CycleStats.averageCycleLength(cycles), 28.0); // 140 / 5
    });
    test('shortest', () {
      expect(CycleStats.shortestCycle(cycles), 26);
    });
    test('longest', () {
      expect(CycleStats.longestCycle(cycles), 30);
    });
  });

  group('standard deviation (population)', () {
    test('known dataset -> sqrt(2)', () {
      // lengths 27,29,28,30,26 -> mean 28 -> sq dev 1,1,0,4,4 = 10
      // population variance 10/5 = 2 -> sd sqrt(2)
      final cycles = [
        c(length: 27),
        c(length: 29),
        c(length: 28),
        c(length: 30),
        c(length: 26),
      ];
      final sd = CycleStats.cycleLengthStdDev(cycles)!;
      expect(sd, closeTo(1.41421356, 1e-6));
    });

    test('identical lengths -> 0', () {
      final cycles = [c(length: 28), c(length: 28), c(length: 28)];
      expect(CycleStats.cycleLengthStdDev(cycles), 0.0);
    });

    test('single cycle -> null (need >= 2)', () {
      expect(CycleStats.cycleLengthStdDev([c(length: 28)]), isNull);
    });
  });

  group('average temperature shift day', () {
    test('averages only cycles that have a shift day', () {
      final cycles = [
        c(length: 28, shiftDay: 14),
        c(length: 29, shiftDay: 16),
        c(length: 27, shiftDay: null), // ignored
      ];
      expect(CycleStats.averageTempShiftDay(cycles), 15.0); // (14+16)/2
    });

    test('no shift days -> null', () {
      expect(CycleStats.averageTempShiftDay([c(length: 28)]), isNull);
    });
  });

  group('prediction', () {
    final current = c(length: null, start: DateTime(2024, 6, 1));
    final history = [c(length: 28), c(length: 28), c(length: 30)];

    test('requires >= 2 completed cycles', () {
      expect(
          CycleStats.predictedNextPeriod([c(length: 28)], current), isNull);
    });

    test('requires a current cycle', () {
      expect(CycleStats.predictedNextPeriod(history, null), isNull);
    });

    test('predicts start + round(avg) days', () {
      // avg of 28,28,30 = 28.666... -> round 29 -> Jun 1 + 29 = Jun 30
      final predicted = CycleStats.predictedNextPeriod(history, current)!;
      expect(predicted, DateTime(2024, 6, 30));
    });

    test('daysUntil positive / zero / negative with injected now', () {
      expect(
          CycleStats.daysUntilNextPeriod(history, current,
              now: DateTime(2024, 6, 20)),
          10); // Jun 30 - Jun 20
      expect(
          CycleStats.daysUntilNextPeriod(history, current,
              now: DateTime(2024, 6, 30)),
          0);
      expect(
          CycleStats.daysUntilNextPeriod(history, current,
              now: DateTime(2024, 7, 3)),
          -3);
    });

    test('daysUntil ignores time-of-day component', () {
      expect(
          CycleStats.daysUntilNextPeriod(history, current,
              now: DateTime(2024, 6, 20, 23, 59)),
          10);
    });
  });
}

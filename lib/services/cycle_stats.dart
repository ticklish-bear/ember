import 'dart:math' as math;
import '../models/cycle.dart';

/// Pure, side-effect-free statistics over a list of cycles.
///
/// Extracted from CycleProvider so the math can be unit-tested without a
/// database. All methods are static and deterministic; the only external
/// input (the current date) is injectable for testing.
///
/// A "completed" cycle here means one with a recorded, positive length.
/// Cycles with a null or non-positive length (e.g. an open current cycle, or
/// one closed without a valid span) are excluded from every calculation so a
/// single bad row can never skew the averages.
class CycleStats {
  const CycleStats._();

  /// Valid completed cycle lengths (length recorded and > 0).
  static List<int> cycleLengths(List<Cycle> cycles) {
    return cycles
        .where((c) => c.length != null && c.length! > 0)
        .map((c) => c.length!)
        .toList();
  }

  /// Number of completed cycles (consistent with [cycleLengths]).
  static int completedCycleCount(List<Cycle> cycles) =>
      cycleLengths(cycles).length;

  static double? averageCycleLength(List<Cycle> cycles) {
    final lengths = cycleLengths(cycles);
    if (lengths.isEmpty) return null;
    return lengths.reduce((a, b) => a + b) / lengths.length;
  }

  static int? shortestCycle(List<Cycle> cycles) {
    final lengths = cycleLengths(cycles);
    if (lengths.isEmpty) return null;
    return lengths.reduce(math.min);
  }

  static int? longestCycle(List<Cycle> cycles) {
    final lengths = cycleLengths(cycles);
    if (lengths.isEmpty) return null;
    return lengths.reduce(math.max);
  }

  /// Population standard deviation of cycle lengths. Null with < 2 cycles.
  static double? cycleLengthStdDev(List<Cycle> cycles) {
    final lengths = cycleLengths(cycles);
    if (lengths.length < 2) return null;
    final avg = lengths.reduce((a, b) => a + b) / lengths.length;
    final variance =
        lengths.map((l) => (l - avg) * (l - avg)).reduce((a, b) => a + b) /
            lengths.length;
    return math.sqrt(variance);
  }

  /// Average confirmed temperature-shift day across cycles that have one.
  static double? averageTempShiftDay(List<Cycle> cycles) {
    final shiftDays = cycles
        .where((c) => c.temperatureShiftDay != null)
        .map((c) => c.temperatureShiftDay!)
        .toList();
    if (shiftDays.isEmpty) return null;
    return shiftDays.reduce((a, b) => a + b) / shiftDays.length;
  }

  /// Predicted next period start, based on the average cycle length applied to
  /// the current cycle's start date. Requires at least 2 completed cycles for
  /// a meaningful prediction; otherwise null.
  static DateTime? predictedNextPeriod(
    List<Cycle> cycles,
    Cycle? currentCycle,
  ) {
    final avg = averageCycleLength(cycles);
    if (avg == null || currentCycle == null) return null;
    if (cycleLengths(cycles).length < 2) return null;
    return currentCycle.startDate.add(Duration(days: avg.round()));
  }

  /// Whole days until the predicted next period (negative = overdue).
  /// [now] is injectable for testing; defaults to the current date.
  static int? daysUntilNextPeriod(
    List<Cycle> cycles,
    Cycle? currentCycle, {
    DateTime? now,
  }) {
    final predicted = predictedNextPeriod(cycles, currentCycle);
    if (predicted == null) return null;
    final today = now ?? DateTime.now();
    return DateTime(predicted.year, predicted.month, predicted.day)
        .difference(DateTime(today.year, today.month, today.day))
        .inDays;
  }
}

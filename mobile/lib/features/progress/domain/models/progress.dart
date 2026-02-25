import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress.freezed.dart';
part 'progress.g.dart';

@freezed
class WorkoutHistoryEntry with _$WorkoutHistoryEntry {
  const factory WorkoutHistoryEntry({
    required String id,
    required String workoutTitle,
    required DateTime startedAt,
    DateTime? completedAt,
    int? durationSeconds,
    @Default('') String notes,
    @Default([]) List<ExerciseLogEntry> exerciseLogs,
  }) = _WorkoutHistoryEntry;

  factory WorkoutHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$WorkoutHistoryEntryFromJson(json);
}

@freezed
class ExerciseLogEntry with _$ExerciseLogEntry {
  const factory ExerciseLogEntry({
    required String exerciseName,
    required int setsCompleted,
    @Default([]) List<int> repsPerSet,
    @Default([]) List<double> weightPerSet,
    @Default('KG') String weightUnit,
  }) = _ExerciseLogEntry;

  factory ExerciseLogEntry.fromJson(Map<String, dynamic> json) =>
      _$ExerciseLogEntryFromJson(json);
}

@freezed
class ProgressStats with _$ProgressStats {
  const factory ProgressStats({
    required int totalWorkouts,
    required int totalDurationSeconds,
    required int currentStreak,
    required int longestStreak,
    required int activePrograms,
  }) = _ProgressStats;

  factory ProgressStats.fromJson(Map<String, dynamic> json) =>
      _$ProgressStatsFromJson(json);
}

@freezed
class PaginatedHistory with _$PaginatedHistory {
  const factory PaginatedHistory({
    String? next,
    String? previous,
    @Default([]) List<WorkoutHistoryEntry> results,
  }) = _PaginatedHistory;

  factory PaginatedHistory.fromJson(Map<String, dynamic> json) =>
      _$PaginatedHistoryFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fitlabel/shared/models/media_file.dart';

part 'workout.freezed.dart';
part 'workout.g.dart';

/// Lean model for workout browse lists.
@freezed
class WorkoutBrief with _$WorkoutBrief {
  const factory WorkoutBrief({
    required String id,
    required String title,
    int? estimatedDurationMinutes,
    MediaFile? coverImage,
    required int exerciseCount,
    @Default([]) List<String> muscleGroups,
  }) = _WorkoutBrief;

  factory WorkoutBrief.fromJson(Map<String, dynamic> json) =>
      _$WorkoutBriefFromJson(json);
}

@freezed
class MuscleGroup with _$MuscleGroup {
  const factory MuscleGroup({
    required String value,
    required String label,
  }) = _MuscleGroup;

  factory MuscleGroup.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupFromJson(json);
}

@freezed
class WorkoutDetail with _$WorkoutDetail {
  const factory WorkoutDetail({
    required String id,
    required String title,
    String? description,
    int? estimatedDurationMinutes,
    MediaFile? coverImage,
    required List<ExerciseEntry> exerciseEntries,
    WorkoutLog? latestLog,
  }) = _WorkoutDetail;

  factory WorkoutDetail.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDetailFromJson(json);
}

@freezed
class ExerciseEntry with _$ExerciseEntry {
  const factory ExerciseEntry({
    required ExerciseBrief exercise,
    required int ordering,
    required int sets,
    required String reps,
    required int restSeconds,
    String? notes,
    int? supersetGroup,
  }) = _ExerciseEntry;

  factory ExerciseEntry.fromJson(Map<String, dynamic> json) =>
      _$ExerciseEntryFromJson(json);
}

@freezed
class ExerciseBrief with _$ExerciseBrief {
  const factory ExerciseBrief({
    required String id,
    required String name,
    required List<String> muscleGroups,
    String? equipment,
    MediaFile? demoImage,
  }) = _ExerciseBrief;

  factory ExerciseBrief.fromJson(Map<String, dynamic> json) =>
      _$ExerciseBriefFromJson(json);
}

@freezed
class WorkoutLog with _$WorkoutLog {
  const factory WorkoutLog({
    required String id,
    required String workout,
    required DateTime startedAt,
    DateTime? completedAt,
    int? durationSeconds,
    @Default([]) List<ExerciseLogEntry> exerciseLogs,
  }) = _WorkoutLog;

  factory WorkoutLog.fromJson(Map<String, dynamic> json) =>
      _$WorkoutLogFromJson(json);
}

@freezed
class ExerciseLogEntry with _$ExerciseLogEntry {
  const factory ExerciseLogEntry({
    required String exercise,
    required int setsCompleted,
    @Default([]) List<int> repsPerSet,
    // ignore: invalid_annotation_target
    @Default([]) @JsonKey(fromJson: _weightListFromJson) List<double> weightPerSet,
    required String weightUnit,
  }) = _ExerciseLogEntry;

  factory ExerciseLogEntry.fromJson(Map<String, dynamic> json) =>
      _$ExerciseLogEntryFromJson(json);
}

List<double> _weightListFromJson(dynamic json) {
  if (json == null) return [];
  return (json as List).map((e) => (e as num).toDouble()).toList();
}

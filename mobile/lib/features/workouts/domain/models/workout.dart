import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fitlabel/shared/models/media_file.dart';

part 'workout.freezed.dart';
part 'workout.g.dart';

@freezed
class WorkoutDetail with _$WorkoutDetail {
  const factory WorkoutDetail({
    required String id,
    required String title,
    String? description,
    int? estimatedDurationMinutes,
    MediaFile? coverImage,
    required List<ExerciseEntry> exerciseEntries,
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
  }) = _WorkoutLog;

  factory WorkoutLog.fromJson(Map<String, dynamic> json) =>
      _$WorkoutLogFromJson(json);
}

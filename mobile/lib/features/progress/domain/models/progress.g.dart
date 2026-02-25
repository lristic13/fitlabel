// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutHistoryEntryImpl _$$WorkoutHistoryEntryImplFromJson(
  Map<String, dynamic> json,
) => _$WorkoutHistoryEntryImpl(
  id: json['id'] as String,
  workoutTitle: json['workout_title'] as String,
  startedAt: DateTime.parse(json['started_at'] as String),
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
  durationSeconds: (json['duration_seconds'] as num?)?.toInt(),
  notes: json['notes'] as String? ?? '',
  exerciseLogs:
      (json['exercise_logs'] as List<dynamic>?)
          ?.map((e) => ExerciseLogEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$WorkoutHistoryEntryImplToJson(
  _$WorkoutHistoryEntryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'workout_title': instance.workoutTitle,
  'started_at': instance.startedAt.toIso8601String(),
  'completed_at': instance.completedAt?.toIso8601String(),
  'duration_seconds': instance.durationSeconds,
  'notes': instance.notes,
  'exercise_logs': instance.exerciseLogs,
};

_$ExerciseLogEntryImpl _$$ExerciseLogEntryImplFromJson(
  Map<String, dynamic> json,
) => _$ExerciseLogEntryImpl(
  exerciseName: json['exercise_name'] as String,
  setsCompleted: (json['sets_completed'] as num).toInt(),
  repsPerSet:
      (json['reps_per_set'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  weightPerSet:
      (json['weight_per_set'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList() ??
      const [],
  weightUnit: json['weight_unit'] as String? ?? 'KG',
);

Map<String, dynamic> _$$ExerciseLogEntryImplToJson(
  _$ExerciseLogEntryImpl instance,
) => <String, dynamic>{
  'exercise_name': instance.exerciseName,
  'sets_completed': instance.setsCompleted,
  'reps_per_set': instance.repsPerSet,
  'weight_per_set': instance.weightPerSet,
  'weight_unit': instance.weightUnit,
};

_$ProgressStatsImpl _$$ProgressStatsImplFromJson(Map<String, dynamic> json) =>
    _$ProgressStatsImpl(
      totalWorkouts: (json['total_workouts'] as num).toInt(),
      totalDurationSeconds: (json['total_duration_seconds'] as num).toInt(),
      currentStreak: (json['current_streak'] as num).toInt(),
      longestStreak: (json['longest_streak'] as num).toInt(),
      activePrograms: (json['active_programs'] as num).toInt(),
    );

Map<String, dynamic> _$$ProgressStatsImplToJson(_$ProgressStatsImpl instance) =>
    <String, dynamic>{
      'total_workouts': instance.totalWorkouts,
      'total_duration_seconds': instance.totalDurationSeconds,
      'current_streak': instance.currentStreak,
      'longest_streak': instance.longestStreak,
      'active_programs': instance.activePrograms,
    };

_$PaginatedHistoryImpl _$$PaginatedHistoryImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedHistoryImpl(
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => WorkoutHistoryEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$PaginatedHistoryImplToJson(
  _$PaginatedHistoryImpl instance,
) => <String, dynamic>{
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

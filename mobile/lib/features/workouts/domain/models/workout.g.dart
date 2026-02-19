// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutDetailImpl _$$WorkoutDetailImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutDetailImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      estimatedDurationMinutes: (json['estimated_duration_minutes'] as num?)
          ?.toInt(),
      coverImage: json['cover_image'] == null
          ? null
          : MediaFile.fromJson(json['cover_image'] as Map<String, dynamic>),
      exerciseEntries: (json['exercise_entries'] as List<dynamic>)
          .map((e) => ExerciseEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WorkoutDetailImplToJson(_$WorkoutDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'estimated_duration_minutes': instance.estimatedDurationMinutes,
      'cover_image': instance.coverImage,
      'exercise_entries': instance.exerciseEntries,
    };

_$ExerciseEntryImpl _$$ExerciseEntryImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseEntryImpl(
      exercise: ExerciseBrief.fromJson(
        json['exercise'] as Map<String, dynamic>,
      ),
      ordering: (json['ordering'] as num).toInt(),
      sets: (json['sets'] as num).toInt(),
      reps: json['reps'] as String,
      restSeconds: (json['rest_seconds'] as num).toInt(),
      notes: json['notes'] as String?,
      supersetGroup: (json['superset_group'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ExerciseEntryImplToJson(_$ExerciseEntryImpl instance) =>
    <String, dynamic>{
      'exercise': instance.exercise,
      'ordering': instance.ordering,
      'sets': instance.sets,
      'reps': instance.reps,
      'rest_seconds': instance.restSeconds,
      'notes': instance.notes,
      'superset_group': instance.supersetGroup,
    };

_$ExerciseBriefImpl _$$ExerciseBriefImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseBriefImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      muscleGroups: (json['muscle_groups'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      equipment: json['equipment'] as String?,
      demoImage: json['demo_image'] == null
          ? null
          : MediaFile.fromJson(json['demo_image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ExerciseBriefImplToJson(_$ExerciseBriefImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'muscle_groups': instance.muscleGroups,
      'equipment': instance.equipment,
      'demo_image': instance.demoImage,
    };

_$WorkoutLogImpl _$$WorkoutLogImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutLogImpl(
      id: json['id'] as String,
      workout: json['workout'] as String,
      startedAt: DateTime.parse(json['started_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      durationSeconds: (json['duration_seconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$WorkoutLogImplToJson(_$WorkoutLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workout': instance.workout,
      'started_at': instance.startedAt.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
      'duration_seconds': instance.durationSeconds,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgramImpl _$$ProgramImplFromJson(Map<String, dynamic> json) =>
    _$ProgramImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      difficulty: json['difficulty'] as String,
      durationWeeks: (json['duration_weeks'] as num).toInt(),
      isFree: json['is_free'] as bool,
      coverImage: json['cover_image'] == null
          ? null
          : MediaFile.fromJson(json['cover_image'] as Map<String, dynamic>),
      ordering: (json['ordering'] as num).toInt(),
    );

Map<String, dynamic> _$$ProgramImplToJson(_$ProgramImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'difficulty': instance.difficulty,
      'duration_weeks': instance.durationWeeks,
      'is_free': instance.isFree,
      'cover_image': instance.coverImage,
      'ordering': instance.ordering,
    };

_$ProgramDetailImpl _$$ProgramDetailImplFromJson(Map<String, dynamic> json) =>
    _$ProgramDetailImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      difficulty: json['difficulty'] as String,
      durationWeeks: (json['duration_weeks'] as num).toInt(),
      isFree: json['is_free'] as bool,
      coverImage: json['cover_image'] == null
          ? null
          : MediaFile.fromJson(json['cover_image'] as Map<String, dynamic>),
      weeks: (json['weeks'] as List<dynamic>)
          .map((e) => ProgramWeek.fromJson(e as Map<String, dynamic>))
          .toList(),
      completedDayIds:
          (json['completed_day_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ProgramDetailImplToJson(_$ProgramDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'difficulty': instance.difficulty,
      'duration_weeks': instance.durationWeeks,
      'is_free': instance.isFree,
      'cover_image': instance.coverImage,
      'weeks': instance.weeks,
      'completed_day_ids': instance.completedDayIds,
    };

_$ProgramWeekImpl _$$ProgramWeekImplFromJson(Map<String, dynamic> json) =>
    _$ProgramWeekImpl(
      id: (json['id'] as num).toInt(),
      weekNumber: (json['week_number'] as num).toInt(),
      title: json['title'] as String,
      days: (json['days'] as List<dynamic>)
          .map((e) => ProgramDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProgramWeekImplToJson(_$ProgramWeekImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'week_number': instance.weekNumber,
      'title': instance.title,
      'days': instance.days,
    };

_$ProgramDayImpl _$$ProgramDayImplFromJson(Map<String, dynamic> json) =>
    _$ProgramDayImpl(
      id: (json['id'] as num).toInt(),
      dayNumber: (json['day_number'] as num).toInt(),
      title: json['title'] as String,
      workoutId: json['workout_id'] as String?,
      workoutTitle: json['workout_title'] as String?,
      isRestDay: json['is_rest_day'] as bool,
    );

Map<String, dynamic> _$$ProgramDayImplToJson(_$ProgramDayImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day_number': instance.dayNumber,
      'title': instance.title,
      'workout_id': instance.workoutId,
      'workout_title': instance.workoutTitle,
      'is_rest_day': instance.isRestDay,
    };

_$ProgramProgressImpl _$$ProgramProgressImplFromJson(
  Map<String, dynamic> json,
) => _$ProgramProgressImpl(
  id: json['id'] as String,
  currentWeek: (json['current_week'] as num).toInt(),
  currentDay: (json['current_day'] as num).toInt(),
  startedAt: DateTime.parse(json['started_at'] as String),
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
  isActive: json['is_active'] as bool,
);

Map<String, dynamic> _$$ProgramProgressImplToJson(
  _$ProgramProgressImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'current_week': instance.currentWeek,
  'current_day': instance.currentDay,
  'started_at': instance.startedAt.toIso8601String(),
  'completed_at': instance.completedAt?.toIso8601String(),
  'is_active': instance.isActive,
};

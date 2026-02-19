import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fitlabel/shared/models/media_file.dart';

part 'program.freezed.dart';
part 'program.g.dart';

/// Lean model for the programs list.
@freezed
class Program with _$Program {
  const factory Program({
    required String id,
    required String title,
    required String difficulty,
    required int durationWeeks,
    required bool isFree,
    MediaFile? coverImage,
    required int ordering,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);
}

/// Full model for program detail (with nested weeks/days).
@freezed
class ProgramDetail with _$ProgramDetail {
  const factory ProgramDetail({
    required String id,
    required String title,
    required String description,
    required String difficulty,
    required int durationWeeks,
    required bool isFree,
    MediaFile? coverImage,
    required List<ProgramWeek> weeks,
  }) = _ProgramDetail;

  factory ProgramDetail.fromJson(Map<String, dynamic> json) =>
      _$ProgramDetailFromJson(json);
}

@freezed
class ProgramWeek with _$ProgramWeek {
  const factory ProgramWeek({
    required int id,
    required int weekNumber,
    required String title,
    required List<ProgramDay> days,
  }) = _ProgramWeek;

  factory ProgramWeek.fromJson(Map<String, dynamic> json) =>
      _$ProgramWeekFromJson(json);
}

@freezed
class ProgramDay with _$ProgramDay {
  const factory ProgramDay({
    required int id,
    required int dayNumber,
    required String title,
    String? workoutId,
    String? workoutTitle,
    required bool isRestDay,
  }) = _ProgramDay;

  factory ProgramDay.fromJson(Map<String, dynamic> json) =>
      _$ProgramDayFromJson(json);
}

@freezed
class ProgramProgress with _$ProgramProgress {
  const factory ProgramProgress({
    required String id,
    required int currentWeek,
    required int currentDay,
    required DateTime startedAt,
    DateTime? completedAt,
    required bool isActive,
  }) = _ProgramProgress;

  factory ProgramProgress.fromJson(Map<String, dynamic> json) =>
      _$ProgramProgressFromJson(json);
}

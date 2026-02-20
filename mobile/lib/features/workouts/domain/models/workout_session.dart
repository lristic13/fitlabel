import 'package:freezed_annotation/freezed_annotation.dart';

import 'workout.dart';

part 'workout_session.freezed.dart';

@freezed
class WorkoutSession with _$WorkoutSession {
  const WorkoutSession._();

  const factory WorkoutSession({
    required WorkoutLog workoutLog,
    required Map<String, ExerciseSessionLog> exerciseLogs,
  }) = _WorkoutSession;

  int get completedExerciseCount =>
      exerciseLogs.values.where((e) => e.isComplete).length;

  int get totalExerciseCount => exerciseLogs.length;

  double get progressFraction =>
      totalExerciseCount == 0
          ? 0
          : completedExerciseCount / totalExerciseCount;

  bool get isAllComplete =>
      totalExerciseCount > 0 &&
      completedExerciseCount == totalExerciseCount;
}

@freezed
class ExerciseSessionLog with _$ExerciseSessionLog {
  const ExerciseSessionLog._();

  const factory ExerciseSessionLog({
    required String exerciseId,
    required int targetSets,
    required List<SetLog> sets,
  }) = _ExerciseSessionLog;

  int get completedSetsCount => sets.where((s) => s.completed).length;

  bool get isComplete => completedSetsCount >= targetSets;
}

@freezed
class SetLog with _$SetLog {
  const factory SetLog({
    @Default(0) int reps,
    @Default(0.0) double weight,
    @Default(false) bool completed,
  }) = _SetLog;
}

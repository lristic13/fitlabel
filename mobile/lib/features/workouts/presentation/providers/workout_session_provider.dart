import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fitlabel/features/workouts/domain/models/workout.dart';
import 'package:fitlabel/features/workouts/domain/models/workout_session.dart';
import 'package:fitlabel/features/workouts/presentation/providers/workouts_provider.dart';

part 'workout_session_provider.g.dart';

/// Manages the active workout session for a given workout.
/// Tracks per-exercise set completion and auto-completes when all done.
@riverpod
class WorkoutSessionNotifier extends _$WorkoutSessionNotifier {
  @override
  AsyncValue<WorkoutSession?> build(String workoutId) {
    return const AsyncData(null);
  }

  /// Parse target reps from string (e.g. "12", "8-12", "AMRAP").
  int _parseTargetReps(String reps) {
    final parsed = int.tryParse(reps);
    if (parsed != null) return parsed;
    if (reps.contains('-')) {
      final upper = int.tryParse(reps.split('-').last.trim());
      if (upper != null) return upper;
    }
    return 0;
  }

  Future<void> start(List<ExerciseEntry> entries,
      {String? programDayId}) async {
    state = const AsyncLoading();
    final repo = ref.read(workoutsRepositoryProvider);
    try {
      final log =
          await repo.startWorkout(workoutId, programDayId: programDayId);

      final exerciseLogs = <String, ExerciseSessionLog>{};
      for (final entry in entries) {
        final targetReps = _parseTargetReps(entry.reps);
        exerciseLogs[entry.exercise.id] = ExerciseSessionLog(
          exerciseId: entry.exercise.id,
          targetSets: entry.sets,
          sets: List.generate(
            entry.sets,
            (_) => SetLog(reps: targetReps),
          ),
        );
      }

      state = AsyncData(WorkoutSession(
        workoutLog: log,
        exerciseLogs: exerciseLogs,
      ));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Update reps and weight for a specific set before completing it.
  void updateSet(String exerciseId, int setIndex, int reps, double weight) {
    final session = state.valueOrNull;
    if (session == null) return;

    final exerciseLog = session.exerciseLogs[exerciseId];
    if (exerciseLog == null) return;

    final updatedSets = List<SetLog>.from(exerciseLog.sets);
    updatedSets[setIndex] = updatedSets[setIndex].copyWith(
      reps: reps,
      weight: weight,
    );

    state = AsyncData(session.copyWith(
      exerciseLogs: {
        ...session.exerciseLogs,
        exerciseId: exerciseLog.copyWith(sets: updatedSets),
      },
    ));
  }

  /// Toggle a set's completed status.
  void toggleSet(String exerciseId, int setIndex) {
    final session = state.valueOrNull;
    if (session == null) return;

    final exerciseLog = session.exerciseLogs[exerciseId];
    if (exerciseLog == null) return;

    final updatedSets = List<SetLog>.from(exerciseLog.sets);
    final current = updatedSets[setIndex];
    updatedSets[setIndex] = current.copyWith(completed: !current.completed);

    final updatedSession = session.copyWith(
      exerciseLogs: {
        ...session.exerciseLogs,
        exerciseId: exerciseLog.copyWith(sets: updatedSets),
      },
    );

    state = AsyncData(updatedSession);

    // Auto-complete when all exercises are done
    if (updatedSession.isAllComplete) {
      _submitComplete(updatedSession);
    }
  }

  /// Populate session from a previously completed workout log.
  void loadFromLog(WorkoutLog log, List<ExerciseEntry> entries) {
    final logMap = <String, ExerciseLogEntry>{};
    for (final exerciseLog in log.exerciseLogs) {
      logMap[exerciseLog.exercise] = exerciseLog;
    }

    final exerciseLogs = <String, ExerciseSessionLog>{};
    for (final entry in entries) {
      final exerciseLog = logMap[entry.exercise.id];

      if (exerciseLog != null) {
        final setsCount = exerciseLog.setsCompleted;
        exerciseLogs[entry.exercise.id] = ExerciseSessionLog(
          exerciseId: entry.exercise.id,
          targetSets: entry.sets,
          sets: List.generate(
            setsCount,
            (i) => SetLog(
              reps: i < exerciseLog.repsPerSet.length
                  ? exerciseLog.repsPerSet[i]
                  : 0,
              weight: i < exerciseLog.weightPerSet.length
                  ? exerciseLog.weightPerSet[i]
                  : 0.0,
              completed: true,
            ),
          ),
        );
      } else {
        exerciseLogs[entry.exercise.id] = ExerciseSessionLog(
          exerciseId: entry.exercise.id,
          targetSets: entry.sets,
          sets: List.generate(entry.sets, (_) => const SetLog()),
        );
      }
    }

    state = AsyncData(WorkoutSession(
      workoutLog: log,
      exerciseLogs: exerciseLogs,
    ));
  }

  /// Complete the workout early (before all exercises are done).
  Future<void> finishEarly() async {
    final session = state.valueOrNull;
    if (session == null) return;
    await _submitComplete(session);
  }

  Future<void> _submitComplete(WorkoutSession session) async {
    state = const AsyncLoading();
    final repo = ref.read(workoutsRepositoryProvider);
    try {
      final exerciseLogs = session.exerciseLogs.entries.map((entry) {
        final log = entry.value;
        final completedSets = log.sets.where((s) => s.completed).toList();
        return {
          'exercise_id': log.exerciseId,
          'sets_completed': completedSets.length,
          'reps_per_set': completedSets.map((s) => s.reps).toList(),
          'weight_per_set': completedSets.map((s) => s.weight).toList(),
          'weight_unit': 'KG',
        };
      }).toList();

      final completedLog = await repo.completeWorkout(
        workoutId: workoutId,
        workoutLogId: session.workoutLog.id,
        exerciseLogs: exerciseLogs,
      );

      state = AsyncData(session.copyWith(workoutLog: completedLog));
    } catch (_) {
      // Restore session state so user doesn't lose progress
      state = AsyncData(session);
    }
  }
}

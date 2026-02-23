import 'package:fitlabel/features/workouts/domain/models/workout.dart';

abstract class WorkoutsRepository {
  Future<List<WorkoutBrief>> getWorkouts({
    String? search,
    List<String>? muscleGroups,
  });
  Future<List<MuscleGroup>> getMuscleGroups();
  Future<WorkoutDetail> getWorkoutDetail(String id, {String? programDayId});
  Future<WorkoutLog> startWorkout(String workoutId, {String? programDayId});
  Future<WorkoutLog> completeWorkout({
    required String workoutId,
    required String workoutLogId,
    String? notes,
    List<Map<String, dynamic>>? exerciseLogs,
  });
}

import 'package:fitlabel/features/workouts/domain/models/workout.dart';

abstract class WorkoutsRepository {
  Future<WorkoutDetail> getWorkoutDetail(String id);
  Future<WorkoutLog> startWorkout(String workoutId, {String? programDayId});
  Future<WorkoutLog> completeWorkout({
    required String workoutId,
    required String workoutLogId,
    String? notes,
    List<Map<String, dynamic>>? exerciseLogs,
  });
}

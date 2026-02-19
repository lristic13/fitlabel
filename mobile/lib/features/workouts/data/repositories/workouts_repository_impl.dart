import 'package:fitlabel/features/workouts/data/datasources/workouts_remote_data_source.dart';
import 'package:fitlabel/features/workouts/domain/models/workout.dart';
import 'package:fitlabel/features/workouts/domain/repositories/workouts_repository.dart';

class WorkoutsRepositoryImpl implements WorkoutsRepository {
  final WorkoutsRemoteDataSource _dataSource;

  WorkoutsRepositoryImpl({required WorkoutsRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<WorkoutDetail> getWorkoutDetail(String id) async {
    final json = await _dataSource.getWorkoutDetail(id);
    return WorkoutDetail.fromJson(json);
  }

  @override
  Future<WorkoutLog> startWorkout(String workoutId,
      {String? programDayId}) async {
    final json = await _dataSource.startWorkout(workoutId,
        programDayId: programDayId);
    return WorkoutLog.fromJson(json);
  }

  @override
  Future<WorkoutLog> completeWorkout({
    required String workoutId,
    required String workoutLogId,
    String? notes,
    List<Map<String, dynamic>>? exerciseLogs,
  }) async {
    final json = await _dataSource.completeWorkout(
      workoutId: workoutId,
      workoutLogId: workoutLogId,
      notes: notes,
      exerciseLogs: exerciseLogs,
    );
    return WorkoutLog.fromJson(json);
  }
}

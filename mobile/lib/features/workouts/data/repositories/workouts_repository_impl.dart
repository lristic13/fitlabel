import 'package:fitlabel/features/workouts/data/datasources/workouts_remote_data_source.dart';
import 'package:fitlabel/features/workouts/domain/models/workout.dart';
import 'package:fitlabel/features/workouts/domain/repositories/workouts_repository.dart';

class WorkoutsRepositoryImpl implements WorkoutsRepository {
  final WorkoutsRemoteDataSource _dataSource;

  WorkoutsRepositoryImpl({required WorkoutsRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<List<WorkoutBrief>> getWorkouts({
    String? search,
    List<String>? muscleGroups,
  }) async {
    final list = await _dataSource.getWorkouts(
      search: search,
      muscleGroups: muscleGroups,
    );
    return list
        .map((json) => WorkoutBrief.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<MuscleGroup>> getMuscleGroups() async {
    final list = await _dataSource.getMuscleGroups();
    return list
        .map((json) => MuscleGroup.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<WorkoutDetail> getWorkoutDetail(String id,
      {String? programDayId}) async {
    final json =
        await _dataSource.getWorkoutDetail(id, programDayId: programDayId);
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

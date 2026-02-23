import 'package:fitlabel/config/api_config.dart';
import 'package:fitlabel/core/network/api_client.dart';

class WorkoutsRemoteDataSource {
  final ApiClient _client;

  WorkoutsRemoteDataSource({required ApiClient client}) : _client = client;

  Future<List<dynamic>> getWorkouts({
    String? search,
    List<String>? muscleGroups,
  }) {
    final queryParams = <String, dynamic>{};
    if (search != null && search.isNotEmpty) queryParams['search'] = search;
    if (muscleGroups != null && muscleGroups.isNotEmpty) {
      queryParams['muscle_groups'] = muscleGroups.join(',');
    }
    return _client.getList(
      ApiConfig.workouts,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
  }

  Future<List<dynamic>> getMuscleGroups() {
    return _client.getRawList(ApiConfig.muscleGroups);
  }

  Future<Map<String, dynamic>> getWorkoutDetail(String id,
      {String? programDayId}) {
    final queryParams = <String, dynamic>{};
    if (programDayId != null) queryParams['program_day_id'] = programDayId;
    return _client.get(ApiConfig.workoutDetail(id),
        queryParameters: queryParams.isNotEmpty ? queryParams : null);
  }

  Future<Map<String, dynamic>> startWorkout(
    String workoutId, {
    String? programDayId,
  }) {
    final data = <String, dynamic>{};
    if (programDayId != null) data['program_day_id'] = programDayId;
    return _client.post(ApiConfig.workoutStart(workoutId), data: data);
  }

  Future<Map<String, dynamic>> completeWorkout({
    required String workoutId,
    required String workoutLogId,
    String? notes,
    List<Map<String, dynamic>>? exerciseLogs,
  }) {
    return _client.post(
      ApiConfig.workoutComplete(workoutId),
      data: {
        'workout_log_id': workoutLogId,
        'notes': notes ?? '',
        'exercise_logs': exerciseLogs ?? [],
      },
    );
  }
}

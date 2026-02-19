import 'package:fitlabel/config/api_config.dart';
import 'package:fitlabel/core/network/api_client.dart';

class WorkoutsRemoteDataSource {
  final ApiClient _client;

  WorkoutsRemoteDataSource({required ApiClient client}) : _client = client;

  Future<Map<String, dynamic>> getWorkoutDetail(String id) {
    return _client.get(ApiConfig.workoutDetail(id));
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

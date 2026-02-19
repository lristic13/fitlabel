import 'package:fitlabel/config/api_config.dart';
import 'package:fitlabel/core/network/api_client.dart';

class ProgramsRemoteDataSource {
  final ApiClient _client;

  ProgramsRemoteDataSource({required ApiClient client}) : _client = client;

  Future<List<dynamic>> getPrograms({String? difficulty}) {
    final queryParams = <String, dynamic>{};
    if (difficulty != null) queryParams['difficulty'] = difficulty;
    return _client.getList(ApiConfig.programs, queryParameters: queryParams);
  }

  Future<Map<String, dynamic>> getProgramDetail(String id) {
    return _client.get(ApiConfig.programDetail(id));
  }

  Future<Map<String, dynamic>> enroll(String programId) {
    return _client.post(ApiConfig.programEnroll(programId));
  }

  Future<Map<String, dynamic>> getProgress(String programId) {
    return _client.get(ApiConfig.programProgress(programId));
  }
}

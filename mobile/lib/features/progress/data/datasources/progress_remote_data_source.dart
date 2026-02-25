import 'package:fitlabel/config/api_config.dart';
import 'package:fitlabel/core/network/api_client.dart';

class ProgressRemoteDataSource {
  final ApiClient _client;

  ProgressRemoteDataSource({required ApiClient client}) : _client = client;

  Future<Map<String, dynamic>> getHistory({String? cursor}) {
    if (cursor != null) {
      return _client.getPaginated(ApiConfig.progressHistory, fullUrl: cursor);
    }
    return _client.getPaginated(ApiConfig.progressHistory);
  }

  Future<Map<String, dynamic>> getStats() {
    return _client.get(ApiConfig.progressStats);
  }
}

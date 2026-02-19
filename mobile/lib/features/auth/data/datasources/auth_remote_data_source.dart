import 'package:fitlabel/config/api_config.dart';
import 'package:fitlabel/core/network/api_client.dart';

class AuthRemoteDataSource {
  final ApiClient _client;

  AuthRemoteDataSource({required ApiClient client}) : _client = client;

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) {
    return _client.post(
      ApiConfig.login,
      data: {'email': email, 'password': password},
    );
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String tenantSlug,
  }) {
    return _client.post(
      ApiConfig.register,
      data: {
        'email': email,
        'password': password,
        'tenant_slug': tenantSlug,
      },
    );
  }

  Future<Map<String, dynamic>> getProfile() {
    return _client.get(ApiConfig.me);
  }

  Future<Map<String, dynamic>> updateProfile({
    required Map<String, dynamic> data,
  }) {
    return _client.patch(ApiConfig.me, data: data);
  }
}

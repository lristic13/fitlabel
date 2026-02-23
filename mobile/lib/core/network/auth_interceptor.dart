import 'package:dio/dio.dart';
import 'package:fitlabel/config/api_config.dart';
import 'package:fitlabel/config/app_config.dart';
import 'package:fitlabel/core/storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorage _storage;
  final Dio _dio;

  AuthInterceptor({
    required SecureStorage storage,
    required Dio dio,
  })  : _storage = storage,
        _dio = dio;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Attach access token if available
    final accessToken = await _storage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Attach tenant slug (fall back to hardcoded config if not yet persisted)
    final tenantSlug = await _storage.getTenantSlug() ?? AppConfig.tenantSlug;
    options.headers['X-Tenant-Slug'] = tenantSlug;

    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    // Don't try to refresh if this was already a refresh request
    if (err.requestOptions.path == ApiConfig.tokenRefresh) {
      return handler.next(err);
    }

    // Try to refresh the token
    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken == null) {
      return handler.next(err);
    }

    try {
      final response = await _dio.post(
        ApiConfig.tokenRefresh,
        data: {'refresh': refreshToken},
      );

      final newAccess = response.data['access'] as String;
      final newRefresh = response.data['refresh'] as String?;

      await _storage.setAccessToken(newAccess);
      if (newRefresh != null) {
        await _storage.setRefreshToken(newRefresh);
      }

      // Retry the original request with the new token
      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] = 'Bearer $newAccess';

      final retryResponse = await _dio.fetch(retryOptions);
      return handler.resolve(retryResponse);
    } on DioException {
      // Refresh failed — clear tokens, let the error propagate
      await _storage.clearAll();
      return handler.next(err);
    }
  }
}

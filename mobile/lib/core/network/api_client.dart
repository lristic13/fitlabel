import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fitlabel/config/api_config.dart';
import 'package:fitlabel/core/errors/exceptions.dart';
import 'package:fitlabel/core/network/auth_interceptor.dart';
import 'package:fitlabel/core/storage/secure_storage.dart';

class ApiClient {
  late final Dio dio;

  ApiClient({required SecureStorage storage}) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      AuthInterceptor(storage: storage, dio: dio),
    );

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ));
    }
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<dynamic>> getList(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      final data = response.data as Map<String, dynamic>;
      return data['results'] as List<dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<dynamic>> getRawList(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Fetch a cursor-paginated endpoint, returning the full response
  /// with `next`, `previous`, and `results` keys.
  Future<Map<String, dynamic>> getPaginated(
    String path, {
    Map<String, dynamic>? queryParameters,
    String? fullUrl,
  }) async {
    try {
      final Response response;
      if (fullUrl != null) {
        response = await dio.getUri(Uri.parse(fullUrl));
      } else {
        response =
            await dio.get(path, queryParameters: queryParameters);
      }
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.post(path, data: data);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.patch(path, data: data);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout) {
      return const NetworkException();
    }

    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    if (statusCode == 401) {
      return const UnauthorizedException();
    }

    String message = 'Something went wrong';
    if (data is Map<String, dynamic>) {
      if (data.containsKey('detail')) {
        // DRF detail error: {"detail": "Not found."}
        message = data['detail'].toString();
      } else {
        // DRF field validation errors: {"email": ["This field is required."]}
        final errors = data.entries
            .map((e) => e.value is List ? '${e.key}: ${(e.value as List).join(', ')}' : '${e.key}: ${e.value}')
            .join('\n');
        if (errors.isNotEmpty) message = errors;
      }
    }

    return ServerException(message: message, statusCode: statusCode);
  }
}

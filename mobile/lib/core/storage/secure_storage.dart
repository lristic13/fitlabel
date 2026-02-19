import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _tenantSlugKey = 'tenant_slug';

  SecureStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  // Access token
  Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);
  Future<void> setAccessToken(String token) =>
      _storage.write(key: _accessTokenKey, value: token);

  // Refresh token
  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);
  Future<void> setRefreshToken(String token) =>
      _storage.write(key: _refreshTokenKey, value: token);

  // Tenant slug
  Future<String?> getTenantSlug() => _storage.read(key: _tenantSlugKey);
  Future<void> setTenantSlug(String slug) =>
      _storage.write(key: _tenantSlugKey, value: slug);

  // Save both tokens at once
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      setAccessToken(accessToken),
      setRefreshToken(refreshToken),
    ]);
  }

  // Clear everything on logout
  Future<void> clearAll() => _storage.deleteAll();
}

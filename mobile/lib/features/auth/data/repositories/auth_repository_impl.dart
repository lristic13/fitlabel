import 'package:fitlabel/core/storage/secure_storage.dart';
import 'package:fitlabel/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fitlabel/features/auth/domain/models/auth_tokens.dart';
import 'package:fitlabel/features/auth/domain/models/user.dart';
import 'package:fitlabel/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;
  final SecureStorage _storage;

  AuthRepositoryImpl({
    required AuthRemoteDataSource dataSource,
    required SecureStorage storage,
  })  : _dataSource = dataSource,
        _storage = storage;

  @override
  Future<AuthTokens> login({
    required String email,
    required String password,
  }) async {
    final json = await _dataSource.login(email: email, password: password);
    final tokens = AuthTokens.fromJson(json);
    await _storage.saveTokens(
      accessToken: tokens.access,
      refreshToken: tokens.refresh,
    );
    return tokens;
  }

  @override
  Future<AuthTokens> register({
    required String email,
    required String password,
    required String tenantSlug,
  }) async {
    final json = await _dataSource.register(
      email: email,
      password: password,
      tenantSlug: tenantSlug,
    );
    final tokens = AuthTokens.fromJson(json);
    await _storage.saveTokens(
      accessToken: tokens.access,
      refreshToken: tokens.refresh,
    );
    await _storage.setTenantSlug(tenantSlug);
    return tokens;
  }

  @override
  Future<User> getProfile() async {
    final json = await _dataSource.getProfile();
    return User.fromJson(json);
  }

  @override
  Future<User> updateProfile({
    String? firstName,
    String? lastName,
  }) async {
    final data = <String, dynamic>{};
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;

    final json = await _dataSource.updateProfile(data: data);
    return User.fromJson(json);
  }

  @override
  Future<void> logout() async {
    await _storage.clearAll();
  }
}

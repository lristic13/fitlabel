import 'package:fitlabel/features/auth/domain/models/auth_tokens.dart';
import 'package:fitlabel/features/auth/domain/models/user.dart';

abstract class AuthRepository {
  Future<AuthTokens> login({
    required String email,
    required String password,
  });

  Future<AuthTokens> register({
    required String email,
    required String password,
    required String tenantSlug,
  });

  Future<User> getProfile();

  Future<User> updateProfile({
    String? firstName,
    String? lastName,
  });

  Future<void> logout();
}

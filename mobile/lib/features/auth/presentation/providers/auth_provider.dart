import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fitlabel/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fitlabel/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fitlabel/features/auth/domain/models/user.dart';
import 'package:fitlabel/features/auth/domain/repositories/auth_repository.dart';
import 'package:fitlabel/shared/providers/core_providers.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final client = ref.watch(apiClientProvider);
  return AuthRemoteDataSource(client: client);
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final dataSource = ref.watch(authRemoteDataSourceProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthRepositoryImpl(dataSource: dataSource, storage: storage);
}

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<User?> build() async {
    final storage = ref.read(secureStorageProvider);
    final token = await storage.getAccessToken();
    if (token == null) return null;

    try {
      final repo = ref.read(authRepositoryProvider);
      return await repo.getProfile();
    } catch (_) {
      await storage.clearAll();
      return null;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      await repo.login(email: email, password: password);
      return await repo.getProfile();
    });
  }

  Future<void> register({
    required String email,
    required String password,
    required String tenantSlug,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      await repo.register(
        email: email,
        password: password,
        tenantSlug: tenantSlug,
      );
      return await repo.getProfile();
    });
  }

  Future<void> logout() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.logout();
    state = const AsyncData(null);
  }
}

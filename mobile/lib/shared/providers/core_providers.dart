import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fitlabel/core/network/api_client.dart';
import 'package:fitlabel/core/storage/secure_storage.dart';

part 'core_providers.g.dart';

@Riverpod(keepAlive: true)
SecureStorage secureStorage(Ref ref) {
  return SecureStorage();
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final storage = ref.watch(secureStorageProvider);
  return ApiClient(storage: storage);
}

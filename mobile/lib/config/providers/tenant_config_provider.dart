import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fitlabel/config/api_config.dart';
import 'package:fitlabel/config/app_config.dart';
import 'package:fitlabel/config/models/tenant_config.dart';
import 'package:fitlabel/shared/providers/core_providers.dart';

part 'tenant_config_provider.g.dart';

@Riverpod(keepAlive: true)
class TenantConfigNotifier extends _$TenantConfigNotifier {
  @override
  Future<TenantConfig> build() async {
    // Ensure tenant slug is saved for the auth interceptor
    final storage = ref.read(secureStorageProvider);
    await storage.setTenantSlug(AppConfig.tenantSlug);

    final client = ref.read(apiClientProvider);
    final json = await client.get(ApiConfig.tenantConfig);
    return TenantConfig.fromJson(json);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(apiClientProvider);
      final json = await client.get(ApiConfig.tenantConfig);
      return TenantConfig.fromJson(json);
    });
  }
}

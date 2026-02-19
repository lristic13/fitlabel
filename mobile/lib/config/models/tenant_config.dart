import 'package:freezed_annotation/freezed_annotation.dart';

part 'tenant_config.freezed.dart';
part 'tenant_config.g.dart';

@freezed
class TenantConfig with _$TenantConfig {
  const factory TenantConfig({
    required String id,
    required String name,
    required String slug,
    required String appName,
    String? primaryColor,
    String? secondaryColor,
    String? logo,
    String? splashImage,
  }) = _TenantConfig;

  factory TenantConfig.fromJson(Map<String, dynamic> json) =>
      _$TenantConfigFromJson(json);
}

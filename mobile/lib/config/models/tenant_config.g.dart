// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenantConfigImpl _$$TenantConfigImplFromJson(Map<String, dynamic> json) =>
    _$TenantConfigImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      appName: json['app_name'] as String,
      primaryColor: json['primary_color'] as String?,
      secondaryColor: json['secondary_color'] as String?,
      logo: json['logo'] as String?,
      splashImage: json['splash_image'] as String?,
    );

Map<String, dynamic> _$$TenantConfigImplToJson(_$TenantConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'app_name': instance.appName,
      'primary_color': instance.primaryColor,
      'secondary_color': instance.secondaryColor,
      'logo': instance.logo,
      'splash_image': instance.splashImage,
    };

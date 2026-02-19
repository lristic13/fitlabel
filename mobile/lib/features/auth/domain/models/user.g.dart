// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  avatar: json['avatar'] as String?,
  dateOfBirth: json['date_of_birth'] == null
      ? null
      : DateTime.parse(json['date_of_birth'] as String),
  isPremium: json['is_premium'] as bool,
  tenantSlug: json['tenant_slug'] as String?,
  dateJoined: DateTime.parse(json['date_joined'] as String),
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': instance.role,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar': instance.avatar,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
      'is_premium': instance.isPremium,
      'tenant_slug': instance.tenantSlug,
      'date_joined': instance.dateJoined.toIso8601String(),
    };

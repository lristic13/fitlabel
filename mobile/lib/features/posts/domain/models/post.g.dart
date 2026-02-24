// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  coverImage: json['cover_image'] == null
      ? null
      : MediaFile.fromJson(json['cover_image'] as Map<String, dynamic>),
  isFree: json['is_free'] as bool,
  publishedAt: json['published_at'] == null
      ? null
      : DateTime.parse(json['published_at'] as String),
);

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cover_image': instance.coverImage,
      'is_free': instance.isFree,
      'published_at': instance.publishedAt?.toIso8601String(),
    };

_$PostDetailImpl _$$PostDetailImplFromJson(Map<String, dynamic> json) =>
    _$PostDetailImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      coverImage: json['cover_image'] == null
          ? null
          : MediaFile.fromJson(json['cover_image'] as Map<String, dynamic>),
      isFree: json['is_free'] as bool,
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
    );

Map<String, dynamic> _$$PostDetailImplToJson(_$PostDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'cover_image': instance.coverImage,
      'is_free': instance.isFree,
      'published_at': instance.publishedAt?.toIso8601String(),
    };

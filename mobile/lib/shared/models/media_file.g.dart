// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MediaFileImpl _$$MediaFileImplFromJson(Map<String, dynamic> json) =>
    _$MediaFileImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      fileType: json['file_type'] as String,
      file: json['file'] as String?,
      thumbnail: json['thumbnail'] as String?,
      externalPlaybackUrl: json['external_playback_url'] as String?,
    );

Map<String, dynamic> _$$MediaFileImplToJson(_$MediaFileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'file_type': instance.fileType,
      'file': instance.file,
      'thumbnail': instance.thumbnail,
      'external_playback_url': instance.externalPlaybackUrl,
    };

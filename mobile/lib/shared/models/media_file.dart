import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_file.freezed.dart';
part 'media_file.g.dart';

@freezed
class MediaFile with _$MediaFile {
  const factory MediaFile({
    required String id,
    required String title,
    required String fileType,
    String? file,
    String? thumbnail,
    String? externalPlaybackUrl,
  }) = _MediaFile;

  factory MediaFile.fromJson(Map<String, dynamic> json) =>
      _$MediaFileFromJson(json);
}

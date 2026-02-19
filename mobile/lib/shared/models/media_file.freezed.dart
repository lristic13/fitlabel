// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MediaFile _$MediaFileFromJson(Map<String, dynamic> json) {
  return _MediaFile.fromJson(json);
}

/// @nodoc
mixin _$MediaFile {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get fileType => throw _privateConstructorUsedError;
  String? get file => throw _privateConstructorUsedError;
  String? get thumbnail => throw _privateConstructorUsedError;
  String? get externalPlaybackUrl => throw _privateConstructorUsedError;

  /// Serializes this MediaFile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediaFileCopyWith<MediaFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaFileCopyWith<$Res> {
  factory $MediaFileCopyWith(MediaFile value, $Res Function(MediaFile) then) =
      _$MediaFileCopyWithImpl<$Res, MediaFile>;
  @useResult
  $Res call({
    String id,
    String title,
    String fileType,
    String? file,
    String? thumbnail,
    String? externalPlaybackUrl,
  });
}

/// @nodoc
class _$MediaFileCopyWithImpl<$Res, $Val extends MediaFile>
    implements $MediaFileCopyWith<$Res> {
  _$MediaFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? fileType = null,
    Object? file = freezed,
    Object? thumbnail = freezed,
    Object? externalPlaybackUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            fileType: null == fileType
                ? _value.fileType
                : fileType // ignore: cast_nullable_to_non_nullable
                      as String,
            file: freezed == file
                ? _value.file
                : file // ignore: cast_nullable_to_non_nullable
                      as String?,
            thumbnail: freezed == thumbnail
                ? _value.thumbnail
                : thumbnail // ignore: cast_nullable_to_non_nullable
                      as String?,
            externalPlaybackUrl: freezed == externalPlaybackUrl
                ? _value.externalPlaybackUrl
                : externalPlaybackUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MediaFileImplCopyWith<$Res>
    implements $MediaFileCopyWith<$Res> {
  factory _$$MediaFileImplCopyWith(
    _$MediaFileImpl value,
    $Res Function(_$MediaFileImpl) then,
  ) = __$$MediaFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String fileType,
    String? file,
    String? thumbnail,
    String? externalPlaybackUrl,
  });
}

/// @nodoc
class __$$MediaFileImplCopyWithImpl<$Res>
    extends _$MediaFileCopyWithImpl<$Res, _$MediaFileImpl>
    implements _$$MediaFileImplCopyWith<$Res> {
  __$$MediaFileImplCopyWithImpl(
    _$MediaFileImpl _value,
    $Res Function(_$MediaFileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? fileType = null,
    Object? file = freezed,
    Object? thumbnail = freezed,
    Object? externalPlaybackUrl = freezed,
  }) {
    return _then(
      _$MediaFileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        fileType: null == fileType
            ? _value.fileType
            : fileType // ignore: cast_nullable_to_non_nullable
                  as String,
        file: freezed == file
            ? _value.file
            : file // ignore: cast_nullable_to_non_nullable
                  as String?,
        thumbnail: freezed == thumbnail
            ? _value.thumbnail
            : thumbnail // ignore: cast_nullable_to_non_nullable
                  as String?,
        externalPlaybackUrl: freezed == externalPlaybackUrl
            ? _value.externalPlaybackUrl
            : externalPlaybackUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MediaFileImpl implements _MediaFile {
  const _$MediaFileImpl({
    required this.id,
    required this.title,
    required this.fileType,
    this.file,
    this.thumbnail,
    this.externalPlaybackUrl,
  });

  factory _$MediaFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediaFileImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String fileType;
  @override
  final String? file;
  @override
  final String? thumbnail;
  @override
  final String? externalPlaybackUrl;

  @override
  String toString() {
    return 'MediaFile(id: $id, title: $title, fileType: $fileType, file: $file, thumbnail: $thumbnail, externalPlaybackUrl: $externalPlaybackUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaFileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType) &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.externalPlaybackUrl, externalPlaybackUrl) ||
                other.externalPlaybackUrl == externalPlaybackUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    fileType,
    file,
    thumbnail,
    externalPlaybackUrl,
  );

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaFileImplCopyWith<_$MediaFileImpl> get copyWith =>
      __$$MediaFileImplCopyWithImpl<_$MediaFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediaFileImplToJson(this);
  }
}

abstract class _MediaFile implements MediaFile {
  const factory _MediaFile({
    required final String id,
    required final String title,
    required final String fileType,
    final String? file,
    final String? thumbnail,
    final String? externalPlaybackUrl,
  }) = _$MediaFileImpl;

  factory _MediaFile.fromJson(Map<String, dynamic> json) =
      _$MediaFileImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get fileType;
  @override
  String? get file;
  @override
  String? get thumbnail;
  @override
  String? get externalPlaybackUrl;

  /// Create a copy of MediaFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediaFileImplCopyWith<_$MediaFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

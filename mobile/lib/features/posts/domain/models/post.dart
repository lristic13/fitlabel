import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fitlabel/shared/models/media_file.dart';

part 'post.freezed.dart';
part 'post.g.dart';

/// Lean model for the posts list.
@freezed
class Post with _$Post {
  const factory Post({
    required String id,
    required String title,
    MediaFile? coverImage,
    required bool isFree,
    DateTime? publishedAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

/// Full model for post detail.
@freezed
class PostDetail with _$PostDetail {
  const factory PostDetail({
    required String id,
    required String title,
    required String body,
    MediaFile? coverImage,
    required bool isFree,
    DateTime? publishedAt,
  }) = _PostDetail;

  factory PostDetail.fromJson(Map<String, dynamic> json) =>
      _$PostDetailFromJson(json);
}

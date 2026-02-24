import 'package:fitlabel/features/posts/domain/models/post.dart';

abstract class PostsRepository {
  Future<List<Post>> getPosts();
  Future<PostDetail> getPostDetail(String id);
}

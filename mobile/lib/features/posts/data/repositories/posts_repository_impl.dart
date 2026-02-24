import 'package:fitlabel/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:fitlabel/features/posts/domain/models/post.dart';
import 'package:fitlabel/features/posts/domain/repositories/posts_repository.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource _dataSource;

  PostsRepositoryImpl({required PostsRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<List<Post>> getPosts() async {
    final list = await _dataSource.getPosts();
    return list
        .map((json) => Post.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PostDetail> getPostDetail(String id) async {
    final json = await _dataSource.getPostDetail(id);
    return PostDetail.fromJson(json);
  }
}

import 'package:fitlabel/config/api_config.dart';
import 'package:fitlabel/core/network/api_client.dart';

class PostsRemoteDataSource {
  final ApiClient _client;

  PostsRemoteDataSource({required ApiClient client}) : _client = client;

  Future<List<dynamic>> getPosts() {
    return _client.getList(ApiConfig.posts);
  }

  Future<Map<String, dynamic>> getPostDetail(String id) {
    return _client.get(ApiConfig.postDetail(id));
  }
}

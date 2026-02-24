import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fitlabel/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:fitlabel/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:fitlabel/features/posts/domain/models/post.dart';
import 'package:fitlabel/features/posts/domain/repositories/posts_repository.dart';
import 'package:fitlabel/shared/providers/core_providers.dart';

part 'posts_provider.g.dart';

@Riverpod(keepAlive: true)
PostsRemoteDataSource postsRemoteDataSource(Ref ref) {
  final client = ref.watch(apiClientProvider);
  return PostsRemoteDataSource(client: client);
}

@Riverpod(keepAlive: true)
PostsRepository postsRepository(Ref ref) {
  final dataSource = ref.watch(postsRemoteDataSourceProvider);
  return PostsRepositoryImpl(dataSource: dataSource);
}

@riverpod
Future<List<Post>> postsList(Ref ref) {
  final repo = ref.watch(postsRepositoryProvider);
  return repo.getPosts();
}

@riverpod
Future<PostDetail> postDetail(Ref ref, String id) {
  final repo = ref.watch(postsRepositoryProvider);
  return repo.getPostDetail(id);
}

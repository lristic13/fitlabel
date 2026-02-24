import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:fitlabel/features/posts/domain/models/post.dart';
import 'package:fitlabel/features/posts/presentation/providers/posts_provider.dart';

class PostDetailScreen extends ConsumerWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(postDetailProvider(postId));

    return Scaffold(
      appBar: AppBar(
        title: detailState.whenOrNull(
          data: (post) => Text(post.title),
        ),
      ),
      body: detailState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load post',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: () =>
                    ref.invalidate(postDetailProvider(postId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (post) => _PostDetailBody(post: post),
      ),
    );
  }
}

class _PostDetailBody extends StatelessWidget {
  final PostDetail post;

  const _PostDetailBody({required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        if (post.coverImage?.file != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              post.coverImage!.file!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
          ),
        if (post.coverImage?.file != null) const SizedBox(height: 20),
        Text(
          post.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            if (post.publishedAt != null) ...[
              Icon(Icons.schedule,
                  size: 16, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                DateFormat.yMMMd().format(post.publishedAt!),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 12),
            ],
            if (!post.isFree)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: ShapeDecoration(
                  color: theme.colorScheme.tertiary,
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  'PREMIUM',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onTertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        Text(
          post.body,
          style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
      ],
    );
  }
}

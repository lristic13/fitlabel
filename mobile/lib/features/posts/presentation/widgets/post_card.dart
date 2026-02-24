import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fitlabel/features/posts/domain/models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const PostCard({
    super.key,
    required this.post,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _PostCardImage(coverImage: post.coverImage),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  _PostCardMeta(post: post),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostCardImage extends StatelessWidget {
  final dynamic coverImage;

  const _PostCardImage({required this.coverImage});

  @override
  Widget build(BuildContext context) {
    if (coverImage?.file != null) {
      return Image.network(
        coverImage.file as String,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const _PostCardImagePlaceholder(),
      );
    }
    return const _PostCardImagePlaceholder();
  }
}

class _PostCardImagePlaceholder extends StatelessWidget {
  const _PostCardImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary.withValues(alpha: 0.8),
            primary.withValues(alpha: 0.4),
          ],
        ),
      ),
      child: const Icon(
        Icons.article,
        size: 48,
        color: Colors.white54,
      ),
    );
  }
}

class _PostCardMeta extends StatelessWidget {
  final Post post;

  const _PostCardMeta({required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metaStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Row(
      children: [
        if (post.publishedAt != null) ...[
          Icon(Icons.schedule,
              size: 14, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            DateFormat.yMMMd().format(post.publishedAt!),
            style: metaStyle,
          ),
        ],
        const Spacer(),
        if (!post.isFree)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
    );
  }
}

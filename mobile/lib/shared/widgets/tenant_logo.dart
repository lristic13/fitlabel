import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitlabel/config/providers/tenant_config_provider.dart';

class TenantLogo extends ConsumerWidget {
  const TenantLogo({super.key, this.size = 64});

  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(tenantConfigNotifierProvider);

    return configAsync.when(
      loading: () => CircleAvatar(
        radius: size / 2,
        backgroundColor:
            Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      error: (e, st) => _fallbackIcon(context),
      data: (config) {
        final logo = config.logo;
        if (logo != null && logo.isNotEmpty) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(size / 2),
            child: Image.network(
              logo,
              width: size,
              height: size,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return CircleAvatar(
                  radius: size / 2,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                );
              },
              errorBuilder: (ctx, err, st) => _fallbackIcon(context),
            ),
          );
        }
        return _fallbackIcon(context);
      },
    );
  }

  Widget _fallbackIcon(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(
        Icons.fitness_center,
        size: size * 0.44,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}

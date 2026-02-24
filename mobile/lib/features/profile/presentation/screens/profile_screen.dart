import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitlabel/config/providers/tenant_config_provider.dart';
import 'package:fitlabel/features/auth/presentation/providers/auth_provider.dart';
import 'package:fitlabel/shared/widgets/tenant_logo.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.valueOrNull;
    final configAsync = ref.watch(tenantConfigNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: TenantLogo(size: 32),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tenant branding header
            Center(
              child: Column(
                children: [
                  const TenantLogo(size: 80),
                  const SizedBox(height: 12),
                  configAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (e, st) => const SizedBox.shrink(),
                    data: (config) => Column(
                      children: [
                        Text(
                          config.appName.isNotEmpty
                              ? config.appName
                              : config.name,
                          style: theme.textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        if (config.appName.isNotEmpty &&
                            config.name != config.appName) ...[
                          const SizedBox(height: 2),
                          Text(
                            config.name,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // User info card
            if (user != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor:
                            theme.colorScheme.secondaryContainer,
                        child: Text(
                          _initials(user.firstName, user.lastName, user.email),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user.firstName ?? ''} ${user.lastName ?? ''}'
                                  .trim()
                                  .isEmpty
                                  ? user.email
                                  : '${user.firstName ?? ''} ${user.lastName ?? ''}'
                                      .trim(),
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              user.email,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                user.role,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color:
                                      theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const Spacer(),

            FilledButton.tonal(
              onPressed: () {
                ref.read(authNotifierProvider.notifier).logout();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String? first, String? last, String email) {
    final f = (first ?? '').trim();
    final l = (last ?? '').trim();
    if (f.isNotEmpty && l.isNotEmpty) {
      return '${f[0]}${l[0]}'.toUpperCase();
    }
    if (f.isNotEmpty) return f[0].toUpperCase();
    return email[0].toUpperCase();
  }
}

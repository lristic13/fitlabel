import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitlabel/features/auth/presentation/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (user != null) ...[
              Text(
                user.email,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text('Role: ${user.role}'),
            ],
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
}

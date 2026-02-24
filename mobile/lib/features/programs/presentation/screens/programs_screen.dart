import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitlabel/features/programs/presentation/providers/programs_provider.dart';
import 'package:fitlabel/features/programs/presentation/widgets/program_card.dart';
import 'package:fitlabel/features/programs/presentation/widgets/programs_empty_view.dart';
import 'package:fitlabel/features/programs/presentation/widgets/programs_error_view.dart';
import 'package:fitlabel/shared/widgets/tenant_logo.dart';

class ProgramsScreen extends ConsumerWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programsState = ref.watch(programsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Programs',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: TenantLogo(size: 32),
          ),
        ],
      ),
      body: programsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ProgramsErrorView(
          error: error,
          onRetry: () => ref.invalidate(programsListProvider),
        ),
        data: (programs) {
          if (programs.isEmpty) return const ProgramsEmptyView();

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(programsListProvider),
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: programs.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final program = programs[index];
                return ProgramCard(
                  program: program,
                  onTap: () => context.push('/programs/${program.id}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

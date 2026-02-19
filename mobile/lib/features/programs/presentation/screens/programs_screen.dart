import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitlabel/features/programs/presentation/providers/programs_provider.dart';
import 'package:fitlabel/features/programs/presentation/widgets/program_card.dart';
import 'package:fitlabel/features/programs/presentation/widgets/programs_empty_view.dart';
import 'package:fitlabel/features/programs/presentation/widgets/programs_error_view.dart';

class ProgramsScreen extends ConsumerWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programsState = ref.watch(programsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Programs')),
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
              padding: const EdgeInsets.all(16),
              itemCount: programs.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
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

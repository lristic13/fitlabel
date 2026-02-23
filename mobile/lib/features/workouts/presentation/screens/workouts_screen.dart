import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitlabel/features/workouts/presentation/providers/workouts_provider.dart';
import 'package:fitlabel/features/workouts/presentation/widgets/workout_card.dart';

class WorkoutsScreen extends ConsumerStatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  ConsumerState<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends ConsumerState<WorkoutsScreen> {
  final _searchController = TextEditingController();
  final _selectedGroups = <String>{};
  Timer? _debounce;
  String _searchText = '';

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() => _searchText = value.trim());
    });
  }

  void _onGroupToggled(String group) {
    setState(() {
      if (_selectedGroups.contains(group)) {
        _selectedGroups.remove(group);
      } else {
        _selectedGroups.add(group);
      }
    });
  }

  void _onAllTapped() {
    setState(() => _selectedGroups.clear());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muscleGroupsState = ref.watch(muscleGroupsProvider);
    final workoutsState = ref.watch(
      filteredWorkoutsProvider(
        search: _searchText,
        selectedGroups: _selectedGroups.join(','),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Workouts')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(workoutsListProvider);
        },
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search workouts...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchText = '');
                          },
                        )
                      : null,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // Category pills
            muscleGroupsState.when(
              loading: () => const SizedBox(height: 48),
              error: (_, _) => const SizedBox.shrink(),
              data: (groups) => SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: groups.length + 1,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      final isAllSelected = _selectedGroups.isEmpty;
                      return FilterChip(
                        label: const Text('All'),
                        selected: isAllSelected,
                        onSelected: (_) => _onAllTapped(),
                        showCheckmark: false,
                        selectedColor: theme.colorScheme.primary,
                        labelStyle: TextStyle(
                          color: isAllSelected
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      );
                    }
                    final group = groups[index - 1];
                    final isSelected =
                        _selectedGroups.contains(group.value);
                    return FilterChip(
                      label: Text(group.label),
                      selected: isSelected,
                      onSelected: (_) => _onGroupToggled(group.value),
                      showCheckmark: false,
                      selectedColor: theme.colorScheme.primary,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 4),

            // Workout list
            Expanded(
              child: workoutsState.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Failed to load workouts',
                          style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () =>
                            ref.invalidate(workoutsListProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
                data: (workouts) {
                  if (workouts.isEmpty) {
                    final hasFilters = _searchText.isNotEmpty ||
                        _selectedGroups.isNotEmpty;
                    return _EmptyView(hasFilters: hasFilters);
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: workouts.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final workout = workouts[index];
                      return WorkoutCard(
                        workout: workout,
                        onTap: () =>
                            context.push('/workouts/${workout.id}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final bool hasFilters;

  const _EmptyView({required this.hasFilters});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            hasFilters ? Icons.search_off : Icons.fitness_center,
            size: 48,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 8),
          Text(
            hasFilters ? 'No workouts found' : 'No workouts yet',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

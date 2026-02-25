import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fitlabel/features/progress/data/datasources/progress_remote_data_source.dart';
import 'package:fitlabel/features/progress/data/repositories/progress_repository_impl.dart';
import 'package:fitlabel/features/progress/domain/models/progress.dart';
import 'package:fitlabel/features/progress/domain/repositories/progress_repository.dart';
import 'package:fitlabel/shared/providers/core_providers.dart';

part 'progress_provider.g.dart';

@Riverpod(keepAlive: true)
ProgressRemoteDataSource progressRemoteDataSource(Ref ref) {
  final client = ref.watch(apiClientProvider);
  return ProgressRemoteDataSource(client: client);
}

@Riverpod(keepAlive: true)
ProgressRepository progressRepository(Ref ref) {
  final dataSource = ref.watch(progressRemoteDataSourceProvider);
  return ProgressRepositoryImpl(dataSource: dataSource);
}

@riverpod
Future<ProgressStats> progressStats(Ref ref) {
  final repo = ref.watch(progressRepositoryProvider);
  return repo.getStats();
}

/// State for paginated workout history.
class HistoryState {
  final List<WorkoutHistoryEntry> entries;
  final String? nextCursor;
  final bool isLoadingMore;

  const HistoryState({
    this.entries = const [],
    this.nextCursor,
    this.isLoadingMore = false,
  });

  bool get hasMore => nextCursor != null;

  HistoryState copyWith({
    List<WorkoutHistoryEntry>? entries,
    String? Function()? nextCursor,
    bool? isLoadingMore,
  }) {
    return HistoryState(
      entries: entries ?? this.entries,
      nextCursor: nextCursor != null ? nextCursor() : this.nextCursor,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

@riverpod
class ProgressHistoryNotifier extends _$ProgressHistoryNotifier {
  @override
  AsyncValue<HistoryState> build() {
    _loadInitial();
    return const AsyncLoading();
  }

  Future<void> _loadInitial() async {
    state = const AsyncLoading();
    final repo = ref.read(progressRepositoryProvider);
    try {
      final page = await repo.getHistory();
      state = AsyncData(HistoryState(
        entries: page.results,
        nextCursor: page.next,
      ));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> refresh() async {
    await _loadInitial();
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    final repo = ref.read(progressRepositoryProvider);
    try {
      final page = await repo.getHistory(cursor: current.nextCursor);
      state = AsyncData(HistoryState(
        entries: [...current.entries, ...page.results],
        nextCursor: page.next,
      ));
    } catch (_) {
      // Restore without loading flag — don't lose existing data
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }
}

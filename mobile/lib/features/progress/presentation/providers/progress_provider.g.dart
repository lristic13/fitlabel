// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$progressRemoteDataSourceHash() =>
    r'd9acdceb8ec044cb3ad0fe917378d8e369eebf97';

/// See also [progressRemoteDataSource].
@ProviderFor(progressRemoteDataSource)
final progressRemoteDataSourceProvider =
    Provider<ProgressRemoteDataSource>.internal(
      progressRemoteDataSource,
      name: r'progressRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$progressRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProgressRemoteDataSourceRef = ProviderRef<ProgressRemoteDataSource>;
String _$progressRepositoryHash() =>
    r'57e81e1c02a02b7d1a79862bd4fa40189597259d';

/// See also [progressRepository].
@ProviderFor(progressRepository)
final progressRepositoryProvider = Provider<ProgressRepository>.internal(
  progressRepository,
  name: r'progressRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$progressRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProgressRepositoryRef = ProviderRef<ProgressRepository>;
String _$progressStatsHash() => r'17ab7a69011cedf58686dc638b582f037a9606ed';

/// See also [progressStats].
@ProviderFor(progressStats)
final progressStatsProvider = AutoDisposeFutureProvider<ProgressStats>.internal(
  progressStats,
  name: r'progressStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$progressStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProgressStatsRef = AutoDisposeFutureProviderRef<ProgressStats>;
String _$progressHistoryNotifierHash() =>
    r'890476e04c0d514319ce29b5e13b7a9830c47fc5';

/// See also [ProgressHistoryNotifier].
@ProviderFor(ProgressHistoryNotifier)
final progressHistoryNotifierProvider =
    AutoDisposeNotifierProvider<
      ProgressHistoryNotifier,
      AsyncValue<HistoryState>
    >.internal(
      ProgressHistoryNotifier.new,
      name: r'progressHistoryNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$progressHistoryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProgressHistoryNotifier =
    AutoDisposeNotifier<AsyncValue<HistoryState>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

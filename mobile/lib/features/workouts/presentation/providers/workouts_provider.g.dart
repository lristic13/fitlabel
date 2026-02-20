// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workouts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workoutsRemoteDataSourceHash() =>
    r'6e881207002079fab5217b153670fb4225b252d6';

/// See also [workoutsRemoteDataSource].
@ProviderFor(workoutsRemoteDataSource)
final workoutsRemoteDataSourceProvider =
    Provider<WorkoutsRemoteDataSource>.internal(
      workoutsRemoteDataSource,
      name: r'workoutsRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$workoutsRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorkoutsRemoteDataSourceRef = ProviderRef<WorkoutsRemoteDataSource>;
String _$workoutsRepositoryHash() =>
    r'ed0abf8a34869d7ce19a27e9596de7ffd65094f1';

/// See also [workoutsRepository].
@ProviderFor(workoutsRepository)
final workoutsRepositoryProvider = Provider<WorkoutsRepository>.internal(
  workoutsRepository,
  name: r'workoutsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$workoutsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorkoutsRepositoryRef = ProviderRef<WorkoutsRepository>;
String _$workoutsListHash() => r'c68ef5764e66ca9c3c27d734d1e4a5a581d52e8c';

/// See also [workoutsList].
@ProviderFor(workoutsList)
final workoutsListProvider =
    AutoDisposeFutureProvider<List<WorkoutBrief>>.internal(
      workoutsList,
      name: r'workoutsListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$workoutsListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WorkoutsListRef = AutoDisposeFutureProviderRef<List<WorkoutBrief>>;
String _$workoutDetailHash() => r'1d9d50067e2d8dfec9beef3a49af6cfbea058fb2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [workoutDetail].
@ProviderFor(workoutDetail)
const workoutDetailProvider = WorkoutDetailFamily();

/// See also [workoutDetail].
class WorkoutDetailFamily extends Family<AsyncValue<WorkoutDetail>> {
  /// See also [workoutDetail].
  const WorkoutDetailFamily();

  /// See also [workoutDetail].
  WorkoutDetailProvider call((String, String?) args) {
    return WorkoutDetailProvider(args);
  }

  @override
  WorkoutDetailProvider getProviderOverride(
    covariant WorkoutDetailProvider provider,
  ) {
    return call(provider.args);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'workoutDetailProvider';
}

/// See also [workoutDetail].
class WorkoutDetailProvider extends AutoDisposeFutureProvider<WorkoutDetail> {
  /// See also [workoutDetail].
  WorkoutDetailProvider((String, String?) args)
    : this._internal(
        (ref) => workoutDetail(ref as WorkoutDetailRef, args),
        from: workoutDetailProvider,
        name: r'workoutDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$workoutDetailHash,
        dependencies: WorkoutDetailFamily._dependencies,
        allTransitiveDependencies:
            WorkoutDetailFamily._allTransitiveDependencies,
        args: args,
      );

  WorkoutDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.args,
  }) : super.internal();

  final (String, String?) args;

  @override
  Override overrideWith(
    FutureOr<WorkoutDetail> Function(WorkoutDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WorkoutDetailProvider._internal(
        (ref) => create(ref as WorkoutDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        args: args,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<WorkoutDetail> createElement() {
    return _WorkoutDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutDetailProvider && other.args == args;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, args.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WorkoutDetailRef on AutoDisposeFutureProviderRef<WorkoutDetail> {
  /// The parameter `args` of this provider.
  (String, String?) get args;
}

class _WorkoutDetailProviderElement
    extends AutoDisposeFutureProviderElement<WorkoutDetail>
    with WorkoutDetailRef {
  _WorkoutDetailProviderElement(super.provider);

  @override
  (String, String?) get args => (origin as WorkoutDetailProvider).args;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

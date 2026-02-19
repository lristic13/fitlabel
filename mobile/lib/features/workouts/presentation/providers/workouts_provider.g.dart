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
String _$workoutDetailHash() => r'95bb001c2fd3eceaaa55ca31a447e5b265207598';

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
  WorkoutDetailProvider call(String id) {
    return WorkoutDetailProvider(id);
  }

  @override
  WorkoutDetailProvider getProviderOverride(
    covariant WorkoutDetailProvider provider,
  ) {
    return call(provider.id);
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
  WorkoutDetailProvider(String id)
    : this._internal(
        (ref) => workoutDetail(ref as WorkoutDetailRef, id),
        from: workoutDetailProvider,
        name: r'workoutDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$workoutDetailHash,
        dependencies: WorkoutDetailFamily._dependencies,
        allTransitiveDependencies:
            WorkoutDetailFamily._allTransitiveDependencies,
        id: id,
      );

  WorkoutDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

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
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<WorkoutDetail> createElement() {
    return _WorkoutDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WorkoutDetailRef on AutoDisposeFutureProviderRef<WorkoutDetail> {
  /// The parameter `id` of this provider.
  String get id;
}

class _WorkoutDetailProviderElement
    extends AutoDisposeFutureProviderElement<WorkoutDetail>
    with WorkoutDetailRef {
  _WorkoutDetailProviderElement(super.provider);

  @override
  String get id => (origin as WorkoutDetailProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

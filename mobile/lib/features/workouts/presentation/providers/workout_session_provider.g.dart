// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workoutSessionNotifierHash() =>
    r'0f9c9ad266d1780a5c95da7f04bca8ba6d9d8a5e';

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

abstract class _$WorkoutSessionNotifier
    extends BuildlessAutoDisposeNotifier<AsyncValue<WorkoutSession?>> {
  late final String workoutId;

  AsyncValue<WorkoutSession?> build(String workoutId);
}

/// Manages the active workout session for a given workout.
/// Tracks per-exercise set completion and auto-completes when all done.
///
/// Copied from [WorkoutSessionNotifier].
@ProviderFor(WorkoutSessionNotifier)
const workoutSessionNotifierProvider = WorkoutSessionNotifierFamily();

/// Manages the active workout session for a given workout.
/// Tracks per-exercise set completion and auto-completes when all done.
///
/// Copied from [WorkoutSessionNotifier].
class WorkoutSessionNotifierFamily extends Family<AsyncValue<WorkoutSession?>> {
  /// Manages the active workout session for a given workout.
  /// Tracks per-exercise set completion and auto-completes when all done.
  ///
  /// Copied from [WorkoutSessionNotifier].
  const WorkoutSessionNotifierFamily();

  /// Manages the active workout session for a given workout.
  /// Tracks per-exercise set completion and auto-completes when all done.
  ///
  /// Copied from [WorkoutSessionNotifier].
  WorkoutSessionNotifierProvider call(String workoutId) {
    return WorkoutSessionNotifierProvider(workoutId);
  }

  @override
  WorkoutSessionNotifierProvider getProviderOverride(
    covariant WorkoutSessionNotifierProvider provider,
  ) {
    return call(provider.workoutId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'workoutSessionNotifierProvider';
}

/// Manages the active workout session for a given workout.
/// Tracks per-exercise set completion and auto-completes when all done.
///
/// Copied from [WorkoutSessionNotifier].
class WorkoutSessionNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<
          WorkoutSessionNotifier,
          AsyncValue<WorkoutSession?>
        > {
  /// Manages the active workout session for a given workout.
  /// Tracks per-exercise set completion and auto-completes when all done.
  ///
  /// Copied from [WorkoutSessionNotifier].
  WorkoutSessionNotifierProvider(String workoutId)
    : this._internal(
        () => WorkoutSessionNotifier()..workoutId = workoutId,
        from: workoutSessionNotifierProvider,
        name: r'workoutSessionNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$workoutSessionNotifierHash,
        dependencies: WorkoutSessionNotifierFamily._dependencies,
        allTransitiveDependencies:
            WorkoutSessionNotifierFamily._allTransitiveDependencies,
        workoutId: workoutId,
      );

  WorkoutSessionNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.workoutId,
  }) : super.internal();

  final String workoutId;

  @override
  AsyncValue<WorkoutSession?> runNotifierBuild(
    covariant WorkoutSessionNotifier notifier,
  ) {
    return notifier.build(workoutId);
  }

  @override
  Override overrideWith(WorkoutSessionNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: WorkoutSessionNotifierProvider._internal(
        () => create()..workoutId = workoutId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        workoutId: workoutId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    WorkoutSessionNotifier,
    AsyncValue<WorkoutSession?>
  >
  createElement() {
    return _WorkoutSessionNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkoutSessionNotifierProvider &&
        other.workoutId == workoutId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, workoutId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WorkoutSessionNotifierRef
    on AutoDisposeNotifierProviderRef<AsyncValue<WorkoutSession?>> {
  /// The parameter `workoutId` of this provider.
  String get workoutId;
}

class _WorkoutSessionNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          WorkoutSessionNotifier,
          AsyncValue<WorkoutSession?>
        >
    with WorkoutSessionNotifierRef {
  _WorkoutSessionNotifierProviderElement(super.provider);

  @override
  String get workoutId => (origin as WorkoutSessionNotifierProvider).workoutId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

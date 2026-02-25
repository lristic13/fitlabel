// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkoutHistoryEntry _$WorkoutHistoryEntryFromJson(Map<String, dynamic> json) {
  return _WorkoutHistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$WorkoutHistoryEntry {
  String get id => throw _privateConstructorUsedError;
  String get workoutTitle => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int? get durationSeconds => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  List<ExerciseLogEntry> get exerciseLogs => throw _privateConstructorUsedError;

  /// Serializes this WorkoutHistoryEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutHistoryEntryCopyWith<WorkoutHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutHistoryEntryCopyWith<$Res> {
  factory $WorkoutHistoryEntryCopyWith(
    WorkoutHistoryEntry value,
    $Res Function(WorkoutHistoryEntry) then,
  ) = _$WorkoutHistoryEntryCopyWithImpl<$Res, WorkoutHistoryEntry>;
  @useResult
  $Res call({
    String id,
    String workoutTitle,
    DateTime startedAt,
    DateTime? completedAt,
    int? durationSeconds,
    String notes,
    List<ExerciseLogEntry> exerciseLogs,
  });
}

/// @nodoc
class _$WorkoutHistoryEntryCopyWithImpl<$Res, $Val extends WorkoutHistoryEntry>
    implements $WorkoutHistoryEntryCopyWith<$Res> {
  _$WorkoutHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workoutTitle = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? durationSeconds = freezed,
    Object? notes = null,
    Object? exerciseLogs = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            workoutTitle: null == workoutTitle
                ? _value.workoutTitle
                : workoutTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            durationSeconds: freezed == durationSeconds
                ? _value.durationSeconds
                : durationSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
            exerciseLogs: null == exerciseLogs
                ? _value.exerciseLogs
                : exerciseLogs // ignore: cast_nullable_to_non_nullable
                      as List<ExerciseLogEntry>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutHistoryEntryImplCopyWith<$Res>
    implements $WorkoutHistoryEntryCopyWith<$Res> {
  factory _$$WorkoutHistoryEntryImplCopyWith(
    _$WorkoutHistoryEntryImpl value,
    $Res Function(_$WorkoutHistoryEntryImpl) then,
  ) = __$$WorkoutHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String workoutTitle,
    DateTime startedAt,
    DateTime? completedAt,
    int? durationSeconds,
    String notes,
    List<ExerciseLogEntry> exerciseLogs,
  });
}

/// @nodoc
class __$$WorkoutHistoryEntryImplCopyWithImpl<$Res>
    extends _$WorkoutHistoryEntryCopyWithImpl<$Res, _$WorkoutHistoryEntryImpl>
    implements _$$WorkoutHistoryEntryImplCopyWith<$Res> {
  __$$WorkoutHistoryEntryImplCopyWithImpl(
    _$WorkoutHistoryEntryImpl _value,
    $Res Function(_$WorkoutHistoryEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workoutTitle = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? durationSeconds = freezed,
    Object? notes = null,
    Object? exerciseLogs = null,
  }) {
    return _then(
      _$WorkoutHistoryEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        workoutTitle: null == workoutTitle
            ? _value.workoutTitle
            : workoutTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        durationSeconds: freezed == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
        exerciseLogs: null == exerciseLogs
            ? _value._exerciseLogs
            : exerciseLogs // ignore: cast_nullable_to_non_nullable
                  as List<ExerciseLogEntry>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutHistoryEntryImpl implements _WorkoutHistoryEntry {
  const _$WorkoutHistoryEntryImpl({
    required this.id,
    required this.workoutTitle,
    required this.startedAt,
    this.completedAt,
    this.durationSeconds,
    this.notes = '',
    final List<ExerciseLogEntry> exerciseLogs = const [],
  }) : _exerciseLogs = exerciseLogs;

  factory _$WorkoutHistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutHistoryEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String workoutTitle;
  @override
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  @override
  final int? durationSeconds;
  @override
  @JsonKey()
  final String notes;
  final List<ExerciseLogEntry> _exerciseLogs;
  @override
  @JsonKey()
  List<ExerciseLogEntry> get exerciseLogs {
    if (_exerciseLogs is EqualUnmodifiableListView) return _exerciseLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exerciseLogs);
  }

  @override
  String toString() {
    return 'WorkoutHistoryEntry(id: $id, workoutTitle: $workoutTitle, startedAt: $startedAt, completedAt: $completedAt, durationSeconds: $durationSeconds, notes: $notes, exerciseLogs: $exerciseLogs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutHistoryEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workoutTitle, workoutTitle) ||
                other.workoutTitle == workoutTitle) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(
              other._exerciseLogs,
              _exerciseLogs,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    workoutTitle,
    startedAt,
    completedAt,
    durationSeconds,
    notes,
    const DeepCollectionEquality().hash(_exerciseLogs),
  );

  /// Create a copy of WorkoutHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutHistoryEntryImplCopyWith<_$WorkoutHistoryEntryImpl> get copyWith =>
      __$$WorkoutHistoryEntryImplCopyWithImpl<_$WorkoutHistoryEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutHistoryEntryImplToJson(this);
  }
}

abstract class _WorkoutHistoryEntry implements WorkoutHistoryEntry {
  const factory _WorkoutHistoryEntry({
    required final String id,
    required final String workoutTitle,
    required final DateTime startedAt,
    final DateTime? completedAt,
    final int? durationSeconds,
    final String notes,
    final List<ExerciseLogEntry> exerciseLogs,
  }) = _$WorkoutHistoryEntryImpl;

  factory _WorkoutHistoryEntry.fromJson(Map<String, dynamic> json) =
      _$WorkoutHistoryEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get workoutTitle;
  @override
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  int? get durationSeconds;
  @override
  String get notes;
  @override
  List<ExerciseLogEntry> get exerciseLogs;

  /// Create a copy of WorkoutHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutHistoryEntryImplCopyWith<_$WorkoutHistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExerciseLogEntry _$ExerciseLogEntryFromJson(Map<String, dynamic> json) {
  return _ExerciseLogEntry.fromJson(json);
}

/// @nodoc
mixin _$ExerciseLogEntry {
  String get exerciseName => throw _privateConstructorUsedError;
  int get setsCompleted => throw _privateConstructorUsedError;
  List<int> get repsPerSet => throw _privateConstructorUsedError;
  List<double> get weightPerSet => throw _privateConstructorUsedError;
  String get weightUnit => throw _privateConstructorUsedError;

  /// Serializes this ExerciseLogEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExerciseLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseLogEntryCopyWith<ExerciseLogEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseLogEntryCopyWith<$Res> {
  factory $ExerciseLogEntryCopyWith(
    ExerciseLogEntry value,
    $Res Function(ExerciseLogEntry) then,
  ) = _$ExerciseLogEntryCopyWithImpl<$Res, ExerciseLogEntry>;
  @useResult
  $Res call({
    String exerciseName,
    int setsCompleted,
    List<int> repsPerSet,
    List<double> weightPerSet,
    String weightUnit,
  });
}

/// @nodoc
class _$ExerciseLogEntryCopyWithImpl<$Res, $Val extends ExerciseLogEntry>
    implements $ExerciseLogEntryCopyWith<$Res> {
  _$ExerciseLogEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExerciseLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseName = null,
    Object? setsCompleted = null,
    Object? repsPerSet = null,
    Object? weightPerSet = null,
    Object? weightUnit = null,
  }) {
    return _then(
      _value.copyWith(
            exerciseName: null == exerciseName
                ? _value.exerciseName
                : exerciseName // ignore: cast_nullable_to_non_nullable
                      as String,
            setsCompleted: null == setsCompleted
                ? _value.setsCompleted
                : setsCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            repsPerSet: null == repsPerSet
                ? _value.repsPerSet
                : repsPerSet // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            weightPerSet: null == weightPerSet
                ? _value.weightPerSet
                : weightPerSet // ignore: cast_nullable_to_non_nullable
                      as List<double>,
            weightUnit: null == weightUnit
                ? _value.weightUnit
                : weightUnit // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExerciseLogEntryImplCopyWith<$Res>
    implements $ExerciseLogEntryCopyWith<$Res> {
  factory _$$ExerciseLogEntryImplCopyWith(
    _$ExerciseLogEntryImpl value,
    $Res Function(_$ExerciseLogEntryImpl) then,
  ) = __$$ExerciseLogEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String exerciseName,
    int setsCompleted,
    List<int> repsPerSet,
    List<double> weightPerSet,
    String weightUnit,
  });
}

/// @nodoc
class __$$ExerciseLogEntryImplCopyWithImpl<$Res>
    extends _$ExerciseLogEntryCopyWithImpl<$Res, _$ExerciseLogEntryImpl>
    implements _$$ExerciseLogEntryImplCopyWith<$Res> {
  __$$ExerciseLogEntryImplCopyWithImpl(
    _$ExerciseLogEntryImpl _value,
    $Res Function(_$ExerciseLogEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExerciseLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseName = null,
    Object? setsCompleted = null,
    Object? repsPerSet = null,
    Object? weightPerSet = null,
    Object? weightUnit = null,
  }) {
    return _then(
      _$ExerciseLogEntryImpl(
        exerciseName: null == exerciseName
            ? _value.exerciseName
            : exerciseName // ignore: cast_nullable_to_non_nullable
                  as String,
        setsCompleted: null == setsCompleted
            ? _value.setsCompleted
            : setsCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        repsPerSet: null == repsPerSet
            ? _value._repsPerSet
            : repsPerSet // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        weightPerSet: null == weightPerSet
            ? _value._weightPerSet
            : weightPerSet // ignore: cast_nullable_to_non_nullable
                  as List<double>,
        weightUnit: null == weightUnit
            ? _value.weightUnit
            : weightUnit // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseLogEntryImpl implements _ExerciseLogEntry {
  const _$ExerciseLogEntryImpl({
    required this.exerciseName,
    required this.setsCompleted,
    final List<int> repsPerSet = const [],
    final List<double> weightPerSet = const [],
    this.weightUnit = 'KG',
  }) : _repsPerSet = repsPerSet,
       _weightPerSet = weightPerSet;

  factory _$ExerciseLogEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseLogEntryImplFromJson(json);

  @override
  final String exerciseName;
  @override
  final int setsCompleted;
  final List<int> _repsPerSet;
  @override
  @JsonKey()
  List<int> get repsPerSet {
    if (_repsPerSet is EqualUnmodifiableListView) return _repsPerSet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_repsPerSet);
  }

  final List<double> _weightPerSet;
  @override
  @JsonKey()
  List<double> get weightPerSet {
    if (_weightPerSet is EqualUnmodifiableListView) return _weightPerSet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weightPerSet);
  }

  @override
  @JsonKey()
  final String weightUnit;

  @override
  String toString() {
    return 'ExerciseLogEntry(exerciseName: $exerciseName, setsCompleted: $setsCompleted, repsPerSet: $repsPerSet, weightPerSet: $weightPerSet, weightUnit: $weightUnit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseLogEntryImpl &&
            (identical(other.exerciseName, exerciseName) ||
                other.exerciseName == exerciseName) &&
            (identical(other.setsCompleted, setsCompleted) ||
                other.setsCompleted == setsCompleted) &&
            const DeepCollectionEquality().equals(
              other._repsPerSet,
              _repsPerSet,
            ) &&
            const DeepCollectionEquality().equals(
              other._weightPerSet,
              _weightPerSet,
            ) &&
            (identical(other.weightUnit, weightUnit) ||
                other.weightUnit == weightUnit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    exerciseName,
    setsCompleted,
    const DeepCollectionEquality().hash(_repsPerSet),
    const DeepCollectionEquality().hash(_weightPerSet),
    weightUnit,
  );

  /// Create a copy of ExerciseLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseLogEntryImplCopyWith<_$ExerciseLogEntryImpl> get copyWith =>
      __$$ExerciseLogEntryImplCopyWithImpl<_$ExerciseLogEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseLogEntryImplToJson(this);
  }
}

abstract class _ExerciseLogEntry implements ExerciseLogEntry {
  const factory _ExerciseLogEntry({
    required final String exerciseName,
    required final int setsCompleted,
    final List<int> repsPerSet,
    final List<double> weightPerSet,
    final String weightUnit,
  }) = _$ExerciseLogEntryImpl;

  factory _ExerciseLogEntry.fromJson(Map<String, dynamic> json) =
      _$ExerciseLogEntryImpl.fromJson;

  @override
  String get exerciseName;
  @override
  int get setsCompleted;
  @override
  List<int> get repsPerSet;
  @override
  List<double> get weightPerSet;
  @override
  String get weightUnit;

  /// Create a copy of ExerciseLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseLogEntryImplCopyWith<_$ExerciseLogEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgressStats _$ProgressStatsFromJson(Map<String, dynamic> json) {
  return _ProgressStats.fromJson(json);
}

/// @nodoc
mixin _$ProgressStats {
  int get totalWorkouts => throw _privateConstructorUsedError;
  int get totalDurationSeconds => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  int get activePrograms => throw _privateConstructorUsedError;

  /// Serializes this ProgressStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgressStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgressStatsCopyWith<ProgressStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressStatsCopyWith<$Res> {
  factory $ProgressStatsCopyWith(
    ProgressStats value,
    $Res Function(ProgressStats) then,
  ) = _$ProgressStatsCopyWithImpl<$Res, ProgressStats>;
  @useResult
  $Res call({
    int totalWorkouts,
    int totalDurationSeconds,
    int currentStreak,
    int longestStreak,
    int activePrograms,
  });
}

/// @nodoc
class _$ProgressStatsCopyWithImpl<$Res, $Val extends ProgressStats>
    implements $ProgressStatsCopyWith<$Res> {
  _$ProgressStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgressStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalWorkouts = null,
    Object? totalDurationSeconds = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? activePrograms = null,
  }) {
    return _then(
      _value.copyWith(
            totalWorkouts: null == totalWorkouts
                ? _value.totalWorkouts
                : totalWorkouts // ignore: cast_nullable_to_non_nullable
                      as int,
            totalDurationSeconds: null == totalDurationSeconds
                ? _value.totalDurationSeconds
                : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            longestStreak: null == longestStreak
                ? _value.longestStreak
                : longestStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            activePrograms: null == activePrograms
                ? _value.activePrograms
                : activePrograms // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProgressStatsImplCopyWith<$Res>
    implements $ProgressStatsCopyWith<$Res> {
  factory _$$ProgressStatsImplCopyWith(
    _$ProgressStatsImpl value,
    $Res Function(_$ProgressStatsImpl) then,
  ) = __$$ProgressStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalWorkouts,
    int totalDurationSeconds,
    int currentStreak,
    int longestStreak,
    int activePrograms,
  });
}

/// @nodoc
class __$$ProgressStatsImplCopyWithImpl<$Res>
    extends _$ProgressStatsCopyWithImpl<$Res, _$ProgressStatsImpl>
    implements _$$ProgressStatsImplCopyWith<$Res> {
  __$$ProgressStatsImplCopyWithImpl(
    _$ProgressStatsImpl _value,
    $Res Function(_$ProgressStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgressStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalWorkouts = null,
    Object? totalDurationSeconds = null,
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? activePrograms = null,
  }) {
    return _then(
      _$ProgressStatsImpl(
        totalWorkouts: null == totalWorkouts
            ? _value.totalWorkouts
            : totalWorkouts // ignore: cast_nullable_to_non_nullable
                  as int,
        totalDurationSeconds: null == totalDurationSeconds
            ? _value.totalDurationSeconds
            : totalDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        longestStreak: null == longestStreak
            ? _value.longestStreak
            : longestStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        activePrograms: null == activePrograms
            ? _value.activePrograms
            : activePrograms // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgressStatsImpl implements _ProgressStats {
  const _$ProgressStatsImpl({
    required this.totalWorkouts,
    required this.totalDurationSeconds,
    required this.currentStreak,
    required this.longestStreak,
    required this.activePrograms,
  });

  factory _$ProgressStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressStatsImplFromJson(json);

  @override
  final int totalWorkouts;
  @override
  final int totalDurationSeconds;
  @override
  final int currentStreak;
  @override
  final int longestStreak;
  @override
  final int activePrograms;

  @override
  String toString() {
    return 'ProgressStats(totalWorkouts: $totalWorkouts, totalDurationSeconds: $totalDurationSeconds, currentStreak: $currentStreak, longestStreak: $longestStreak, activePrograms: $activePrograms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressStatsImpl &&
            (identical(other.totalWorkouts, totalWorkouts) ||
                other.totalWorkouts == totalWorkouts) &&
            (identical(other.totalDurationSeconds, totalDurationSeconds) ||
                other.totalDurationSeconds == totalDurationSeconds) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.activePrograms, activePrograms) ||
                other.activePrograms == activePrograms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalWorkouts,
    totalDurationSeconds,
    currentStreak,
    longestStreak,
    activePrograms,
  );

  /// Create a copy of ProgressStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressStatsImplCopyWith<_$ProgressStatsImpl> get copyWith =>
      __$$ProgressStatsImplCopyWithImpl<_$ProgressStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressStatsImplToJson(this);
  }
}

abstract class _ProgressStats implements ProgressStats {
  const factory _ProgressStats({
    required final int totalWorkouts,
    required final int totalDurationSeconds,
    required final int currentStreak,
    required final int longestStreak,
    required final int activePrograms,
  }) = _$ProgressStatsImpl;

  factory _ProgressStats.fromJson(Map<String, dynamic> json) =
      _$ProgressStatsImpl.fromJson;

  @override
  int get totalWorkouts;
  @override
  int get totalDurationSeconds;
  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  int get activePrograms;

  /// Create a copy of ProgressStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressStatsImplCopyWith<_$ProgressStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginatedHistory _$PaginatedHistoryFromJson(Map<String, dynamic> json) {
  return _PaginatedHistory.fromJson(json);
}

/// @nodoc
mixin _$PaginatedHistory {
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<WorkoutHistoryEntry> get results => throw _privateConstructorUsedError;

  /// Serializes this PaginatedHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedHistoryCopyWith<PaginatedHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedHistoryCopyWith<$Res> {
  factory $PaginatedHistoryCopyWith(
    PaginatedHistory value,
    $Res Function(PaginatedHistory) then,
  ) = _$PaginatedHistoryCopyWithImpl<$Res, PaginatedHistory>;
  @useResult
  $Res call({
    String? next,
    String? previous,
    List<WorkoutHistoryEntry> results,
  });
}

/// @nodoc
class _$PaginatedHistoryCopyWithImpl<$Res, $Val extends PaginatedHistory>
    implements $PaginatedHistoryCopyWith<$Res> {
  _$PaginatedHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = null,
  }) {
    return _then(
      _value.copyWith(
            next: freezed == next
                ? _value.next
                : next // ignore: cast_nullable_to_non_nullable
                      as String?,
            previous: freezed == previous
                ? _value.previous
                : previous // ignore: cast_nullable_to_non_nullable
                      as String?,
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<WorkoutHistoryEntry>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedHistoryImplCopyWith<$Res>
    implements $PaginatedHistoryCopyWith<$Res> {
  factory _$$PaginatedHistoryImplCopyWith(
    _$PaginatedHistoryImpl value,
    $Res Function(_$PaginatedHistoryImpl) then,
  ) = __$$PaginatedHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? next,
    String? previous,
    List<WorkoutHistoryEntry> results,
  });
}

/// @nodoc
class __$$PaginatedHistoryImplCopyWithImpl<$Res>
    extends _$PaginatedHistoryCopyWithImpl<$Res, _$PaginatedHistoryImpl>
    implements _$$PaginatedHistoryImplCopyWith<$Res> {
  __$$PaginatedHistoryImplCopyWithImpl(
    _$PaginatedHistoryImpl _value,
    $Res Function(_$PaginatedHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = null,
  }) {
    return _then(
      _$PaginatedHistoryImpl(
        next: freezed == next
            ? _value.next
            : next // ignore: cast_nullable_to_non_nullable
                  as String?,
        previous: freezed == previous
            ? _value.previous
            : previous // ignore: cast_nullable_to_non_nullable
                  as String?,
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<WorkoutHistoryEntry>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedHistoryImpl implements _PaginatedHistory {
  const _$PaginatedHistoryImpl({
    this.next,
    this.previous,
    final List<WorkoutHistoryEntry> results = const [],
  }) : _results = results;

  factory _$PaginatedHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedHistoryImplFromJson(json);

  @override
  final String? next;
  @override
  final String? previous;
  final List<WorkoutHistoryEntry> _results;
  @override
  @JsonKey()
  List<WorkoutHistoryEntry> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'PaginatedHistory(next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedHistoryImpl &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.previous, previous) ||
                other.previous == previous) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    next,
    previous,
    const DeepCollectionEquality().hash(_results),
  );

  /// Create a copy of PaginatedHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedHistoryImplCopyWith<_$PaginatedHistoryImpl> get copyWith =>
      __$$PaginatedHistoryImplCopyWithImpl<_$PaginatedHistoryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedHistoryImplToJson(this);
  }
}

abstract class _PaginatedHistory implements PaginatedHistory {
  const factory _PaginatedHistory({
    final String? next,
    final String? previous,
    final List<WorkoutHistoryEntry> results,
  }) = _$PaginatedHistoryImpl;

  factory _PaginatedHistory.fromJson(Map<String, dynamic> json) =
      _$PaginatedHistoryImpl.fromJson;

  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<WorkoutHistoryEntry> get results;

  /// Create a copy of PaginatedHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedHistoryImplCopyWith<_$PaginatedHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

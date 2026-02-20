// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutSession {
  WorkoutLog get workoutLog => throw _privateConstructorUsedError;
  Map<String, ExerciseSessionLog> get exerciseLogs =>
      throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSessionCopyWith<WorkoutSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSessionCopyWith<$Res> {
  factory $WorkoutSessionCopyWith(
    WorkoutSession value,
    $Res Function(WorkoutSession) then,
  ) = _$WorkoutSessionCopyWithImpl<$Res, WorkoutSession>;
  @useResult
  $Res call({
    WorkoutLog workoutLog,
    Map<String, ExerciseSessionLog> exerciseLogs,
  });

  $WorkoutLogCopyWith<$Res> get workoutLog;
}

/// @nodoc
class _$WorkoutSessionCopyWithImpl<$Res, $Val extends WorkoutSession>
    implements $WorkoutSessionCopyWith<$Res> {
  _$WorkoutSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? workoutLog = null, Object? exerciseLogs = null}) {
    return _then(
      _value.copyWith(
            workoutLog: null == workoutLog
                ? _value.workoutLog
                : workoutLog // ignore: cast_nullable_to_non_nullable
                      as WorkoutLog,
            exerciseLogs: null == exerciseLogs
                ? _value.exerciseLogs
                : exerciseLogs // ignore: cast_nullable_to_non_nullable
                      as Map<String, ExerciseSessionLog>,
          )
          as $Val,
    );
  }

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutLogCopyWith<$Res> get workoutLog {
    return $WorkoutLogCopyWith<$Res>(_value.workoutLog, (value) {
      return _then(_value.copyWith(workoutLog: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkoutSessionImplCopyWith<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  factory _$$WorkoutSessionImplCopyWith(
    _$WorkoutSessionImpl value,
    $Res Function(_$WorkoutSessionImpl) then,
  ) = __$$WorkoutSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    WorkoutLog workoutLog,
    Map<String, ExerciseSessionLog> exerciseLogs,
  });

  @override
  $WorkoutLogCopyWith<$Res> get workoutLog;
}

/// @nodoc
class __$$WorkoutSessionImplCopyWithImpl<$Res>
    extends _$WorkoutSessionCopyWithImpl<$Res, _$WorkoutSessionImpl>
    implements _$$WorkoutSessionImplCopyWith<$Res> {
  __$$WorkoutSessionImplCopyWithImpl(
    _$WorkoutSessionImpl _value,
    $Res Function(_$WorkoutSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? workoutLog = null, Object? exerciseLogs = null}) {
    return _then(
      _$WorkoutSessionImpl(
        workoutLog: null == workoutLog
            ? _value.workoutLog
            : workoutLog // ignore: cast_nullable_to_non_nullable
                  as WorkoutLog,
        exerciseLogs: null == exerciseLogs
            ? _value._exerciseLogs
            : exerciseLogs // ignore: cast_nullable_to_non_nullable
                  as Map<String, ExerciseSessionLog>,
      ),
    );
  }
}

/// @nodoc

class _$WorkoutSessionImpl extends _WorkoutSession {
  const _$WorkoutSessionImpl({
    required this.workoutLog,
    required final Map<String, ExerciseSessionLog> exerciseLogs,
  }) : _exerciseLogs = exerciseLogs,
       super._();

  @override
  final WorkoutLog workoutLog;
  final Map<String, ExerciseSessionLog> _exerciseLogs;
  @override
  Map<String, ExerciseSessionLog> get exerciseLogs {
    if (_exerciseLogs is EqualUnmodifiableMapView) return _exerciseLogs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_exerciseLogs);
  }

  @override
  String toString() {
    return 'WorkoutSession(workoutLog: $workoutLog, exerciseLogs: $exerciseLogs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSessionImpl &&
            (identical(other.workoutLog, workoutLog) ||
                other.workoutLog == workoutLog) &&
            const DeepCollectionEquality().equals(
              other._exerciseLogs,
              _exerciseLogs,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    workoutLog,
    const DeepCollectionEquality().hash(_exerciseLogs),
  );

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      __$$WorkoutSessionImplCopyWithImpl<_$WorkoutSessionImpl>(
        this,
        _$identity,
      );
}

abstract class _WorkoutSession extends WorkoutSession {
  const factory _WorkoutSession({
    required final WorkoutLog workoutLog,
    required final Map<String, ExerciseSessionLog> exerciseLogs,
  }) = _$WorkoutSessionImpl;
  const _WorkoutSession._() : super._();

  @override
  WorkoutLog get workoutLog;
  @override
  Map<String, ExerciseSessionLog> get exerciseLogs;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSessionImplCopyWith<_$WorkoutSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExerciseSessionLog {
  String get exerciseId => throw _privateConstructorUsedError;
  int get targetSets => throw _privateConstructorUsedError;
  List<SetLog> get sets => throw _privateConstructorUsedError;

  /// Create a copy of ExerciseSessionLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseSessionLogCopyWith<ExerciseSessionLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseSessionLogCopyWith<$Res> {
  factory $ExerciseSessionLogCopyWith(
    ExerciseSessionLog value,
    $Res Function(ExerciseSessionLog) then,
  ) = _$ExerciseSessionLogCopyWithImpl<$Res, ExerciseSessionLog>;
  @useResult
  $Res call({String exerciseId, int targetSets, List<SetLog> sets});
}

/// @nodoc
class _$ExerciseSessionLogCopyWithImpl<$Res, $Val extends ExerciseSessionLog>
    implements $ExerciseSessionLogCopyWith<$Res> {
  _$ExerciseSessionLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExerciseSessionLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? targetSets = null,
    Object? sets = null,
  }) {
    return _then(
      _value.copyWith(
            exerciseId: null == exerciseId
                ? _value.exerciseId
                : exerciseId // ignore: cast_nullable_to_non_nullable
                      as String,
            targetSets: null == targetSets
                ? _value.targetSets
                : targetSets // ignore: cast_nullable_to_non_nullable
                      as int,
            sets: null == sets
                ? _value.sets
                : sets // ignore: cast_nullable_to_non_nullable
                      as List<SetLog>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExerciseSessionLogImplCopyWith<$Res>
    implements $ExerciseSessionLogCopyWith<$Res> {
  factory _$$ExerciseSessionLogImplCopyWith(
    _$ExerciseSessionLogImpl value,
    $Res Function(_$ExerciseSessionLogImpl) then,
  ) = __$$ExerciseSessionLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String exerciseId, int targetSets, List<SetLog> sets});
}

/// @nodoc
class __$$ExerciseSessionLogImplCopyWithImpl<$Res>
    extends _$ExerciseSessionLogCopyWithImpl<$Res, _$ExerciseSessionLogImpl>
    implements _$$ExerciseSessionLogImplCopyWith<$Res> {
  __$$ExerciseSessionLogImplCopyWithImpl(
    _$ExerciseSessionLogImpl _value,
    $Res Function(_$ExerciseSessionLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExerciseSessionLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? targetSets = null,
    Object? sets = null,
  }) {
    return _then(
      _$ExerciseSessionLogImpl(
        exerciseId: null == exerciseId
            ? _value.exerciseId
            : exerciseId // ignore: cast_nullable_to_non_nullable
                  as String,
        targetSets: null == targetSets
            ? _value.targetSets
            : targetSets // ignore: cast_nullable_to_non_nullable
                  as int,
        sets: null == sets
            ? _value._sets
            : sets // ignore: cast_nullable_to_non_nullable
                  as List<SetLog>,
      ),
    );
  }
}

/// @nodoc

class _$ExerciseSessionLogImpl extends _ExerciseSessionLog {
  const _$ExerciseSessionLogImpl({
    required this.exerciseId,
    required this.targetSets,
    required final List<SetLog> sets,
  }) : _sets = sets,
       super._();

  @override
  final String exerciseId;
  @override
  final int targetSets;
  final List<SetLog> _sets;
  @override
  List<SetLog> get sets {
    if (_sets is EqualUnmodifiableListView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sets);
  }

  @override
  String toString() {
    return 'ExerciseSessionLog(exerciseId: $exerciseId, targetSets: $targetSets, sets: $sets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseSessionLogImpl &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.targetSets, targetSets) ||
                other.targetSets == targetSets) &&
            const DeepCollectionEquality().equals(other._sets, _sets));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    exerciseId,
    targetSets,
    const DeepCollectionEquality().hash(_sets),
  );

  /// Create a copy of ExerciseSessionLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseSessionLogImplCopyWith<_$ExerciseSessionLogImpl> get copyWith =>
      __$$ExerciseSessionLogImplCopyWithImpl<_$ExerciseSessionLogImpl>(
        this,
        _$identity,
      );
}

abstract class _ExerciseSessionLog extends ExerciseSessionLog {
  const factory _ExerciseSessionLog({
    required final String exerciseId,
    required final int targetSets,
    required final List<SetLog> sets,
  }) = _$ExerciseSessionLogImpl;
  const _ExerciseSessionLog._() : super._();

  @override
  String get exerciseId;
  @override
  int get targetSets;
  @override
  List<SetLog> get sets;

  /// Create a copy of ExerciseSessionLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseSessionLogImplCopyWith<_$ExerciseSessionLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SetLog {
  int get reps => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;

  /// Create a copy of SetLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SetLogCopyWith<SetLog> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetLogCopyWith<$Res> {
  factory $SetLogCopyWith(SetLog value, $Res Function(SetLog) then) =
      _$SetLogCopyWithImpl<$Res, SetLog>;
  @useResult
  $Res call({int reps, double weight, bool completed});
}

/// @nodoc
class _$SetLogCopyWithImpl<$Res, $Val extends SetLog>
    implements $SetLogCopyWith<$Res> {
  _$SetLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SetLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reps = null,
    Object? weight = null,
    Object? completed = null,
  }) {
    return _then(
      _value.copyWith(
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as int,
            weight: null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as double,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SetLogImplCopyWith<$Res> implements $SetLogCopyWith<$Res> {
  factory _$$SetLogImplCopyWith(
    _$SetLogImpl value,
    $Res Function(_$SetLogImpl) then,
  ) = __$$SetLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int reps, double weight, bool completed});
}

/// @nodoc
class __$$SetLogImplCopyWithImpl<$Res>
    extends _$SetLogCopyWithImpl<$Res, _$SetLogImpl>
    implements _$$SetLogImplCopyWith<$Res> {
  __$$SetLogImplCopyWithImpl(
    _$SetLogImpl _value,
    $Res Function(_$SetLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SetLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reps = null,
    Object? weight = null,
    Object? completed = null,
  }) {
    return _then(
      _$SetLogImpl(
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as int,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double,
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SetLogImpl implements _SetLog {
  const _$SetLogImpl({
    this.reps = 0,
    this.weight = 0.0,
    this.completed = false,
  });

  @override
  @JsonKey()
  final int reps;
  @override
  @JsonKey()
  final double weight;
  @override
  @JsonKey()
  final bool completed;

  @override
  String toString() {
    return 'SetLog(reps: $reps, weight: $weight, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetLogImpl &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reps, weight, completed);

  /// Create a copy of SetLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetLogImplCopyWith<_$SetLogImpl> get copyWith =>
      __$$SetLogImplCopyWithImpl<_$SetLogImpl>(this, _$identity);
}

abstract class _SetLog implements SetLog {
  const factory _SetLog({
    final int reps,
    final double weight,
    final bool completed,
  }) = _$SetLogImpl;

  @override
  int get reps;
  @override
  double get weight;
  @override
  bool get completed;

  /// Create a copy of SetLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetLogImplCopyWith<_$SetLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

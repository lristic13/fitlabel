// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkoutDetail _$WorkoutDetailFromJson(Map<String, dynamic> json) {
  return _WorkoutDetail.fromJson(json);
}

/// @nodoc
mixin _$WorkoutDetail {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get estimatedDurationMinutes => throw _privateConstructorUsedError;
  MediaFile? get coverImage => throw _privateConstructorUsedError;
  List<ExerciseEntry> get exerciseEntries => throw _privateConstructorUsedError;

  /// Serializes this WorkoutDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutDetailCopyWith<WorkoutDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutDetailCopyWith<$Res> {
  factory $WorkoutDetailCopyWith(
    WorkoutDetail value,
    $Res Function(WorkoutDetail) then,
  ) = _$WorkoutDetailCopyWithImpl<$Res, WorkoutDetail>;
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    int? estimatedDurationMinutes,
    MediaFile? coverImage,
    List<ExerciseEntry> exerciseEntries,
  });

  $MediaFileCopyWith<$Res>? get coverImage;
}

/// @nodoc
class _$WorkoutDetailCopyWithImpl<$Res, $Val extends WorkoutDetail>
    implements $WorkoutDetailCopyWith<$Res> {
  _$WorkoutDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? estimatedDurationMinutes = freezed,
    Object? coverImage = freezed,
    Object? exerciseEntries = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            estimatedDurationMinutes: freezed == estimatedDurationMinutes
                ? _value.estimatedDurationMinutes
                : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            coverImage: freezed == coverImage
                ? _value.coverImage
                : coverImage // ignore: cast_nullable_to_non_nullable
                      as MediaFile?,
            exerciseEntries: null == exerciseEntries
                ? _value.exerciseEntries
                : exerciseEntries // ignore: cast_nullable_to_non_nullable
                      as List<ExerciseEntry>,
          )
          as $Val,
    );
  }

  /// Create a copy of WorkoutDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MediaFileCopyWith<$Res>? get coverImage {
    if (_value.coverImage == null) {
      return null;
    }

    return $MediaFileCopyWith<$Res>(_value.coverImage!, (value) {
      return _then(_value.copyWith(coverImage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkoutDetailImplCopyWith<$Res>
    implements $WorkoutDetailCopyWith<$Res> {
  factory _$$WorkoutDetailImplCopyWith(
    _$WorkoutDetailImpl value,
    $Res Function(_$WorkoutDetailImpl) then,
  ) = __$$WorkoutDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    int? estimatedDurationMinutes,
    MediaFile? coverImage,
    List<ExerciseEntry> exerciseEntries,
  });

  @override
  $MediaFileCopyWith<$Res>? get coverImage;
}

/// @nodoc
class __$$WorkoutDetailImplCopyWithImpl<$Res>
    extends _$WorkoutDetailCopyWithImpl<$Res, _$WorkoutDetailImpl>
    implements _$$WorkoutDetailImplCopyWith<$Res> {
  __$$WorkoutDetailImplCopyWithImpl(
    _$WorkoutDetailImpl _value,
    $Res Function(_$WorkoutDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? estimatedDurationMinutes = freezed,
    Object? coverImage = freezed,
    Object? exerciseEntries = null,
  }) {
    return _then(
      _$WorkoutDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        estimatedDurationMinutes: freezed == estimatedDurationMinutes
            ? _value.estimatedDurationMinutes
            : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        coverImage: freezed == coverImage
            ? _value.coverImage
            : coverImage // ignore: cast_nullable_to_non_nullable
                  as MediaFile?,
        exerciseEntries: null == exerciseEntries
            ? _value._exerciseEntries
            : exerciseEntries // ignore: cast_nullable_to_non_nullable
                  as List<ExerciseEntry>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutDetailImpl implements _WorkoutDetail {
  const _$WorkoutDetailImpl({
    required this.id,
    required this.title,
    this.description,
    this.estimatedDurationMinutes,
    this.coverImage,
    required final List<ExerciseEntry> exerciseEntries,
  }) : _exerciseEntries = exerciseEntries;

  factory _$WorkoutDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutDetailImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final int? estimatedDurationMinutes;
  @override
  final MediaFile? coverImage;
  final List<ExerciseEntry> _exerciseEntries;
  @override
  List<ExerciseEntry> get exerciseEntries {
    if (_exerciseEntries is EqualUnmodifiableListView) return _exerciseEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exerciseEntries);
  }

  @override
  String toString() {
    return 'WorkoutDetail(id: $id, title: $title, description: $description, estimatedDurationMinutes: $estimatedDurationMinutes, coverImage: $coverImage, exerciseEntries: $exerciseEntries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(
                  other.estimatedDurationMinutes,
                  estimatedDurationMinutes,
                ) ||
                other.estimatedDurationMinutes == estimatedDurationMinutes) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            const DeepCollectionEquality().equals(
              other._exerciseEntries,
              _exerciseEntries,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    estimatedDurationMinutes,
    coverImage,
    const DeepCollectionEquality().hash(_exerciseEntries),
  );

  /// Create a copy of WorkoutDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutDetailImplCopyWith<_$WorkoutDetailImpl> get copyWith =>
      __$$WorkoutDetailImplCopyWithImpl<_$WorkoutDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutDetailImplToJson(this);
  }
}

abstract class _WorkoutDetail implements WorkoutDetail {
  const factory _WorkoutDetail({
    required final String id,
    required final String title,
    final String? description,
    final int? estimatedDurationMinutes,
    final MediaFile? coverImage,
    required final List<ExerciseEntry> exerciseEntries,
  }) = _$WorkoutDetailImpl;

  factory _WorkoutDetail.fromJson(Map<String, dynamic> json) =
      _$WorkoutDetailImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  int? get estimatedDurationMinutes;
  @override
  MediaFile? get coverImage;
  @override
  List<ExerciseEntry> get exerciseEntries;

  /// Create a copy of WorkoutDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutDetailImplCopyWith<_$WorkoutDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExerciseEntry _$ExerciseEntryFromJson(Map<String, dynamic> json) {
  return _ExerciseEntry.fromJson(json);
}

/// @nodoc
mixin _$ExerciseEntry {
  ExerciseBrief get exercise => throw _privateConstructorUsedError;
  int get ordering => throw _privateConstructorUsedError;
  int get sets => throw _privateConstructorUsedError;
  String get reps => throw _privateConstructorUsedError;
  int get restSeconds => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  int? get supersetGroup => throw _privateConstructorUsedError;

  /// Serializes this ExerciseEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExerciseEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseEntryCopyWith<ExerciseEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseEntryCopyWith<$Res> {
  factory $ExerciseEntryCopyWith(
    ExerciseEntry value,
    $Res Function(ExerciseEntry) then,
  ) = _$ExerciseEntryCopyWithImpl<$Res, ExerciseEntry>;
  @useResult
  $Res call({
    ExerciseBrief exercise,
    int ordering,
    int sets,
    String reps,
    int restSeconds,
    String? notes,
    int? supersetGroup,
  });

  $ExerciseBriefCopyWith<$Res> get exercise;
}

/// @nodoc
class _$ExerciseEntryCopyWithImpl<$Res, $Val extends ExerciseEntry>
    implements $ExerciseEntryCopyWith<$Res> {
  _$ExerciseEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExerciseEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercise = null,
    Object? ordering = null,
    Object? sets = null,
    Object? reps = null,
    Object? restSeconds = null,
    Object? notes = freezed,
    Object? supersetGroup = freezed,
  }) {
    return _then(
      _value.copyWith(
            exercise: null == exercise
                ? _value.exercise
                : exercise // ignore: cast_nullable_to_non_nullable
                      as ExerciseBrief,
            ordering: null == ordering
                ? _value.ordering
                : ordering // ignore: cast_nullable_to_non_nullable
                      as int,
            sets: null == sets
                ? _value.sets
                : sets // ignore: cast_nullable_to_non_nullable
                      as int,
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as String,
            restSeconds: null == restSeconds
                ? _value.restSeconds
                : restSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            supersetGroup: freezed == supersetGroup
                ? _value.supersetGroup
                : supersetGroup // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of ExerciseEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseBriefCopyWith<$Res> get exercise {
    return $ExerciseBriefCopyWith<$Res>(_value.exercise, (value) {
      return _then(_value.copyWith(exercise: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExerciseEntryImplCopyWith<$Res>
    implements $ExerciseEntryCopyWith<$Res> {
  factory _$$ExerciseEntryImplCopyWith(
    _$ExerciseEntryImpl value,
    $Res Function(_$ExerciseEntryImpl) then,
  ) = __$$ExerciseEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ExerciseBrief exercise,
    int ordering,
    int sets,
    String reps,
    int restSeconds,
    String? notes,
    int? supersetGroup,
  });

  @override
  $ExerciseBriefCopyWith<$Res> get exercise;
}

/// @nodoc
class __$$ExerciseEntryImplCopyWithImpl<$Res>
    extends _$ExerciseEntryCopyWithImpl<$Res, _$ExerciseEntryImpl>
    implements _$$ExerciseEntryImplCopyWith<$Res> {
  __$$ExerciseEntryImplCopyWithImpl(
    _$ExerciseEntryImpl _value,
    $Res Function(_$ExerciseEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExerciseEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exercise = null,
    Object? ordering = null,
    Object? sets = null,
    Object? reps = null,
    Object? restSeconds = null,
    Object? notes = freezed,
    Object? supersetGroup = freezed,
  }) {
    return _then(
      _$ExerciseEntryImpl(
        exercise: null == exercise
            ? _value.exercise
            : exercise // ignore: cast_nullable_to_non_nullable
                  as ExerciseBrief,
        ordering: null == ordering
            ? _value.ordering
            : ordering // ignore: cast_nullable_to_non_nullable
                  as int,
        sets: null == sets
            ? _value.sets
            : sets // ignore: cast_nullable_to_non_nullable
                  as int,
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as String,
        restSeconds: null == restSeconds
            ? _value.restSeconds
            : restSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        supersetGroup: freezed == supersetGroup
            ? _value.supersetGroup
            : supersetGroup // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseEntryImpl implements _ExerciseEntry {
  const _$ExerciseEntryImpl({
    required this.exercise,
    required this.ordering,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    this.notes,
    this.supersetGroup,
  });

  factory _$ExerciseEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseEntryImplFromJson(json);

  @override
  final ExerciseBrief exercise;
  @override
  final int ordering;
  @override
  final int sets;
  @override
  final String reps;
  @override
  final int restSeconds;
  @override
  final String? notes;
  @override
  final int? supersetGroup;

  @override
  String toString() {
    return 'ExerciseEntry(exercise: $exercise, ordering: $ordering, sets: $sets, reps: $reps, restSeconds: $restSeconds, notes: $notes, supersetGroup: $supersetGroup)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseEntryImpl &&
            (identical(other.exercise, exercise) ||
                other.exercise == exercise) &&
            (identical(other.ordering, ordering) ||
                other.ordering == ordering) &&
            (identical(other.sets, sets) || other.sets == sets) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.restSeconds, restSeconds) ||
                other.restSeconds == restSeconds) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.supersetGroup, supersetGroup) ||
                other.supersetGroup == supersetGroup));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    exercise,
    ordering,
    sets,
    reps,
    restSeconds,
    notes,
    supersetGroup,
  );

  /// Create a copy of ExerciseEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseEntryImplCopyWith<_$ExerciseEntryImpl> get copyWith =>
      __$$ExerciseEntryImplCopyWithImpl<_$ExerciseEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseEntryImplToJson(this);
  }
}

abstract class _ExerciseEntry implements ExerciseEntry {
  const factory _ExerciseEntry({
    required final ExerciseBrief exercise,
    required final int ordering,
    required final int sets,
    required final String reps,
    required final int restSeconds,
    final String? notes,
    final int? supersetGroup,
  }) = _$ExerciseEntryImpl;

  factory _ExerciseEntry.fromJson(Map<String, dynamic> json) =
      _$ExerciseEntryImpl.fromJson;

  @override
  ExerciseBrief get exercise;
  @override
  int get ordering;
  @override
  int get sets;
  @override
  String get reps;
  @override
  int get restSeconds;
  @override
  String? get notes;
  @override
  int? get supersetGroup;

  /// Create a copy of ExerciseEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseEntryImplCopyWith<_$ExerciseEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExerciseBrief _$ExerciseBriefFromJson(Map<String, dynamic> json) {
  return _ExerciseBrief.fromJson(json);
}

/// @nodoc
mixin _$ExerciseBrief {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get muscleGroups => throw _privateConstructorUsedError;
  String? get equipment => throw _privateConstructorUsedError;
  MediaFile? get demoImage => throw _privateConstructorUsedError;

  /// Serializes this ExerciseBrief to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExerciseBrief
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseBriefCopyWith<ExerciseBrief> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseBriefCopyWith<$Res> {
  factory $ExerciseBriefCopyWith(
    ExerciseBrief value,
    $Res Function(ExerciseBrief) then,
  ) = _$ExerciseBriefCopyWithImpl<$Res, ExerciseBrief>;
  @useResult
  $Res call({
    String id,
    String name,
    List<String> muscleGroups,
    String? equipment,
    MediaFile? demoImage,
  });

  $MediaFileCopyWith<$Res>? get demoImage;
}

/// @nodoc
class _$ExerciseBriefCopyWithImpl<$Res, $Val extends ExerciseBrief>
    implements $ExerciseBriefCopyWith<$Res> {
  _$ExerciseBriefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExerciseBrief
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? muscleGroups = null,
    Object? equipment = freezed,
    Object? demoImage = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            muscleGroups: null == muscleGroups
                ? _value.muscleGroups
                : muscleGroups // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            equipment: freezed == equipment
                ? _value.equipment
                : equipment // ignore: cast_nullable_to_non_nullable
                      as String?,
            demoImage: freezed == demoImage
                ? _value.demoImage
                : demoImage // ignore: cast_nullable_to_non_nullable
                      as MediaFile?,
          )
          as $Val,
    );
  }

  /// Create a copy of ExerciseBrief
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MediaFileCopyWith<$Res>? get demoImage {
    if (_value.demoImage == null) {
      return null;
    }

    return $MediaFileCopyWith<$Res>(_value.demoImage!, (value) {
      return _then(_value.copyWith(demoImage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExerciseBriefImplCopyWith<$Res>
    implements $ExerciseBriefCopyWith<$Res> {
  factory _$$ExerciseBriefImplCopyWith(
    _$ExerciseBriefImpl value,
    $Res Function(_$ExerciseBriefImpl) then,
  ) = __$$ExerciseBriefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    List<String> muscleGroups,
    String? equipment,
    MediaFile? demoImage,
  });

  @override
  $MediaFileCopyWith<$Res>? get demoImage;
}

/// @nodoc
class __$$ExerciseBriefImplCopyWithImpl<$Res>
    extends _$ExerciseBriefCopyWithImpl<$Res, _$ExerciseBriefImpl>
    implements _$$ExerciseBriefImplCopyWith<$Res> {
  __$$ExerciseBriefImplCopyWithImpl(
    _$ExerciseBriefImpl _value,
    $Res Function(_$ExerciseBriefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExerciseBrief
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? muscleGroups = null,
    Object? equipment = freezed,
    Object? demoImage = freezed,
  }) {
    return _then(
      _$ExerciseBriefImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        muscleGroups: null == muscleGroups
            ? _value._muscleGroups
            : muscleGroups // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        equipment: freezed == equipment
            ? _value.equipment
            : equipment // ignore: cast_nullable_to_non_nullable
                  as String?,
        demoImage: freezed == demoImage
            ? _value.demoImage
            : demoImage // ignore: cast_nullable_to_non_nullable
                  as MediaFile?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseBriefImpl implements _ExerciseBrief {
  const _$ExerciseBriefImpl({
    required this.id,
    required this.name,
    required final List<String> muscleGroups,
    this.equipment,
    this.demoImage,
  }) : _muscleGroups = muscleGroups;

  factory _$ExerciseBriefImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseBriefImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _muscleGroups;
  @override
  List<String> get muscleGroups {
    if (_muscleGroups is EqualUnmodifiableListView) return _muscleGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_muscleGroups);
  }

  @override
  final String? equipment;
  @override
  final MediaFile? demoImage;

  @override
  String toString() {
    return 'ExerciseBrief(id: $id, name: $name, muscleGroups: $muscleGroups, equipment: $equipment, demoImage: $demoImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseBriefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
              other._muscleGroups,
              _muscleGroups,
            ) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.demoImage, demoImage) ||
                other.demoImage == demoImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_muscleGroups),
    equipment,
    demoImage,
  );

  /// Create a copy of ExerciseBrief
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseBriefImplCopyWith<_$ExerciseBriefImpl> get copyWith =>
      __$$ExerciseBriefImplCopyWithImpl<_$ExerciseBriefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseBriefImplToJson(this);
  }
}

abstract class _ExerciseBrief implements ExerciseBrief {
  const factory _ExerciseBrief({
    required final String id,
    required final String name,
    required final List<String> muscleGroups,
    final String? equipment,
    final MediaFile? demoImage,
  }) = _$ExerciseBriefImpl;

  factory _ExerciseBrief.fromJson(Map<String, dynamic> json) =
      _$ExerciseBriefImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<String> get muscleGroups;
  @override
  String? get equipment;
  @override
  MediaFile? get demoImage;

  /// Create a copy of ExerciseBrief
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseBriefImplCopyWith<_$ExerciseBriefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkoutLog _$WorkoutLogFromJson(Map<String, dynamic> json) {
  return _WorkoutLog.fromJson(json);
}

/// @nodoc
mixin _$WorkoutLog {
  String get id => throw _privateConstructorUsedError;
  String get workout => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int? get durationSeconds => throw _privateConstructorUsedError;

  /// Serializes this WorkoutLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutLogCopyWith<WorkoutLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutLogCopyWith<$Res> {
  factory $WorkoutLogCopyWith(
    WorkoutLog value,
    $Res Function(WorkoutLog) then,
  ) = _$WorkoutLogCopyWithImpl<$Res, WorkoutLog>;
  @useResult
  $Res call({
    String id,
    String workout,
    DateTime startedAt,
    DateTime? completedAt,
    int? durationSeconds,
  });
}

/// @nodoc
class _$WorkoutLogCopyWithImpl<$Res, $Val extends WorkoutLog>
    implements $WorkoutLogCopyWith<$Res> {
  _$WorkoutLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workout = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? durationSeconds = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            workout: null == workout
                ? _value.workout
                : workout // ignore: cast_nullable_to_non_nullable
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutLogImplCopyWith<$Res>
    implements $WorkoutLogCopyWith<$Res> {
  factory _$$WorkoutLogImplCopyWith(
    _$WorkoutLogImpl value,
    $Res Function(_$WorkoutLogImpl) then,
  ) = __$$WorkoutLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String workout,
    DateTime startedAt,
    DateTime? completedAt,
    int? durationSeconds,
  });
}

/// @nodoc
class __$$WorkoutLogImplCopyWithImpl<$Res>
    extends _$WorkoutLogCopyWithImpl<$Res, _$WorkoutLogImpl>
    implements _$$WorkoutLogImplCopyWith<$Res> {
  __$$WorkoutLogImplCopyWithImpl(
    _$WorkoutLogImpl _value,
    $Res Function(_$WorkoutLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workout = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? durationSeconds = freezed,
  }) {
    return _then(
      _$WorkoutLogImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        workout: null == workout
            ? _value.workout
            : workout // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutLogImpl implements _WorkoutLog {
  const _$WorkoutLogImpl({
    required this.id,
    required this.workout,
    required this.startedAt,
    this.completedAt,
    this.durationSeconds,
  });

  factory _$WorkoutLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutLogImplFromJson(json);

  @override
  final String id;
  @override
  final String workout;
  @override
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  @override
  final int? durationSeconds;

  @override
  String toString() {
    return 'WorkoutLog(id: $id, workout: $workout, startedAt: $startedAt, completedAt: $completedAt, durationSeconds: $durationSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workout, workout) || other.workout == workout) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    workout,
    startedAt,
    completedAt,
    durationSeconds,
  );

  /// Create a copy of WorkoutLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutLogImplCopyWith<_$WorkoutLogImpl> get copyWith =>
      __$$WorkoutLogImplCopyWithImpl<_$WorkoutLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutLogImplToJson(this);
  }
}

abstract class _WorkoutLog implements WorkoutLog {
  const factory _WorkoutLog({
    required final String id,
    required final String workout,
    required final DateTime startedAt,
    final DateTime? completedAt,
    final int? durationSeconds,
  }) = _$WorkoutLogImpl;

  factory _WorkoutLog.fromJson(Map<String, dynamic> json) =
      _$WorkoutLogImpl.fromJson;

  @override
  String get id;
  @override
  String get workout;
  @override
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  int? get durationSeconds;

  /// Create a copy of WorkoutLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutLogImplCopyWith<_$WorkoutLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

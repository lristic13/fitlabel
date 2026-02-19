// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Program _$ProgramFromJson(Map<String, dynamic> json) {
  return _Program.fromJson(json);
}

/// @nodoc
mixin _$Program {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  int get durationWeeks => throw _privateConstructorUsedError;
  bool get isFree => throw _privateConstructorUsedError;
  MediaFile? get coverImage => throw _privateConstructorUsedError;
  int get ordering => throw _privateConstructorUsedError;

  /// Serializes this Program to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Program
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramCopyWith<Program> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramCopyWith<$Res> {
  factory $ProgramCopyWith(Program value, $Res Function(Program) then) =
      _$ProgramCopyWithImpl<$Res, Program>;
  @useResult
  $Res call({
    String id,
    String title,
    String difficulty,
    int durationWeeks,
    bool isFree,
    MediaFile? coverImage,
    int ordering,
  });

  $MediaFileCopyWith<$Res>? get coverImage;
}

/// @nodoc
class _$ProgramCopyWithImpl<$Res, $Val extends Program>
    implements $ProgramCopyWith<$Res> {
  _$ProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Program
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? difficulty = null,
    Object? durationWeeks = null,
    Object? isFree = null,
    Object? coverImage = freezed,
    Object? ordering = null,
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
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String,
            durationWeeks: null == durationWeeks
                ? _value.durationWeeks
                : durationWeeks // ignore: cast_nullable_to_non_nullable
                      as int,
            isFree: null == isFree
                ? _value.isFree
                : isFree // ignore: cast_nullable_to_non_nullable
                      as bool,
            coverImage: freezed == coverImage
                ? _value.coverImage
                : coverImage // ignore: cast_nullable_to_non_nullable
                      as MediaFile?,
            ordering: null == ordering
                ? _value.ordering
                : ordering // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of Program
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
abstract class _$$ProgramImplCopyWith<$Res> implements $ProgramCopyWith<$Res> {
  factory _$$ProgramImplCopyWith(
    _$ProgramImpl value,
    $Res Function(_$ProgramImpl) then,
  ) = __$$ProgramImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String difficulty,
    int durationWeeks,
    bool isFree,
    MediaFile? coverImage,
    int ordering,
  });

  @override
  $MediaFileCopyWith<$Res>? get coverImage;
}

/// @nodoc
class __$$ProgramImplCopyWithImpl<$Res>
    extends _$ProgramCopyWithImpl<$Res, _$ProgramImpl>
    implements _$$ProgramImplCopyWith<$Res> {
  __$$ProgramImplCopyWithImpl(
    _$ProgramImpl _value,
    $Res Function(_$ProgramImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Program
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? difficulty = null,
    Object? durationWeeks = null,
    Object? isFree = null,
    Object? coverImage = freezed,
    Object? ordering = null,
  }) {
    return _then(
      _$ProgramImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String,
        durationWeeks: null == durationWeeks
            ? _value.durationWeeks
            : durationWeeks // ignore: cast_nullable_to_non_nullable
                  as int,
        isFree: null == isFree
            ? _value.isFree
            : isFree // ignore: cast_nullable_to_non_nullable
                  as bool,
        coverImage: freezed == coverImage
            ? _value.coverImage
            : coverImage // ignore: cast_nullable_to_non_nullable
                  as MediaFile?,
        ordering: null == ordering
            ? _value.ordering
            : ordering // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramImpl implements _Program {
  const _$ProgramImpl({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.durationWeeks,
    required this.isFree,
    this.coverImage,
    required this.ordering,
  });

  factory _$ProgramImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String difficulty;
  @override
  final int durationWeeks;
  @override
  final bool isFree;
  @override
  final MediaFile? coverImage;
  @override
  final int ordering;

  @override
  String toString() {
    return 'Program(id: $id, title: $title, difficulty: $difficulty, durationWeeks: $durationWeeks, isFree: $isFree, coverImage: $coverImage, ordering: $ordering)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.durationWeeks, durationWeeks) ||
                other.durationWeeks == durationWeeks) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.ordering, ordering) ||
                other.ordering == ordering));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    difficulty,
    durationWeeks,
    isFree,
    coverImage,
    ordering,
  );

  /// Create a copy of Program
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramImplCopyWith<_$ProgramImpl> get copyWith =>
      __$$ProgramImplCopyWithImpl<_$ProgramImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramImplToJson(this);
  }
}

abstract class _Program implements Program {
  const factory _Program({
    required final String id,
    required final String title,
    required final String difficulty,
    required final int durationWeeks,
    required final bool isFree,
    final MediaFile? coverImage,
    required final int ordering,
  }) = _$ProgramImpl;

  factory _Program.fromJson(Map<String, dynamic> json) = _$ProgramImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get difficulty;
  @override
  int get durationWeeks;
  @override
  bool get isFree;
  @override
  MediaFile? get coverImage;
  @override
  int get ordering;

  /// Create a copy of Program
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramImplCopyWith<_$ProgramImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgramDetail _$ProgramDetailFromJson(Map<String, dynamic> json) {
  return _ProgramDetail.fromJson(json);
}

/// @nodoc
mixin _$ProgramDetail {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  int get durationWeeks => throw _privateConstructorUsedError;
  bool get isFree => throw _privateConstructorUsedError;
  MediaFile? get coverImage => throw _privateConstructorUsedError;
  List<ProgramWeek> get weeks => throw _privateConstructorUsedError;

  /// Serializes this ProgramDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgramDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramDetailCopyWith<ProgramDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramDetailCopyWith<$Res> {
  factory $ProgramDetailCopyWith(
    ProgramDetail value,
    $Res Function(ProgramDetail) then,
  ) = _$ProgramDetailCopyWithImpl<$Res, ProgramDetail>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String difficulty,
    int durationWeeks,
    bool isFree,
    MediaFile? coverImage,
    List<ProgramWeek> weeks,
  });

  $MediaFileCopyWith<$Res>? get coverImage;
}

/// @nodoc
class _$ProgramDetailCopyWithImpl<$Res, $Val extends ProgramDetail>
    implements $ProgramDetailCopyWith<$Res> {
  _$ProgramDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? difficulty = null,
    Object? durationWeeks = null,
    Object? isFree = null,
    Object? coverImage = freezed,
    Object? weeks = null,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String,
            durationWeeks: null == durationWeeks
                ? _value.durationWeeks
                : durationWeeks // ignore: cast_nullable_to_non_nullable
                      as int,
            isFree: null == isFree
                ? _value.isFree
                : isFree // ignore: cast_nullable_to_non_nullable
                      as bool,
            coverImage: freezed == coverImage
                ? _value.coverImage
                : coverImage // ignore: cast_nullable_to_non_nullable
                      as MediaFile?,
            weeks: null == weeks
                ? _value.weeks
                : weeks // ignore: cast_nullable_to_non_nullable
                      as List<ProgramWeek>,
          )
          as $Val,
    );
  }

  /// Create a copy of ProgramDetail
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
abstract class _$$ProgramDetailImplCopyWith<$Res>
    implements $ProgramDetailCopyWith<$Res> {
  factory _$$ProgramDetailImplCopyWith(
    _$ProgramDetailImpl value,
    $Res Function(_$ProgramDetailImpl) then,
  ) = __$$ProgramDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String difficulty,
    int durationWeeks,
    bool isFree,
    MediaFile? coverImage,
    List<ProgramWeek> weeks,
  });

  @override
  $MediaFileCopyWith<$Res>? get coverImage;
}

/// @nodoc
class __$$ProgramDetailImplCopyWithImpl<$Res>
    extends _$ProgramDetailCopyWithImpl<$Res, _$ProgramDetailImpl>
    implements _$$ProgramDetailImplCopyWith<$Res> {
  __$$ProgramDetailImplCopyWithImpl(
    _$ProgramDetailImpl _value,
    $Res Function(_$ProgramDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgramDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? difficulty = null,
    Object? durationWeeks = null,
    Object? isFree = null,
    Object? coverImage = freezed,
    Object? weeks = null,
  }) {
    return _then(
      _$ProgramDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String,
        durationWeeks: null == durationWeeks
            ? _value.durationWeeks
            : durationWeeks // ignore: cast_nullable_to_non_nullable
                  as int,
        isFree: null == isFree
            ? _value.isFree
            : isFree // ignore: cast_nullable_to_non_nullable
                  as bool,
        coverImage: freezed == coverImage
            ? _value.coverImage
            : coverImage // ignore: cast_nullable_to_non_nullable
                  as MediaFile?,
        weeks: null == weeks
            ? _value._weeks
            : weeks // ignore: cast_nullable_to_non_nullable
                  as List<ProgramWeek>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramDetailImpl implements _ProgramDetail {
  const _$ProgramDetailImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.durationWeeks,
    required this.isFree,
    this.coverImage,
    required final List<ProgramWeek> weeks,
  }) : _weeks = weeks;

  factory _$ProgramDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramDetailImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String difficulty;
  @override
  final int durationWeeks;
  @override
  final bool isFree;
  @override
  final MediaFile? coverImage;
  final List<ProgramWeek> _weeks;
  @override
  List<ProgramWeek> get weeks {
    if (_weeks is EqualUnmodifiableListView) return _weeks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeks);
  }

  @override
  String toString() {
    return 'ProgramDetail(id: $id, title: $title, description: $description, difficulty: $difficulty, durationWeeks: $durationWeeks, isFree: $isFree, coverImage: $coverImage, weeks: $weeks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.durationWeeks, durationWeeks) ||
                other.durationWeeks == durationWeeks) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            const DeepCollectionEquality().equals(other._weeks, _weeks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    difficulty,
    durationWeeks,
    isFree,
    coverImage,
    const DeepCollectionEquality().hash(_weeks),
  );

  /// Create a copy of ProgramDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramDetailImplCopyWith<_$ProgramDetailImpl> get copyWith =>
      __$$ProgramDetailImplCopyWithImpl<_$ProgramDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramDetailImplToJson(this);
  }
}

abstract class _ProgramDetail implements ProgramDetail {
  const factory _ProgramDetail({
    required final String id,
    required final String title,
    required final String description,
    required final String difficulty,
    required final int durationWeeks,
    required final bool isFree,
    final MediaFile? coverImage,
    required final List<ProgramWeek> weeks,
  }) = _$ProgramDetailImpl;

  factory _ProgramDetail.fromJson(Map<String, dynamic> json) =
      _$ProgramDetailImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get difficulty;
  @override
  int get durationWeeks;
  @override
  bool get isFree;
  @override
  MediaFile? get coverImage;
  @override
  List<ProgramWeek> get weeks;

  /// Create a copy of ProgramDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramDetailImplCopyWith<_$ProgramDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgramWeek _$ProgramWeekFromJson(Map<String, dynamic> json) {
  return _ProgramWeek.fromJson(json);
}

/// @nodoc
mixin _$ProgramWeek {
  int get id => throw _privateConstructorUsedError;
  int get weekNumber => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<ProgramDay> get days => throw _privateConstructorUsedError;

  /// Serializes this ProgramWeek to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgramWeek
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramWeekCopyWith<ProgramWeek> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramWeekCopyWith<$Res> {
  factory $ProgramWeekCopyWith(
    ProgramWeek value,
    $Res Function(ProgramWeek) then,
  ) = _$ProgramWeekCopyWithImpl<$Res, ProgramWeek>;
  @useResult
  $Res call({int id, int weekNumber, String title, List<ProgramDay> days});
}

/// @nodoc
class _$ProgramWeekCopyWithImpl<$Res, $Val extends ProgramWeek>
    implements $ProgramWeekCopyWith<$Res> {
  _$ProgramWeekCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramWeek
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekNumber = null,
    Object? title = null,
    Object? days = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            weekNumber: null == weekNumber
                ? _value.weekNumber
                : weekNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            days: null == days
                ? _value.days
                : days // ignore: cast_nullable_to_non_nullable
                      as List<ProgramDay>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProgramWeekImplCopyWith<$Res>
    implements $ProgramWeekCopyWith<$Res> {
  factory _$$ProgramWeekImplCopyWith(
    _$ProgramWeekImpl value,
    $Res Function(_$ProgramWeekImpl) then,
  ) = __$$ProgramWeekImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int weekNumber, String title, List<ProgramDay> days});
}

/// @nodoc
class __$$ProgramWeekImplCopyWithImpl<$Res>
    extends _$ProgramWeekCopyWithImpl<$Res, _$ProgramWeekImpl>
    implements _$$ProgramWeekImplCopyWith<$Res> {
  __$$ProgramWeekImplCopyWithImpl(
    _$ProgramWeekImpl _value,
    $Res Function(_$ProgramWeekImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgramWeek
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekNumber = null,
    Object? title = null,
    Object? days = null,
  }) {
    return _then(
      _$ProgramWeekImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        weekNumber: null == weekNumber
            ? _value.weekNumber
            : weekNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        days: null == days
            ? _value._days
            : days // ignore: cast_nullable_to_non_nullable
                  as List<ProgramDay>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramWeekImpl implements _ProgramWeek {
  const _$ProgramWeekImpl({
    required this.id,
    required this.weekNumber,
    required this.title,
    required final List<ProgramDay> days,
  }) : _days = days;

  factory _$ProgramWeekImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramWeekImplFromJson(json);

  @override
  final int id;
  @override
  final int weekNumber;
  @override
  final String title;
  final List<ProgramDay> _days;
  @override
  List<ProgramDay> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  String toString() {
    return 'ProgramWeek(id: $id, weekNumber: $weekNumber, title: $title, days: $days)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramWeekImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weekNumber, weekNumber) ||
                other.weekNumber == weekNumber) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._days, _days));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    weekNumber,
    title,
    const DeepCollectionEquality().hash(_days),
  );

  /// Create a copy of ProgramWeek
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramWeekImplCopyWith<_$ProgramWeekImpl> get copyWith =>
      __$$ProgramWeekImplCopyWithImpl<_$ProgramWeekImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramWeekImplToJson(this);
  }
}

abstract class _ProgramWeek implements ProgramWeek {
  const factory _ProgramWeek({
    required final int id,
    required final int weekNumber,
    required final String title,
    required final List<ProgramDay> days,
  }) = _$ProgramWeekImpl;

  factory _ProgramWeek.fromJson(Map<String, dynamic> json) =
      _$ProgramWeekImpl.fromJson;

  @override
  int get id;
  @override
  int get weekNumber;
  @override
  String get title;
  @override
  List<ProgramDay> get days;

  /// Create a copy of ProgramWeek
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramWeekImplCopyWith<_$ProgramWeekImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgramDay _$ProgramDayFromJson(Map<String, dynamic> json) {
  return _ProgramDay.fromJson(json);
}

/// @nodoc
mixin _$ProgramDay {
  int get id => throw _privateConstructorUsedError;
  int get dayNumber => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get workoutId => throw _privateConstructorUsedError;
  String? get workoutTitle => throw _privateConstructorUsedError;
  bool get isRestDay => throw _privateConstructorUsedError;

  /// Serializes this ProgramDay to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramDayCopyWith<ProgramDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramDayCopyWith<$Res> {
  factory $ProgramDayCopyWith(
    ProgramDay value,
    $Res Function(ProgramDay) then,
  ) = _$ProgramDayCopyWithImpl<$Res, ProgramDay>;
  @useResult
  $Res call({
    int id,
    int dayNumber,
    String title,
    String? workoutId,
    String? workoutTitle,
    bool isRestDay,
  });
}

/// @nodoc
class _$ProgramDayCopyWithImpl<$Res, $Val extends ProgramDay>
    implements $ProgramDayCopyWith<$Res> {
  _$ProgramDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dayNumber = null,
    Object? title = null,
    Object? workoutId = freezed,
    Object? workoutTitle = freezed,
    Object? isRestDay = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            dayNumber: null == dayNumber
                ? _value.dayNumber
                : dayNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            workoutId: freezed == workoutId
                ? _value.workoutId
                : workoutId // ignore: cast_nullable_to_non_nullable
                      as String?,
            workoutTitle: freezed == workoutTitle
                ? _value.workoutTitle
                : workoutTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            isRestDay: null == isRestDay
                ? _value.isRestDay
                : isRestDay // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProgramDayImplCopyWith<$Res>
    implements $ProgramDayCopyWith<$Res> {
  factory _$$ProgramDayImplCopyWith(
    _$ProgramDayImpl value,
    $Res Function(_$ProgramDayImpl) then,
  ) = __$$ProgramDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int dayNumber,
    String title,
    String? workoutId,
    String? workoutTitle,
    bool isRestDay,
  });
}

/// @nodoc
class __$$ProgramDayImplCopyWithImpl<$Res>
    extends _$ProgramDayCopyWithImpl<$Res, _$ProgramDayImpl>
    implements _$$ProgramDayImplCopyWith<$Res> {
  __$$ProgramDayImplCopyWithImpl(
    _$ProgramDayImpl _value,
    $Res Function(_$ProgramDayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dayNumber = null,
    Object? title = null,
    Object? workoutId = freezed,
    Object? workoutTitle = freezed,
    Object? isRestDay = null,
  }) {
    return _then(
      _$ProgramDayImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        dayNumber: null == dayNumber
            ? _value.dayNumber
            : dayNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        workoutId: freezed == workoutId
            ? _value.workoutId
            : workoutId // ignore: cast_nullable_to_non_nullable
                  as String?,
        workoutTitle: freezed == workoutTitle
            ? _value.workoutTitle
            : workoutTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        isRestDay: null == isRestDay
            ? _value.isRestDay
            : isRestDay // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramDayImpl implements _ProgramDay {
  const _$ProgramDayImpl({
    required this.id,
    required this.dayNumber,
    required this.title,
    this.workoutId,
    this.workoutTitle,
    required this.isRestDay,
  });

  factory _$ProgramDayImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramDayImplFromJson(json);

  @override
  final int id;
  @override
  final int dayNumber;
  @override
  final String title;
  @override
  final String? workoutId;
  @override
  final String? workoutTitle;
  @override
  final bool isRestDay;

  @override
  String toString() {
    return 'ProgramDay(id: $id, dayNumber: $dayNumber, title: $title, workoutId: $workoutId, workoutTitle: $workoutTitle, isRestDay: $isRestDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramDayImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dayNumber, dayNumber) ||
                other.dayNumber == dayNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.workoutId, workoutId) ||
                other.workoutId == workoutId) &&
            (identical(other.workoutTitle, workoutTitle) ||
                other.workoutTitle == workoutTitle) &&
            (identical(other.isRestDay, isRestDay) ||
                other.isRestDay == isRestDay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    dayNumber,
    title,
    workoutId,
    workoutTitle,
    isRestDay,
  );

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramDayImplCopyWith<_$ProgramDayImpl> get copyWith =>
      __$$ProgramDayImplCopyWithImpl<_$ProgramDayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramDayImplToJson(this);
  }
}

abstract class _ProgramDay implements ProgramDay {
  const factory _ProgramDay({
    required final int id,
    required final int dayNumber,
    required final String title,
    final String? workoutId,
    final String? workoutTitle,
    required final bool isRestDay,
  }) = _$ProgramDayImpl;

  factory _ProgramDay.fromJson(Map<String, dynamic> json) =
      _$ProgramDayImpl.fromJson;

  @override
  int get id;
  @override
  int get dayNumber;
  @override
  String get title;
  @override
  String? get workoutId;
  @override
  String? get workoutTitle;
  @override
  bool get isRestDay;

  /// Create a copy of ProgramDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramDayImplCopyWith<_$ProgramDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgramProgress _$ProgramProgressFromJson(Map<String, dynamic> json) {
  return _ProgramProgress.fromJson(json);
}

/// @nodoc
mixin _$ProgramProgress {
  String get id => throw _privateConstructorUsedError;
  int get currentWeek => throw _privateConstructorUsedError;
  int get currentDay => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this ProgramProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgramProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramProgressCopyWith<ProgramProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramProgressCopyWith<$Res> {
  factory $ProgramProgressCopyWith(
    ProgramProgress value,
    $Res Function(ProgramProgress) then,
  ) = _$ProgramProgressCopyWithImpl<$Res, ProgramProgress>;
  @useResult
  $Res call({
    String id,
    int currentWeek,
    int currentDay,
    DateTime startedAt,
    DateTime? completedAt,
    bool isActive,
  });
}

/// @nodoc
class _$ProgramProgressCopyWithImpl<$Res, $Val extends ProgramProgress>
    implements $ProgramProgressCopyWith<$Res> {
  _$ProgramProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currentWeek = null,
    Object? currentDay = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            currentWeek: null == currentWeek
                ? _value.currentWeek
                : currentWeek // ignore: cast_nullable_to_non_nullable
                      as int,
            currentDay: null == currentDay
                ? _value.currentDay
                : currentDay // ignore: cast_nullable_to_non_nullable
                      as int,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProgramProgressImplCopyWith<$Res>
    implements $ProgramProgressCopyWith<$Res> {
  factory _$$ProgramProgressImplCopyWith(
    _$ProgramProgressImpl value,
    $Res Function(_$ProgramProgressImpl) then,
  ) = __$$ProgramProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int currentWeek,
    int currentDay,
    DateTime startedAt,
    DateTime? completedAt,
    bool isActive,
  });
}

/// @nodoc
class __$$ProgramProgressImplCopyWithImpl<$Res>
    extends _$ProgramProgressCopyWithImpl<$Res, _$ProgramProgressImpl>
    implements _$$ProgramProgressImplCopyWith<$Res> {
  __$$ProgramProgressImplCopyWithImpl(
    _$ProgramProgressImpl _value,
    $Res Function(_$ProgramProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgramProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? currentWeek = null,
    Object? currentDay = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$ProgramProgressImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        currentWeek: null == currentWeek
            ? _value.currentWeek
            : currentWeek // ignore: cast_nullable_to_non_nullable
                  as int,
        currentDay: null == currentDay
            ? _value.currentDay
            : currentDay // ignore: cast_nullable_to_non_nullable
                  as int,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramProgressImpl implements _ProgramProgress {
  const _$ProgramProgressImpl({
    required this.id,
    required this.currentWeek,
    required this.currentDay,
    required this.startedAt,
    this.completedAt,
    required this.isActive,
  });

  factory _$ProgramProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramProgressImplFromJson(json);

  @override
  final String id;
  @override
  final int currentWeek;
  @override
  final int currentDay;
  @override
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  @override
  final bool isActive;

  @override
  String toString() {
    return 'ProgramProgress(id: $id, currentWeek: $currentWeek, currentDay: $currentDay, startedAt: $startedAt, completedAt: $completedAt, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramProgressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.currentWeek, currentWeek) ||
                other.currentWeek == currentWeek) &&
            (identical(other.currentDay, currentDay) ||
                other.currentDay == currentDay) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    currentWeek,
    currentDay,
    startedAt,
    completedAt,
    isActive,
  );

  /// Create a copy of ProgramProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramProgressImplCopyWith<_$ProgramProgressImpl> get copyWith =>
      __$$ProgramProgressImplCopyWithImpl<_$ProgramProgressImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramProgressImplToJson(this);
  }
}

abstract class _ProgramProgress implements ProgramProgress {
  const factory _ProgramProgress({
    required final String id,
    required final int currentWeek,
    required final int currentDay,
    required final DateTime startedAt,
    final DateTime? completedAt,
    required final bool isActive,
  }) = _$ProgramProgressImpl;

  factory _ProgramProgress.fromJson(Map<String, dynamic> json) =
      _$ProgramProgressImpl.fromJson;

  @override
  String get id;
  @override
  int get currentWeek;
  @override
  int get currentDay;
  @override
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  bool get isActive;

  /// Create a copy of ProgramProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramProgressImplCopyWith<_$ProgramProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

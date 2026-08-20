// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  String? get departmentId => throw _privateConstructorUsedError;
  String? get studentRollNo => throw _privateConstructorUsedError;
  String? get facultyId => throw _privateConstructorUsedError;
  List<String> get joinedClubIds => throw _privateConstructorUsedError;
  List<String> get administeredClubIds => throw _privateConstructorUsedError;
  int get totalPoints => throw _privateConstructorUsedError;
  int get streakDays => throw _privateConstructorUsedError;
  List<String> get interests => throw _privateConstructorUsedError;
  bool get isProfileComplete => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    String id,
    String email,
    String? displayName,
    String? photoUrl,
    UserRole role,
    String? departmentId,
    String? studentRollNo,
    String? facultyId,
    List<String> joinedClubIds,
    List<String> administeredClubIds,
    int totalPoints,
    int streakDays,
    List<String> interests,
    bool isProfileComplete,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? role = null,
    Object? departmentId = freezed,
    Object? studentRollNo = freezed,
    Object? facultyId = freezed,
    Object? joinedClubIds = null,
    Object? administeredClubIds = null,
    Object? totalPoints = null,
    Object? streakDays = null,
    Object? interests = null,
    Object? isProfileComplete = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            photoUrl: freezed == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as UserRole,
            departmentId: freezed == departmentId
                ? _value.departmentId
                : departmentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            studentRollNo: freezed == studentRollNo
                ? _value.studentRollNo
                : studentRollNo // ignore: cast_nullable_to_non_nullable
                      as String?,
            facultyId: freezed == facultyId
                ? _value.facultyId
                : facultyId // ignore: cast_nullable_to_non_nullable
                      as String?,
            joinedClubIds: null == joinedClubIds
                ? _value.joinedClubIds
                : joinedClubIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            administeredClubIds: null == administeredClubIds
                ? _value.administeredClubIds
                : administeredClubIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            totalPoints: null == totalPoints
                ? _value.totalPoints
                : totalPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            streakDays: null == streakDays
                ? _value.streakDays
                : streakDays // ignore: cast_nullable_to_non_nullable
                      as int,
            interests: null == interests
                ? _value.interests
                : interests // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isProfileComplete: null == isProfileComplete
                ? _value.isProfileComplete
                : isProfileComplete // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String? displayName,
    String? photoUrl,
    UserRole role,
    String? departmentId,
    String? studentRollNo,
    String? facultyId,
    List<String> joinedClubIds,
    List<String> administeredClubIds,
    int totalPoints,
    int streakDays,
    List<String> interests,
    bool isProfileComplete,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? role = null,
    Object? departmentId = freezed,
    Object? studentRollNo = freezed,
    Object? facultyId = freezed,
    Object? joinedClubIds = null,
    Object? administeredClubIds = null,
    Object? totalPoints = null,
    Object? streakDays = null,
    Object? interests = null,
    Object? isProfileComplete = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        photoUrl: freezed == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as UserRole,
        departmentId: freezed == departmentId
            ? _value.departmentId
            : departmentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        studentRollNo: freezed == studentRollNo
            ? _value.studentRollNo
            : studentRollNo // ignore: cast_nullable_to_non_nullable
                  as String?,
        facultyId: freezed == facultyId
            ? _value.facultyId
            : facultyId // ignore: cast_nullable_to_non_nullable
                  as String?,
        joinedClubIds: null == joinedClubIds
            ? _value._joinedClubIds
            : joinedClubIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        administeredClubIds: null == administeredClubIds
            ? _value._administeredClubIds
            : administeredClubIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        totalPoints: null == totalPoints
            ? _value.totalPoints
            : totalPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        streakDays: null == streakDays
            ? _value.streakDays
            : streakDays // ignore: cast_nullable_to_non_nullable
                  as int,
        interests: null == interests
            ? _value._interests
            : interests // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isProfileComplete: null == isProfileComplete
            ? _value.isProfileComplete
            : isProfileComplete // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.role = UserRole.student,
    this.departmentId,
    this.studentRollNo,
    this.facultyId,
    final List<String> joinedClubIds = const [],
    final List<String> administeredClubIds = const [],
    this.totalPoints = 0,
    this.streakDays = 0,
    final List<String> interests = const [],
    this.isProfileComplete = false,
    @TimestampConverter() required this.createdAt,
    @TimestampConverter() required this.updatedAt,
  }) : _joinedClubIds = joinedClubIds,
       _administeredClubIds = administeredClubIds,
       _interests = interests;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final String? photoUrl;
  @override
  @JsonKey()
  final UserRole role;
  @override
  final String? departmentId;
  @override
  final String? studentRollNo;
  @override
  final String? facultyId;
  final List<String> _joinedClubIds;
  @override
  @JsonKey()
  List<String> get joinedClubIds {
    if (_joinedClubIds is EqualUnmodifiableListView) return _joinedClubIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_joinedClubIds);
  }

  final List<String> _administeredClubIds;
  @override
  @JsonKey()
  List<String> get administeredClubIds {
    if (_administeredClubIds is EqualUnmodifiableListView)
      return _administeredClubIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_administeredClubIds);
  }

  @override
  @JsonKey()
  final int totalPoints;
  @override
  @JsonKey()
  final int streakDays;
  final List<String> _interests;
  @override
  @JsonKey()
  List<String> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  @override
  @JsonKey()
  final bool isProfileComplete;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl, role: $role, departmentId: $departmentId, studentRollNo: $studentRollNo, facultyId: $facultyId, joinedClubIds: $joinedClubIds, administeredClubIds: $administeredClubIds, totalPoints: $totalPoints, streakDays: $streakDays, interests: $interests, isProfileComplete: $isProfileComplete, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.studentRollNo, studentRollNo) ||
                other.studentRollNo == studentRollNo) &&
            (identical(other.facultyId, facultyId) ||
                other.facultyId == facultyId) &&
            const DeepCollectionEquality().equals(
              other._joinedClubIds,
              _joinedClubIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._administeredClubIds,
              _administeredClubIds,
            ) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays) &&
            const DeepCollectionEquality().equals(
              other._interests,
              _interests,
            ) &&
            (identical(other.isProfileComplete, isProfileComplete) ||
                other.isProfileComplete == isProfileComplete) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    displayName,
    photoUrl,
    role,
    departmentId,
    studentRollNo,
    facultyId,
    const DeepCollectionEquality().hash(_joinedClubIds),
    const DeepCollectionEquality().hash(_administeredClubIds),
    totalPoints,
    streakDays,
    const DeepCollectionEquality().hash(_interests),
    isProfileComplete,
    createdAt,
    updatedAt,
  );

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    required final String id,
    required final String email,
    final String? displayName,
    final String? photoUrl,
    final UserRole role,
    final String? departmentId,
    final String? studentRollNo,
    final String? facultyId,
    final List<String> joinedClubIds,
    final List<String> administeredClubIds,
    final int totalPoints,
    final int streakDays,
    final List<String> interests,
    final bool isProfileComplete,
    @TimestampConverter() required final DateTime createdAt,
    @TimestampConverter() required final DateTime updatedAt,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String? get displayName;
  @override
  String? get photoUrl;
  @override
  UserRole get role;
  @override
  String? get departmentId;
  @override
  String? get studentRollNo;
  @override
  String? get facultyId;
  @override
  List<String> get joinedClubIds;
  @override
  List<String> get administeredClubIds;
  @override
  int get totalPoints;
  @override
  int get streakDays;
  @override
  List<String> get interests;
  @override
  bool get isProfileComplete;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

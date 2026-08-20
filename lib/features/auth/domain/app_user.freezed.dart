// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  String? get departmentId => throw _privateConstructorUsedError;
  String? get studentId => throw _privateConstructorUsedError;
  String? get facultyEmployeeId => throw _privateConstructorUsedError;
  List<String> get joinedClubIds => throw _privateConstructorUsedError;
  List<String> get administeredClubIds => throw _privateConstructorUsedError;
  int get totalPoints => throw _privateConstructorUsedError;
  bool get isProfileComplete => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call({
    String id,
    String email,
    String? displayName,
    String? photoUrl,
    UserRole role,
    String? departmentId,
    String? studentId,
    String? facultyEmployeeId,
    List<String> joinedClubIds,
    List<String> administeredClubIds,
    int totalPoints,
    bool isProfileComplete,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppUser
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
    Object? studentId = freezed,
    Object? facultyEmployeeId = freezed,
    Object? joinedClubIds = null,
    Object? administeredClubIds = null,
    Object? totalPoints = null,
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
            studentId: freezed == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            facultyEmployeeId: freezed == facultyEmployeeId
                ? _value.facultyEmployeeId
                : facultyEmployeeId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
    _$AppUserImpl value,
    $Res Function(_$AppUserImpl) then,
  ) = __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String? displayName,
    String? photoUrl,
    UserRole role,
    String? departmentId,
    String? studentId,
    String? facultyEmployeeId,
    List<String> joinedClubIds,
    List<String> administeredClubIds,
    int totalPoints,
    bool isProfileComplete,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
    _$AppUserImpl _value,
    $Res Function(_$AppUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppUser
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
    Object? studentId = freezed,
    Object? facultyEmployeeId = freezed,
    Object? joinedClubIds = null,
    Object? administeredClubIds = null,
    Object? totalPoints = null,
    Object? isProfileComplete = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$AppUserImpl(
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
        studentId: freezed == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        facultyEmployeeId: freezed == facultyEmployeeId
            ? _value.facultyEmployeeId
            : facultyEmployeeId // ignore: cast_nullable_to_non_nullable
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
class _$AppUserImpl implements _AppUser {
  const _$AppUserImpl({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.role = UserRole.student,
    this.departmentId,
    this.studentId,
    this.facultyEmployeeId,
    final List<String> joinedClubIds = const [],
    final List<String> administeredClubIds = const [],
    this.totalPoints = 0,
    this.isProfileComplete = false,
    required this.createdAt,
    required this.updatedAt,
  }) : _joinedClubIds = joinedClubIds,
       _administeredClubIds = administeredClubIds;

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

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
  final String? studentId;
  @override
  final String? facultyEmployeeId;
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
  final bool isProfileComplete;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl, role: $role, departmentId: $departmentId, studentId: $studentId, facultyEmployeeId: $facultyEmployeeId, joinedClubIds: $joinedClubIds, administeredClubIds: $administeredClubIds, totalPoints: $totalPoints, isProfileComplete: $isProfileComplete, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.facultyEmployeeId, facultyEmployeeId) ||
                other.facultyEmployeeId == facultyEmployeeId) &&
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
    studentId,
    facultyEmployeeId,
    const DeepCollectionEquality().hash(_joinedClubIds),
    const DeepCollectionEquality().hash(_administeredClubIds),
    totalPoints,
    isProfileComplete,
    createdAt,
    updatedAt,
  );

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(this);
  }
}

abstract class _AppUser implements AppUser {
  const factory _AppUser({
    required final String id,
    required final String email,
    final String? displayName,
    final String? photoUrl,
    final UserRole role,
    final String? departmentId,
    final String? studentId,
    final String? facultyEmployeeId,
    final List<String> joinedClubIds,
    final List<String> administeredClubIds,
    final int totalPoints,
    final bool isProfileComplete,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$AppUserImpl;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

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
  String? get studentId;
  @override
  String? get facultyEmployeeId;
  @override
  List<String> get joinedClubIds;
  @override
  List<String> get administeredClubIds;
  @override
  int get totalPoints;
  @override
  bool get isProfileComplete;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

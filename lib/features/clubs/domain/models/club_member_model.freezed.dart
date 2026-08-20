// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClubMemberModel _$ClubMemberModelFromJson(Map<String, dynamic> json) {
  return _ClubMemberModel.fromJson(json);
}

/// @nodoc
mixin _$ClubMemberModel {
  String get id => throw _privateConstructorUsedError;
  String get clubId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  MemberRole get role => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get joinedAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this ClubMemberModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClubMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubMemberModelCopyWith<ClubMemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubMemberModelCopyWith<$Res> {
  factory $ClubMemberModelCopyWith(
    ClubMemberModel value,
    $Res Function(ClubMemberModel) then,
  ) = _$ClubMemberModelCopyWithImpl<$Res, ClubMemberModel>;
  @useResult
  $Res call({
    String id,
    String clubId,
    String userId,
    MemberRole role,
    @TimestampConverter() DateTime joinedAt,
    bool isActive,
  });
}

/// @nodoc
class _$ClubMemberModelCopyWithImpl<$Res, $Val extends ClubMemberModel>
    implements $ClubMemberModelCopyWith<$Res> {
  _$ClubMemberModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClubMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clubId = null,
    Object? userId = null,
    Object? role = null,
    Object? joinedAt = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            clubId: null == clubId
                ? _value.clubId
                : clubId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as MemberRole,
            joinedAt: null == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
abstract class _$$ClubMemberModelImplCopyWith<$Res>
    implements $ClubMemberModelCopyWith<$Res> {
  factory _$$ClubMemberModelImplCopyWith(
    _$ClubMemberModelImpl value,
    $Res Function(_$ClubMemberModelImpl) then,
  ) = __$$ClubMemberModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String clubId,
    String userId,
    MemberRole role,
    @TimestampConverter() DateTime joinedAt,
    bool isActive,
  });
}

/// @nodoc
class __$$ClubMemberModelImplCopyWithImpl<$Res>
    extends _$ClubMemberModelCopyWithImpl<$Res, _$ClubMemberModelImpl>
    implements _$$ClubMemberModelImplCopyWith<$Res> {
  __$$ClubMemberModelImplCopyWithImpl(
    _$ClubMemberModelImpl _value,
    $Res Function(_$ClubMemberModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClubMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clubId = null,
    Object? userId = null,
    Object? role = null,
    Object? joinedAt = null,
    Object? isActive = null,
  }) {
    return _then(
      _$ClubMemberModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        clubId: null == clubId
            ? _value.clubId
            : clubId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as MemberRole,
        joinedAt: null == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
class _$ClubMemberModelImpl implements _ClubMemberModel {
  const _$ClubMemberModelImpl({
    required this.id,
    required this.clubId,
    required this.userId,
    this.role = MemberRole.member,
    @TimestampConverter() required this.joinedAt,
    this.isActive = true,
  });

  factory _$ClubMemberModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubMemberModelImplFromJson(json);

  @override
  final String id;
  @override
  final String clubId;
  @override
  final String userId;
  @override
  @JsonKey()
  final MemberRole role;
  @override
  @TimestampConverter()
  final DateTime joinedAt;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'ClubMemberModel(id: $id, clubId: $clubId, userId: $userId, role: $role, joinedAt: $joinedAt, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubMemberModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, clubId, userId, role, joinedAt, isActive);

  /// Create a copy of ClubMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubMemberModelImplCopyWith<_$ClubMemberModelImpl> get copyWith =>
      __$$ClubMemberModelImplCopyWithImpl<_$ClubMemberModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubMemberModelImplToJson(this);
  }
}

abstract class _ClubMemberModel implements ClubMemberModel {
  const factory _ClubMemberModel({
    required final String id,
    required final String clubId,
    required final String userId,
    final MemberRole role,
    @TimestampConverter() required final DateTime joinedAt,
    final bool isActive,
  }) = _$ClubMemberModelImpl;

  factory _ClubMemberModel.fromJson(Map<String, dynamic> json) =
      _$ClubMemberModelImpl.fromJson;

  @override
  String get id;
  @override
  String get clubId;
  @override
  String get userId;
  @override
  MemberRole get role;
  @override
  @TimestampConverter()
  DateTime get joinedAt;
  @override
  bool get isActive;

  /// Create a copy of ClubMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubMemberModelImplCopyWith<_$ClubMemberModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

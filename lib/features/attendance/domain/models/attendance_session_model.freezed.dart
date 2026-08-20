// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AttendanceSessionModel _$AttendanceSessionModelFromJson(
  Map<String, dynamic> json,
) {
  return _AttendanceSessionModel.fromJson(json);
}

/// @nodoc
mixin _$AttendanceSessionModel {
  String get id => throw _privateConstructorUsedError;
  String get eventId => throw _privateConstructorUsedError;
  String get clubId => throw _privateConstructorUsedError;
  String get sessionToken => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get expiresAt => throw _privateConstructorUsedError;
  String get createdByUserId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AttendanceSessionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceSessionModelCopyWith<AttendanceSessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceSessionModelCopyWith<$Res> {
  factory $AttendanceSessionModelCopyWith(
    AttendanceSessionModel value,
    $Res Function(AttendanceSessionModel) then,
  ) = _$AttendanceSessionModelCopyWithImpl<$Res, AttendanceSessionModel>;
  @useResult
  $Res call({
    String id,
    String eventId,
    String clubId,
    String sessionToken,
    bool isActive,
    @TimestampConverter() DateTime expiresAt,
    String createdByUserId,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$AttendanceSessionModelCopyWithImpl<
  $Res,
  $Val extends AttendanceSessionModel
>
    implements $AttendanceSessionModelCopyWith<$Res> {
  _$AttendanceSessionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? clubId = null,
    Object? sessionToken = null,
    Object? isActive = null,
    Object? expiresAt = null,
    Object? createdByUserId = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            eventId: null == eventId
                ? _value.eventId
                : eventId // ignore: cast_nullable_to_non_nullable
                      as String,
            clubId: null == clubId
                ? _value.clubId
                : clubId // ignore: cast_nullable_to_non_nullable
                      as String,
            sessionToken: null == sessionToken
                ? _value.sessionToken
                : sessionToken // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdByUserId: null == createdByUserId
                ? _value.createdByUserId
                : createdByUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttendanceSessionModelImplCopyWith<$Res>
    implements $AttendanceSessionModelCopyWith<$Res> {
  factory _$$AttendanceSessionModelImplCopyWith(
    _$AttendanceSessionModelImpl value,
    $Res Function(_$AttendanceSessionModelImpl) then,
  ) = __$$AttendanceSessionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String eventId,
    String clubId,
    String sessionToken,
    bool isActive,
    @TimestampConverter() DateTime expiresAt,
    String createdByUserId,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$AttendanceSessionModelImplCopyWithImpl<$Res>
    extends
        _$AttendanceSessionModelCopyWithImpl<$Res, _$AttendanceSessionModelImpl>
    implements _$$AttendanceSessionModelImplCopyWith<$Res> {
  __$$AttendanceSessionModelImplCopyWithImpl(
    _$AttendanceSessionModelImpl _value,
    $Res Function(_$AttendanceSessionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? clubId = null,
    Object? sessionToken = null,
    Object? isActive = null,
    Object? expiresAt = null,
    Object? createdByUserId = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$AttendanceSessionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        eventId: null == eventId
            ? _value.eventId
            : eventId // ignore: cast_nullable_to_non_nullable
                  as String,
        clubId: null == clubId
            ? _value.clubId
            : clubId // ignore: cast_nullable_to_non_nullable
                  as String,
        sessionToken: null == sessionToken
            ? _value.sessionToken
            : sessionToken // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdByUserId: null == createdByUserId
            ? _value.createdByUserId
            : createdByUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceSessionModelImpl implements _AttendanceSessionModel {
  const _$AttendanceSessionModelImpl({
    required this.id,
    required this.eventId,
    required this.clubId,
    required this.sessionToken,
    this.isActive = true,
    @TimestampConverter() required this.expiresAt,
    required this.createdByUserId,
    @TimestampConverter() required this.createdAt,
  });

  factory _$AttendanceSessionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceSessionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String eventId;
  @override
  final String clubId;
  @override
  final String sessionToken;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @TimestampConverter()
  final DateTime expiresAt;
  @override
  final String createdByUserId;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'AttendanceSessionModel(id: $id, eventId: $eventId, clubId: $clubId, sessionToken: $sessionToken, isActive: $isActive, expiresAt: $expiresAt, createdByUserId: $createdByUserId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceSessionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.sessionToken, sessionToken) ||
                other.sessionToken == sessionToken) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdByUserId, createdByUserId) ||
                other.createdByUserId == createdByUserId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    eventId,
    clubId,
    sessionToken,
    isActive,
    expiresAt,
    createdByUserId,
    createdAt,
  );

  /// Create a copy of AttendanceSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceSessionModelImplCopyWith<_$AttendanceSessionModelImpl>
  get copyWith =>
      __$$AttendanceSessionModelImplCopyWithImpl<_$AttendanceSessionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceSessionModelImplToJson(this);
  }
}

abstract class _AttendanceSessionModel implements AttendanceSessionModel {
  const factory _AttendanceSessionModel({
    required final String id,
    required final String eventId,
    required final String clubId,
    required final String sessionToken,
    final bool isActive,
    @TimestampConverter() required final DateTime expiresAt,
    required final String createdByUserId,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$AttendanceSessionModelImpl;

  factory _AttendanceSessionModel.fromJson(Map<String, dynamic> json) =
      _$AttendanceSessionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get eventId;
  @override
  String get clubId;
  @override
  String get sessionToken;
  @override
  bool get isActive;
  @override
  @TimestampConverter()
  DateTime get expiresAt;
  @override
  String get createdByUserId;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of AttendanceSessionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceSessionModelImplCopyWith<_$AttendanceSessionModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

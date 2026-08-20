// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_registration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EventRegistrationModel _$EventRegistrationModelFromJson(
  Map<String, dynamic> json,
) {
  return _EventRegistrationModel.fromJson(json);
}

/// @nodoc
mixin _$EventRegistrationModel {
  String get id => throw _privateConstructorUsedError;
  String get eventId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get clubId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get registeredAt => throw _privateConstructorUsedError;
  RegistrationStatus get status => throw _privateConstructorUsedError;
  String? get cancellationReason => throw _privateConstructorUsedError;

  /// Serializes this EventRegistrationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventRegistrationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventRegistrationModelCopyWith<EventRegistrationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventRegistrationModelCopyWith<$Res> {
  factory $EventRegistrationModelCopyWith(
    EventRegistrationModel value,
    $Res Function(EventRegistrationModel) then,
  ) = _$EventRegistrationModelCopyWithImpl<$Res, EventRegistrationModel>;
  @useResult
  $Res call({
    String id,
    String eventId,
    String userId,
    String clubId,
    @TimestampConverter() DateTime registeredAt,
    RegistrationStatus status,
    String? cancellationReason,
  });
}

/// @nodoc
class _$EventRegistrationModelCopyWithImpl<
  $Res,
  $Val extends EventRegistrationModel
>
    implements $EventRegistrationModelCopyWith<$Res> {
  _$EventRegistrationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventRegistrationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? clubId = null,
    Object? registeredAt = null,
    Object? status = null,
    Object? cancellationReason = freezed,
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
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            clubId: null == clubId
                ? _value.clubId
                : clubId // ignore: cast_nullable_to_non_nullable
                      as String,
            registeredAt: null == registeredAt
                ? _value.registeredAt
                : registeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RegistrationStatus,
            cancellationReason: freezed == cancellationReason
                ? _value.cancellationReason
                : cancellationReason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EventRegistrationModelImplCopyWith<$Res>
    implements $EventRegistrationModelCopyWith<$Res> {
  factory _$$EventRegistrationModelImplCopyWith(
    _$EventRegistrationModelImpl value,
    $Res Function(_$EventRegistrationModelImpl) then,
  ) = __$$EventRegistrationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String eventId,
    String userId,
    String clubId,
    @TimestampConverter() DateTime registeredAt,
    RegistrationStatus status,
    String? cancellationReason,
  });
}

/// @nodoc
class __$$EventRegistrationModelImplCopyWithImpl<$Res>
    extends
        _$EventRegistrationModelCopyWithImpl<$Res, _$EventRegistrationModelImpl>
    implements _$$EventRegistrationModelImplCopyWith<$Res> {
  __$$EventRegistrationModelImplCopyWithImpl(
    _$EventRegistrationModelImpl _value,
    $Res Function(_$EventRegistrationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EventRegistrationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? clubId = null,
    Object? registeredAt = null,
    Object? status = null,
    Object? cancellationReason = freezed,
  }) {
    return _then(
      _$EventRegistrationModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        eventId: null == eventId
            ? _value.eventId
            : eventId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        clubId: null == clubId
            ? _value.clubId
            : clubId // ignore: cast_nullable_to_non_nullable
                  as String,
        registeredAt: null == registeredAt
            ? _value.registeredAt
            : registeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RegistrationStatus,
        cancellationReason: freezed == cancellationReason
            ? _value.cancellationReason
            : cancellationReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EventRegistrationModelImpl implements _EventRegistrationModel {
  const _$EventRegistrationModelImpl({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.clubId,
    @TimestampConverter() required this.registeredAt,
    this.status = RegistrationStatus.registered,
    this.cancellationReason,
  });

  factory _$EventRegistrationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventRegistrationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String eventId;
  @override
  final String userId;
  @override
  final String clubId;
  @override
  @TimestampConverter()
  final DateTime registeredAt;
  @override
  @JsonKey()
  final RegistrationStatus status;
  @override
  final String? cancellationReason;

  @override
  String toString() {
    return 'EventRegistrationModel(id: $id, eventId: $eventId, userId: $userId, clubId: $clubId, registeredAt: $registeredAt, status: $status, cancellationReason: $cancellationReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventRegistrationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.registeredAt, registeredAt) ||
                other.registeredAt == registeredAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    eventId,
    userId,
    clubId,
    registeredAt,
    status,
    cancellationReason,
  );

  /// Create a copy of EventRegistrationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventRegistrationModelImplCopyWith<_$EventRegistrationModelImpl>
  get copyWith =>
      __$$EventRegistrationModelImplCopyWithImpl<_$EventRegistrationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EventRegistrationModelImplToJson(this);
  }
}

abstract class _EventRegistrationModel implements EventRegistrationModel {
  const factory _EventRegistrationModel({
    required final String id,
    required final String eventId,
    required final String userId,
    required final String clubId,
    @TimestampConverter() required final DateTime registeredAt,
    final RegistrationStatus status,
    final String? cancellationReason,
  }) = _$EventRegistrationModelImpl;

  factory _EventRegistrationModel.fromJson(Map<String, dynamic> json) =
      _$EventRegistrationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get eventId;
  @override
  String get userId;
  @override
  String get clubId;
  @override
  @TimestampConverter()
  DateTime get registeredAt;
  @override
  RegistrationStatus get status;
  @override
  String? get cancellationReason;

  /// Create a copy of EventRegistrationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventRegistrationModelImplCopyWith<_$EventRegistrationModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

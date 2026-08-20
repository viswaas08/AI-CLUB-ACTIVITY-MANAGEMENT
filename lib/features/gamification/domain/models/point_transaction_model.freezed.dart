// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PointTransactionModel _$PointTransactionModelFromJson(
  Map<String, dynamic> json,
) {
  return _PointTransactionModel.fromJson(json);
}

/// @nodoc
mixin _$PointTransactionModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  TransactionType get transactionType => throw _privateConstructorUsedError;
  TransactionSource get source => throw _privateConstructorUsedError;
  String? get referenceId => throw _privateConstructorUsedError;
  String? get performedByUserId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this PointTransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointTransactionModelCopyWith<PointTransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointTransactionModelCopyWith<$Res> {
  factory $PointTransactionModelCopyWith(
    PointTransactionModel value,
    $Res Function(PointTransactionModel) then,
  ) = _$PointTransactionModelCopyWithImpl<$Res, PointTransactionModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    int points,
    TransactionType transactionType,
    TransactionSource source,
    String? referenceId,
    String? performedByUserId,
    @TimestampConverter() DateTime timestamp,
  });
}

/// @nodoc
class _$PointTransactionModelCopyWithImpl<
  $Res,
  $Val extends PointTransactionModel
>
    implements $PointTransactionModelCopyWith<$Res> {
  _$PointTransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? points = null,
    Object? transactionType = null,
    Object? source = null,
    Object? referenceId = freezed,
    Object? performedByUserId = freezed,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            transactionType: null == transactionType
                ? _value.transactionType
                : transactionType // ignore: cast_nullable_to_non_nullable
                      as TransactionType,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as TransactionSource,
            referenceId: freezed == referenceId
                ? _value.referenceId
                : referenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            performedByUserId: freezed == performedByUserId
                ? _value.performedByUserId
                : performedByUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointTransactionModelImplCopyWith<$Res>
    implements $PointTransactionModelCopyWith<$Res> {
  factory _$$PointTransactionModelImplCopyWith(
    _$PointTransactionModelImpl value,
    $Res Function(_$PointTransactionModelImpl) then,
  ) = __$$PointTransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    int points,
    TransactionType transactionType,
    TransactionSource source,
    String? referenceId,
    String? performedByUserId,
    @TimestampConverter() DateTime timestamp,
  });
}

/// @nodoc
class __$$PointTransactionModelImplCopyWithImpl<$Res>
    extends
        _$PointTransactionModelCopyWithImpl<$Res, _$PointTransactionModelImpl>
    implements _$$PointTransactionModelImplCopyWith<$Res> {
  __$$PointTransactionModelImplCopyWithImpl(
    _$PointTransactionModelImpl _value,
    $Res Function(_$PointTransactionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? points = null,
    Object? transactionType = null,
    Object? source = null,
    Object? referenceId = freezed,
    Object? performedByUserId = freezed,
    Object? timestamp = null,
  }) {
    return _then(
      _$PointTransactionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        transactionType: null == transactionType
            ? _value.transactionType
            : transactionType // ignore: cast_nullable_to_non_nullable
                  as TransactionType,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as TransactionSource,
        referenceId: freezed == referenceId
            ? _value.referenceId
            : referenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        performedByUserId: freezed == performedByUserId
            ? _value.performedByUserId
            : performedByUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointTransactionModelImpl implements _PointTransactionModel {
  const _$PointTransactionModelImpl({
    required this.id,
    required this.userId,
    required this.points,
    this.transactionType = TransactionType.credit,
    this.source = TransactionSource.eventAttendance,
    this.referenceId,
    this.performedByUserId,
    @TimestampConverter() required this.timestamp,
  });

  factory _$PointTransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointTransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final int points;
  @override
  @JsonKey()
  final TransactionType transactionType;
  @override
  @JsonKey()
  final TransactionSource source;
  @override
  final String? referenceId;
  @override
  final String? performedByUserId;
  @override
  @TimestampConverter()
  final DateTime timestamp;

  @override
  String toString() {
    return 'PointTransactionModel(id: $id, userId: $userId, points: $points, transactionType: $transactionType, source: $source, referenceId: $referenceId, performedByUserId: $performedByUserId, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointTransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.performedByUserId, performedByUserId) ||
                other.performedByUserId == performedByUserId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    points,
    transactionType,
    source,
    referenceId,
    performedByUserId,
    timestamp,
  );

  /// Create a copy of PointTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointTransactionModelImplCopyWith<_$PointTransactionModelImpl>
  get copyWith =>
      __$$PointTransactionModelImplCopyWithImpl<_$PointTransactionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointTransactionModelImplToJson(this);
  }
}

abstract class _PointTransactionModel implements PointTransactionModel {
  const factory _PointTransactionModel({
    required final String id,
    required final String userId,
    required final int points,
    final TransactionType transactionType,
    final TransactionSource source,
    final String? referenceId,
    final String? performedByUserId,
    @TimestampConverter() required final DateTime timestamp,
  }) = _$PointTransactionModelImpl;

  factory _PointTransactionModel.fromJson(Map<String, dynamic> json) =
      _$PointTransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  int get points;
  @override
  TransactionType get transactionType;
  @override
  TransactionSource get source;
  @override
  String? get referenceId;
  @override
  String? get performedByUserId;
  @override
  @TimestampConverter()
  DateTime get timestamp;

  /// Create a copy of PointTransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointTransactionModelImplCopyWith<_$PointTransactionModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

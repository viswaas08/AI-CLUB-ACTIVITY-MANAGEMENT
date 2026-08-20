// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_rule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PointRuleModel _$PointRuleModelFromJson(Map<String, dynamic> json) {
  return _PointRuleModel.fromJson(json);
}

/// @nodoc
mixin _$PointRuleModel {
  String get id => throw _privateConstructorUsedError;
  ActivityType get activityType => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String get updatedByUserId => throw _privateConstructorUsedError;

  /// Serializes this PointRuleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointRuleModelCopyWith<PointRuleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointRuleModelCopyWith<$Res> {
  factory $PointRuleModelCopyWith(
    PointRuleModel value,
    $Res Function(PointRuleModel) then,
  ) = _$PointRuleModelCopyWithImpl<$Res, PointRuleModel>;
  @useResult
  $Res call({
    String id,
    ActivityType activityType,
    int points,
    String description,
    @TimestampConverter() DateTime updatedAt,
    String updatedByUserId,
  });
}

/// @nodoc
class _$PointRuleModelCopyWithImpl<$Res, $Val extends PointRuleModel>
    implements $PointRuleModelCopyWith<$Res> {
  _$PointRuleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? activityType = null,
    Object? points = null,
    Object? description = null,
    Object? updatedAt = null,
    Object? updatedByUserId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            activityType: null == activityType
                ? _value.activityType
                : activityType // ignore: cast_nullable_to_non_nullable
                      as ActivityType,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedByUserId: null == updatedByUserId
                ? _value.updatedByUserId
                : updatedByUserId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointRuleModelImplCopyWith<$Res>
    implements $PointRuleModelCopyWith<$Res> {
  factory _$$PointRuleModelImplCopyWith(
    _$PointRuleModelImpl value,
    $Res Function(_$PointRuleModelImpl) then,
  ) = __$$PointRuleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    ActivityType activityType,
    int points,
    String description,
    @TimestampConverter() DateTime updatedAt,
    String updatedByUserId,
  });
}

/// @nodoc
class __$$PointRuleModelImplCopyWithImpl<$Res>
    extends _$PointRuleModelCopyWithImpl<$Res, _$PointRuleModelImpl>
    implements _$$PointRuleModelImplCopyWith<$Res> {
  __$$PointRuleModelImplCopyWithImpl(
    _$PointRuleModelImpl _value,
    $Res Function(_$PointRuleModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? activityType = null,
    Object? points = null,
    Object? description = null,
    Object? updatedAt = null,
    Object? updatedByUserId = null,
  }) {
    return _then(
      _$PointRuleModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        activityType: null == activityType
            ? _value.activityType
            : activityType // ignore: cast_nullable_to_non_nullable
                  as ActivityType,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedByUserId: null == updatedByUserId
            ? _value.updatedByUserId
            : updatedByUserId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointRuleModelImpl implements _PointRuleModel {
  const _$PointRuleModelImpl({
    required this.id,
    required this.activityType,
    required this.points,
    required this.description,
    @TimestampConverter() required this.updatedAt,
    required this.updatedByUserId,
  });

  factory _$PointRuleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointRuleModelImplFromJson(json);

  @override
  final String id;
  @override
  final ActivityType activityType;
  @override
  final int points;
  @override
  final String description;
  @override
  @TimestampConverter()
  final DateTime updatedAt;
  @override
  final String updatedByUserId;

  @override
  String toString() {
    return 'PointRuleModel(id: $id, activityType: $activityType, points: $points, description: $description, updatedAt: $updatedAt, updatedByUserId: $updatedByUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointRuleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updatedByUserId, updatedByUserId) ||
                other.updatedByUserId == updatedByUserId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    activityType,
    points,
    description,
    updatedAt,
    updatedByUserId,
  );

  /// Create a copy of PointRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointRuleModelImplCopyWith<_$PointRuleModelImpl> get copyWith =>
      __$$PointRuleModelImplCopyWithImpl<_$PointRuleModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointRuleModelImplToJson(this);
  }
}

abstract class _PointRuleModel implements PointRuleModel {
  const factory _PointRuleModel({
    required final String id,
    required final ActivityType activityType,
    required final int points,
    required final String description,
    @TimestampConverter() required final DateTime updatedAt,
    required final String updatedByUserId,
  }) = _$PointRuleModelImpl;

  factory _PointRuleModel.fromJson(Map<String, dynamic> json) =
      _$PointRuleModelImpl.fromJson;

  @override
  String get id;
  @override
  ActivityType get activityType;
  @override
  int get points;
  @override
  String get description;
  @override
  @TimestampConverter()
  DateTime get updatedAt;
  @override
  String get updatedByUserId;

  /// Create a copy of PointRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointRuleModelImplCopyWith<_$PointRuleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

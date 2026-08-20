// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proposal_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProposalModel _$ProposalModelFromJson(Map<String, dynamic> json) {
  return _ProposalModel.fromJson(json);
}

/// @nodoc
mixin _$ProposalModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  int get upvoteCount => throw _privateConstructorUsedError;
  List<String> get upvotedUserIds => throw _privateConstructorUsedError;
  ProposalStatus get status => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ProposalModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProposalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProposalModelCopyWith<ProposalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProposalModelCopyWith<$Res> {
  factory $ProposalModelCopyWith(
    ProposalModel value,
    $Res Function(ProposalModel) then,
  ) = _$ProposalModelCopyWithImpl<$Res, ProposalModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String category,
    String authorId,
    String authorName,
    int upvoteCount,
    List<String> upvotedUserIds,
    ProposalStatus status,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$ProposalModelCopyWithImpl<$Res, $Val extends ProposalModel>
    implements $ProposalModelCopyWith<$Res> {
  _$ProposalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProposalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? upvoteCount = null,
    Object? upvotedUserIds = null,
    Object? status = null,
    Object? createdAt = null,
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
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            authorId: null == authorId
                ? _value.authorId
                : authorId // ignore: cast_nullable_to_non_nullable
                      as String,
            authorName: null == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                      as String,
            upvoteCount: null == upvoteCount
                ? _value.upvoteCount
                : upvoteCount // ignore: cast_nullable_to_non_nullable
                      as int,
            upvotedUserIds: null == upvotedUserIds
                ? _value.upvotedUserIds
                : upvotedUserIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ProposalStatus,
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
abstract class _$$ProposalModelImplCopyWith<$Res>
    implements $ProposalModelCopyWith<$Res> {
  factory _$$ProposalModelImplCopyWith(
    _$ProposalModelImpl value,
    $Res Function(_$ProposalModelImpl) then,
  ) = __$$ProposalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String category,
    String authorId,
    String authorName,
    int upvoteCount,
    List<String> upvotedUserIds,
    ProposalStatus status,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$ProposalModelImplCopyWithImpl<$Res>
    extends _$ProposalModelCopyWithImpl<$Res, _$ProposalModelImpl>
    implements _$$ProposalModelImplCopyWith<$Res> {
  __$$ProposalModelImplCopyWithImpl(
    _$ProposalModelImpl _value,
    $Res Function(_$ProposalModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProposalModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? upvoteCount = null,
    Object? upvotedUserIds = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ProposalModelImpl(
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
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        authorId: null == authorId
            ? _value.authorId
            : authorId // ignore: cast_nullable_to_non_nullable
                  as String,
        authorName: null == authorName
            ? _value.authorName
            : authorName // ignore: cast_nullable_to_non_nullable
                  as String,
        upvoteCount: null == upvoteCount
            ? _value.upvoteCount
            : upvoteCount // ignore: cast_nullable_to_non_nullable
                  as int,
        upvotedUserIds: null == upvotedUserIds
            ? _value._upvotedUserIds
            : upvotedUserIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ProposalStatus,
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
class _$ProposalModelImpl implements _ProposalModel {
  const _$ProposalModelImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.authorId,
    required this.authorName,
    this.upvoteCount = 0,
    final List<String> upvotedUserIds = const [],
    this.status = ProposalStatus.pending,
    @TimestampConverter() required this.createdAt,
  }) : _upvotedUserIds = upvotedUserIds;

  factory _$ProposalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProposalModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String category;
  @override
  final String authorId;
  @override
  final String authorName;
  @override
  @JsonKey()
  final int upvoteCount;
  final List<String> _upvotedUserIds;
  @override
  @JsonKey()
  List<String> get upvotedUserIds {
    if (_upvotedUserIds is EqualUnmodifiableListView) return _upvotedUserIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upvotedUserIds);
  }

  @override
  @JsonKey()
  final ProposalStatus status;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'ProposalModel(id: $id, title: $title, description: $description, category: $category, authorId: $authorId, authorName: $authorName, upvoteCount: $upvoteCount, upvotedUserIds: $upvotedUserIds, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProposalModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.upvoteCount, upvoteCount) ||
                other.upvoteCount == upvoteCount) &&
            const DeepCollectionEquality().equals(
              other._upvotedUserIds,
              _upvotedUserIds,
            ) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    category,
    authorId,
    authorName,
    upvoteCount,
    const DeepCollectionEquality().hash(_upvotedUserIds),
    status,
    createdAt,
  );

  /// Create a copy of ProposalModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProposalModelImplCopyWith<_$ProposalModelImpl> get copyWith =>
      __$$ProposalModelImplCopyWithImpl<_$ProposalModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProposalModelImplToJson(this);
  }
}

abstract class _ProposalModel implements ProposalModel {
  const factory _ProposalModel({
    required final String id,
    required final String title,
    required final String description,
    required final String category,
    required final String authorId,
    required final String authorName,
    final int upvoteCount,
    final List<String> upvotedUserIds,
    final ProposalStatus status,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$ProposalModelImpl;

  factory _ProposalModel.fromJson(Map<String, dynamic> json) =
      _$ProposalModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get category;
  @override
  String get authorId;
  @override
  String get authorName;
  @override
  int get upvoteCount;
  @override
  List<String> get upvotedUserIds;
  @override
  ProposalStatus get status;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of ProposalModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProposalModelImplCopyWith<_$ProposalModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

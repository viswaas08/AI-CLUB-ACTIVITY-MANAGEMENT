// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClubModel _$ClubModelFromJson(Map<String, dynamic> json) {
  return _ClubModel.fromJson(json);
}

/// @nodoc
mixin _$ClubModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ClubCategory get category => throw _privateConstructorUsedError;
  String get departmentId => throw _privateConstructorUsedError;
  String? get facultyAdvisorId => throw _privateConstructorUsedError;
  List<String> get leadStudentIds => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get bannerUrl => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get totalMembers => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ClubModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClubModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClubModelCopyWith<ClubModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubModelCopyWith<$Res> {
  factory $ClubModelCopyWith(ClubModel value, $Res Function(ClubModel) then) =
      _$ClubModelCopyWithImpl<$Res, ClubModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String code,
    String description,
    ClubCategory category,
    String departmentId,
    String? facultyAdvisorId,
    List<String> leadStudentIds,
    String? logoUrl,
    String? bannerUrl,
    bool isActive,
    int totalMembers,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$ClubModelCopyWithImpl<$Res, $Val extends ClubModel>
    implements $ClubModelCopyWith<$Res> {
  _$ClubModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClubModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? description = null,
    Object? category = null,
    Object? departmentId = null,
    Object? facultyAdvisorId = freezed,
    Object? leadStudentIds = null,
    Object? logoUrl = freezed,
    Object? bannerUrl = freezed,
    Object? isActive = null,
    Object? totalMembers = null,
    Object? createdAt = null,
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
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as ClubCategory,
            departmentId: null == departmentId
                ? _value.departmentId
                : departmentId // ignore: cast_nullable_to_non_nullable
                      as String,
            facultyAdvisorId: freezed == facultyAdvisorId
                ? _value.facultyAdvisorId
                : facultyAdvisorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            leadStudentIds: null == leadStudentIds
                ? _value.leadStudentIds
                : leadStudentIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            logoUrl: freezed == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            bannerUrl: freezed == bannerUrl
                ? _value.bannerUrl
                : bannerUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalMembers: null == totalMembers
                ? _value.totalMembers
                : totalMembers // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$ClubModelImplCopyWith<$Res>
    implements $ClubModelCopyWith<$Res> {
  factory _$$ClubModelImplCopyWith(
    _$ClubModelImpl value,
    $Res Function(_$ClubModelImpl) then,
  ) = __$$ClubModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String code,
    String description,
    ClubCategory category,
    String departmentId,
    String? facultyAdvisorId,
    List<String> leadStudentIds,
    String? logoUrl,
    String? bannerUrl,
    bool isActive,
    int totalMembers,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$ClubModelImplCopyWithImpl<$Res>
    extends _$ClubModelCopyWithImpl<$Res, _$ClubModelImpl>
    implements _$$ClubModelImplCopyWith<$Res> {
  __$$ClubModelImplCopyWithImpl(
    _$ClubModelImpl _value,
    $Res Function(_$ClubModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClubModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = null,
    Object? description = null,
    Object? category = null,
    Object? departmentId = null,
    Object? facultyAdvisorId = freezed,
    Object? leadStudentIds = null,
    Object? logoUrl = freezed,
    Object? bannerUrl = freezed,
    Object? isActive = null,
    Object? totalMembers = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ClubModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as ClubCategory,
        departmentId: null == departmentId
            ? _value.departmentId
            : departmentId // ignore: cast_nullable_to_non_nullable
                  as String,
        facultyAdvisorId: freezed == facultyAdvisorId
            ? _value.facultyAdvisorId
            : facultyAdvisorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        leadStudentIds: null == leadStudentIds
            ? _value._leadStudentIds
            : leadStudentIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        logoUrl: freezed == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        bannerUrl: freezed == bannerUrl
            ? _value.bannerUrl
            : bannerUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalMembers: null == totalMembers
            ? _value.totalMembers
            : totalMembers // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$ClubModelImpl implements _ClubModel {
  const _$ClubModelImpl({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    this.category = ClubCategory.general,
    required this.departmentId,
    this.facultyAdvisorId,
    final List<String> leadStudentIds = const [],
    this.logoUrl,
    this.bannerUrl,
    this.isActive = true,
    this.totalMembers = 0,
    @TimestampConverter() required this.createdAt,
  }) : _leadStudentIds = leadStudentIds;

  factory _$ClubModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String code;
  @override
  final String description;
  @override
  @JsonKey()
  final ClubCategory category;
  @override
  final String departmentId;
  @override
  final String? facultyAdvisorId;
  final List<String> _leadStudentIds;
  @override
  @JsonKey()
  List<String> get leadStudentIds {
    if (_leadStudentIds is EqualUnmodifiableListView) return _leadStudentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_leadStudentIds);
  }

  @override
  final String? logoUrl;
  @override
  final String? bannerUrl;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final int totalMembers;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'ClubModel(id: $id, name: $name, code: $code, description: $description, category: $category, departmentId: $departmentId, facultyAdvisorId: $facultyAdvisorId, leadStudentIds: $leadStudentIds, logoUrl: $logoUrl, bannerUrl: $bannerUrl, isActive: $isActive, totalMembers: $totalMembers, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.facultyAdvisorId, facultyAdvisorId) ||
                other.facultyAdvisorId == facultyAdvisorId) &&
            const DeepCollectionEquality().equals(
              other._leadStudentIds,
              _leadStudentIds,
            ) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.bannerUrl, bannerUrl) ||
                other.bannerUrl == bannerUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.totalMembers, totalMembers) ||
                other.totalMembers == totalMembers) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    code,
    description,
    category,
    departmentId,
    facultyAdvisorId,
    const DeepCollectionEquality().hash(_leadStudentIds),
    logoUrl,
    bannerUrl,
    isActive,
    totalMembers,
    createdAt,
  );

  /// Create a copy of ClubModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubModelImplCopyWith<_$ClubModelImpl> get copyWith =>
      __$$ClubModelImplCopyWithImpl<_$ClubModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubModelImplToJson(this);
  }
}

abstract class _ClubModel implements ClubModel {
  const factory _ClubModel({
    required final String id,
    required final String name,
    required final String code,
    required final String description,
    final ClubCategory category,
    required final String departmentId,
    final String? facultyAdvisorId,
    final List<String> leadStudentIds,
    final String? logoUrl,
    final String? bannerUrl,
    final bool isActive,
    final int totalMembers,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$ClubModelImpl;

  factory _ClubModel.fromJson(Map<String, dynamic> json) =
      _$ClubModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get code;
  @override
  String get description;
  @override
  ClubCategory get category;
  @override
  String get departmentId;
  @override
  String? get facultyAdvisorId;
  @override
  List<String> get leadStudentIds;
  @override
  String? get logoUrl;
  @override
  String? get bannerUrl;
  @override
  bool get isActive;
  @override
  int get totalMembers;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of ClubModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClubModelImplCopyWith<_$ClubModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

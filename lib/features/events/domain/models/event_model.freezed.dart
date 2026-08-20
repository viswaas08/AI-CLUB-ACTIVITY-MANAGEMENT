// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return _EventModel.fromJson(json);
}

/// @nodoc
mixin _$EventModel {
  String get id => throw _privateConstructorUsedError;
  String get clubId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  EventCategory get category => throw _privateConstructorUsedError;
  EventMode get mode => throw _privateConstructorUsedError;
  String? get venue => throw _privateConstructorUsedError;
  String? get eventUrl => throw _privateConstructorUsedError;
  String? get bannerUrl => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get startDateTime => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get endDateTime => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get registrationDeadline => throw _privateConstructorUsedError;
  int? get maxSeats => throw _privateConstructorUsedError;
  int get registeredCount => throw _privateConstructorUsedError;
  int get basePoints => throw _privateConstructorUsedError;
  EventStatus get status => throw _privateConstructorUsedError;
  String get createdByUserId => throw _privateConstructorUsedError;
  String? get approvedByFacultyId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this EventModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventModelCopyWith<EventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventModelCopyWith<$Res> {
  factory $EventModelCopyWith(
    EventModel value,
    $Res Function(EventModel) then,
  ) = _$EventModelCopyWithImpl<$Res, EventModel>;
  @useResult
  $Res call({
    String id,
    String clubId,
    String title,
    String description,
    EventCategory category,
    EventMode mode,
    String? venue,
    String? eventUrl,
    String? bannerUrl,
    @TimestampConverter() DateTime startDateTime,
    @TimestampConverter() DateTime endDateTime,
    @TimestampConverter() DateTime registrationDeadline,
    int? maxSeats,
    int registeredCount,
    int basePoints,
    EventStatus status,
    String createdByUserId,
    String? approvedByFacultyId,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$EventModelCopyWithImpl<$Res, $Val extends EventModel>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clubId = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? mode = null,
    Object? venue = freezed,
    Object? eventUrl = freezed,
    Object? bannerUrl = freezed,
    Object? startDateTime = null,
    Object? endDateTime = null,
    Object? registrationDeadline = null,
    Object? maxSeats = freezed,
    Object? registeredCount = null,
    Object? basePoints = null,
    Object? status = null,
    Object? createdByUserId = null,
    Object? approvedByFacultyId = freezed,
    Object? createdAt = null,
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
                      as EventCategory,
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as EventMode,
            venue: freezed == venue
                ? _value.venue
                : venue // ignore: cast_nullable_to_non_nullable
                      as String?,
            eventUrl: freezed == eventUrl
                ? _value.eventUrl
                : eventUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            bannerUrl: freezed == bannerUrl
                ? _value.bannerUrl
                : bannerUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDateTime: null == startDateTime
                ? _value.startDateTime
                : startDateTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDateTime: null == endDateTime
                ? _value.endDateTime
                : endDateTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            registrationDeadline: null == registrationDeadline
                ? _value.registrationDeadline
                : registrationDeadline // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            maxSeats: freezed == maxSeats
                ? _value.maxSeats
                : maxSeats // ignore: cast_nullable_to_non_nullable
                      as int?,
            registeredCount: null == registeredCount
                ? _value.registeredCount
                : registeredCount // ignore: cast_nullable_to_non_nullable
                      as int,
            basePoints: null == basePoints
                ? _value.basePoints
                : basePoints // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as EventStatus,
            createdByUserId: null == createdByUserId
                ? _value.createdByUserId
                : createdByUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            approvedByFacultyId: freezed == approvedByFacultyId
                ? _value.approvedByFacultyId
                : approvedByFacultyId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$EventModelImplCopyWith<$Res>
    implements $EventModelCopyWith<$Res> {
  factory _$$EventModelImplCopyWith(
    _$EventModelImpl value,
    $Res Function(_$EventModelImpl) then,
  ) = __$$EventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String clubId,
    String title,
    String description,
    EventCategory category,
    EventMode mode,
    String? venue,
    String? eventUrl,
    String? bannerUrl,
    @TimestampConverter() DateTime startDateTime,
    @TimestampConverter() DateTime endDateTime,
    @TimestampConverter() DateTime registrationDeadline,
    int? maxSeats,
    int registeredCount,
    int basePoints,
    EventStatus status,
    String createdByUserId,
    String? approvedByFacultyId,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$EventModelImplCopyWithImpl<$Res>
    extends _$EventModelCopyWithImpl<$Res, _$EventModelImpl>
    implements _$$EventModelImplCopyWith<$Res> {
  __$$EventModelImplCopyWithImpl(
    _$EventModelImpl _value,
    $Res Function(_$EventModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clubId = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? mode = null,
    Object? venue = freezed,
    Object? eventUrl = freezed,
    Object? bannerUrl = freezed,
    Object? startDateTime = null,
    Object? endDateTime = null,
    Object? registrationDeadline = null,
    Object? maxSeats = freezed,
    Object? registeredCount = null,
    Object? basePoints = null,
    Object? status = null,
    Object? createdByUserId = null,
    Object? approvedByFacultyId = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$EventModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        clubId: null == clubId
            ? _value.clubId
            : clubId // ignore: cast_nullable_to_non_nullable
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
                  as EventCategory,
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as EventMode,
        venue: freezed == venue
            ? _value.venue
            : venue // ignore: cast_nullable_to_non_nullable
                  as String?,
        eventUrl: freezed == eventUrl
            ? _value.eventUrl
            : eventUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        bannerUrl: freezed == bannerUrl
            ? _value.bannerUrl
            : bannerUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDateTime: null == startDateTime
            ? _value.startDateTime
            : startDateTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDateTime: null == endDateTime
            ? _value.endDateTime
            : endDateTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        registrationDeadline: null == registrationDeadline
            ? _value.registrationDeadline
            : registrationDeadline // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        maxSeats: freezed == maxSeats
            ? _value.maxSeats
            : maxSeats // ignore: cast_nullable_to_non_nullable
                  as int?,
        registeredCount: null == registeredCount
            ? _value.registeredCount
            : registeredCount // ignore: cast_nullable_to_non_nullable
                  as int,
        basePoints: null == basePoints
            ? _value.basePoints
            : basePoints // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as EventStatus,
        createdByUserId: null == createdByUserId
            ? _value.createdByUserId
            : createdByUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        approvedByFacultyId: freezed == approvedByFacultyId
            ? _value.approvedByFacultyId
            : approvedByFacultyId // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$EventModelImpl implements _EventModel {
  const _$EventModelImpl({
    required this.id,
    required this.clubId,
    required this.title,
    required this.description,
    this.category = EventCategory.workshop,
    this.mode = EventMode.inPerson,
    this.venue,
    this.eventUrl,
    this.bannerUrl,
    @TimestampConverter() required this.startDateTime,
    @TimestampConverter() required this.endDateTime,
    @TimestampConverter() required this.registrationDeadline,
    this.maxSeats,
    this.registeredCount = 0,
    this.basePoints = 50,
    this.status = EventStatus.pendingApproval,
    required this.createdByUserId,
    this.approvedByFacultyId,
    @TimestampConverter() required this.createdAt,
  });

  factory _$EventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventModelImplFromJson(json);

  @override
  final String id;
  @override
  final String clubId;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey()
  final EventCategory category;
  @override
  @JsonKey()
  final EventMode mode;
  @override
  final String? venue;
  @override
  final String? eventUrl;
  @override
  final String? bannerUrl;
  @override
  @TimestampConverter()
  final DateTime startDateTime;
  @override
  @TimestampConverter()
  final DateTime endDateTime;
  @override
  @TimestampConverter()
  final DateTime registrationDeadline;
  @override
  final int? maxSeats;
  @override
  @JsonKey()
  final int registeredCount;
  @override
  @JsonKey()
  final int basePoints;
  @override
  @JsonKey()
  final EventStatus status;
  @override
  final String createdByUserId;
  @override
  final String? approvedByFacultyId;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'EventModel(id: $id, clubId: $clubId, title: $title, description: $description, category: $category, mode: $mode, venue: $venue, eventUrl: $eventUrl, bannerUrl: $bannerUrl, startDateTime: $startDateTime, endDateTime: $endDateTime, registrationDeadline: $registrationDeadline, maxSeats: $maxSeats, registeredCount: $registeredCount, basePoints: $basePoints, status: $status, createdByUserId: $createdByUserId, approvedByFacultyId: $approvedByFacultyId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.eventUrl, eventUrl) ||
                other.eventUrl == eventUrl) &&
            (identical(other.bannerUrl, bannerUrl) ||
                other.bannerUrl == bannerUrl) &&
            (identical(other.startDateTime, startDateTime) ||
                other.startDateTime == startDateTime) &&
            (identical(other.endDateTime, endDateTime) ||
                other.endDateTime == endDateTime) &&
            (identical(other.registrationDeadline, registrationDeadline) ||
                other.registrationDeadline == registrationDeadline) &&
            (identical(other.maxSeats, maxSeats) ||
                other.maxSeats == maxSeats) &&
            (identical(other.registeredCount, registeredCount) ||
                other.registeredCount == registeredCount) &&
            (identical(other.basePoints, basePoints) ||
                other.basePoints == basePoints) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdByUserId, createdByUserId) ||
                other.createdByUserId == createdByUserId) &&
            (identical(other.approvedByFacultyId, approvedByFacultyId) ||
                other.approvedByFacultyId == approvedByFacultyId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    clubId,
    title,
    description,
    category,
    mode,
    venue,
    eventUrl,
    bannerUrl,
    startDateTime,
    endDateTime,
    registrationDeadline,
    maxSeats,
    registeredCount,
    basePoints,
    status,
    createdByUserId,
    approvedByFacultyId,
    createdAt,
  ]);

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      __$$EventModelImplCopyWithImpl<_$EventModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventModelImplToJson(this);
  }
}

abstract class _EventModel implements EventModel {
  const factory _EventModel({
    required final String id,
    required final String clubId,
    required final String title,
    required final String description,
    final EventCategory category,
    final EventMode mode,
    final String? venue,
    final String? eventUrl,
    final String? bannerUrl,
    @TimestampConverter() required final DateTime startDateTime,
    @TimestampConverter() required final DateTime endDateTime,
    @TimestampConverter() required final DateTime registrationDeadline,
    final int? maxSeats,
    final int registeredCount,
    final int basePoints,
    final EventStatus status,
    required final String createdByUserId,
    final String? approvedByFacultyId,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$EventModelImpl;

  factory _EventModel.fromJson(Map<String, dynamic> json) =
      _$EventModelImpl.fromJson;

  @override
  String get id;
  @override
  String get clubId;
  @override
  String get title;
  @override
  String get description;
  @override
  EventCategory get category;
  @override
  EventMode get mode;
  @override
  String? get venue;
  @override
  String? get eventUrl;
  @override
  String? get bannerUrl;
  @override
  @TimestampConverter()
  DateTime get startDateTime;
  @override
  @TimestampConverter()
  DateTime get endDateTime;
  @override
  @TimestampConverter()
  DateTime get registrationDeadline;
  @override
  int? get maxSeats;
  @override
  int get registeredCount;
  @override
  int get basePoints;
  @override
  EventStatus get status;
  @override
  String get createdByUserId;
  @override
  String? get approvedByFacultyId;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of EventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

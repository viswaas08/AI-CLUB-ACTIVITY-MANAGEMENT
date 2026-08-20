// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certificate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CertificateModel _$CertificateModelFromJson(Map<String, dynamic> json) {
  return _CertificateModel.fromJson(json);
}

/// @nodoc
mixin _$CertificateModel {
  String get id => throw _privateConstructorUsedError;
  String get certificateNumber => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get studentName => throw _privateConstructorUsedError;
  String get studentRollNo => throw _privateConstructorUsedError;
  String get eventId => throw _privateConstructorUsedError;
  String get eventTitle => throw _privateConstructorUsedError;
  String get clubId => throw _privateConstructorUsedError;
  String get clubName => throw _privateConstructorUsedError;
  String get achievementTitle => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get issueDate => throw _privateConstructorUsedError;
  String get issuerUserId => throw _privateConstructorUsedError;
  String get issuerName => throw _privateConstructorUsedError;
  String get issuerRole => throw _privateConstructorUsedError;
  CertificateStatus get status => throw _privateConstructorUsedError;
  String? get revocationReason => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get revokedAt => throw _privateConstructorUsedError;
  String? get revokedByUserId => throw _privateConstructorUsedError;
  String get pdfUrl => throw _privateConstructorUsedError;
  String get verificationUrl => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this CertificateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CertificateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CertificateModelCopyWith<CertificateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertificateModelCopyWith<$Res> {
  factory $CertificateModelCopyWith(
    CertificateModel value,
    $Res Function(CertificateModel) then,
  ) = _$CertificateModelCopyWithImpl<$Res, CertificateModel>;
  @useResult
  $Res call({
    String id,
    String certificateNumber,
    String studentId,
    String studentName,
    String studentRollNo,
    String eventId,
    String eventTitle,
    String clubId,
    String clubName,
    String achievementTitle,
    @TimestampConverter() DateTime issueDate,
    String issuerUserId,
    String issuerName,
    String issuerRole,
    CertificateStatus status,
    String? revocationReason,
    @NullableTimestampConverter() DateTime? revokedAt,
    String? revokedByUserId,
    String pdfUrl,
    String verificationUrl,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$CertificateModelCopyWithImpl<$Res, $Val extends CertificateModel>
    implements $CertificateModelCopyWith<$Res> {
  _$CertificateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CertificateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? certificateNumber = null,
    Object? studentId = null,
    Object? studentName = null,
    Object? studentRollNo = null,
    Object? eventId = null,
    Object? eventTitle = null,
    Object? clubId = null,
    Object? clubName = null,
    Object? achievementTitle = null,
    Object? issueDate = null,
    Object? issuerUserId = null,
    Object? issuerName = null,
    Object? issuerRole = null,
    Object? status = null,
    Object? revocationReason = freezed,
    Object? revokedAt = freezed,
    Object? revokedByUserId = freezed,
    Object? pdfUrl = null,
    Object? verificationUrl = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            certificateNumber: null == certificateNumber
                ? _value.certificateNumber
                : certificateNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as String,
            studentName: null == studentName
                ? _value.studentName
                : studentName // ignore: cast_nullable_to_non_nullable
                      as String,
            studentRollNo: null == studentRollNo
                ? _value.studentRollNo
                : studentRollNo // ignore: cast_nullable_to_non_nullable
                      as String,
            eventId: null == eventId
                ? _value.eventId
                : eventId // ignore: cast_nullable_to_non_nullable
                      as String,
            eventTitle: null == eventTitle
                ? _value.eventTitle
                : eventTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            clubId: null == clubId
                ? _value.clubId
                : clubId // ignore: cast_nullable_to_non_nullable
                      as String,
            clubName: null == clubName
                ? _value.clubName
                : clubName // ignore: cast_nullable_to_non_nullable
                      as String,
            achievementTitle: null == achievementTitle
                ? _value.achievementTitle
                : achievementTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            issueDate: null == issueDate
                ? _value.issueDate
                : issueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            issuerUserId: null == issuerUserId
                ? _value.issuerUserId
                : issuerUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            issuerName: null == issuerName
                ? _value.issuerName
                : issuerName // ignore: cast_nullable_to_non_nullable
                      as String,
            issuerRole: null == issuerRole
                ? _value.issuerRole
                : issuerRole // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CertificateStatus,
            revocationReason: freezed == revocationReason
                ? _value.revocationReason
                : revocationReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            revokedAt: freezed == revokedAt
                ? _value.revokedAt
                : revokedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            revokedByUserId: freezed == revokedByUserId
                ? _value.revokedByUserId
                : revokedByUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
            pdfUrl: null == pdfUrl
                ? _value.pdfUrl
                : pdfUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            verificationUrl: null == verificationUrl
                ? _value.verificationUrl
                : verificationUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CertificateModelImplCopyWith<$Res>
    implements $CertificateModelCopyWith<$Res> {
  factory _$$CertificateModelImplCopyWith(
    _$CertificateModelImpl value,
    $Res Function(_$CertificateModelImpl) then,
  ) = __$$CertificateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String certificateNumber,
    String studentId,
    String studentName,
    String studentRollNo,
    String eventId,
    String eventTitle,
    String clubId,
    String clubName,
    String achievementTitle,
    @TimestampConverter() DateTime issueDate,
    String issuerUserId,
    String issuerName,
    String issuerRole,
    CertificateStatus status,
    String? revocationReason,
    @NullableTimestampConverter() DateTime? revokedAt,
    String? revokedByUserId,
    String pdfUrl,
    String verificationUrl,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$CertificateModelImplCopyWithImpl<$Res>
    extends _$CertificateModelCopyWithImpl<$Res, _$CertificateModelImpl>
    implements _$$CertificateModelImplCopyWith<$Res> {
  __$$CertificateModelImplCopyWithImpl(
    _$CertificateModelImpl _value,
    $Res Function(_$CertificateModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CertificateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? certificateNumber = null,
    Object? studentId = null,
    Object? studentName = null,
    Object? studentRollNo = null,
    Object? eventId = null,
    Object? eventTitle = null,
    Object? clubId = null,
    Object? clubName = null,
    Object? achievementTitle = null,
    Object? issueDate = null,
    Object? issuerUserId = null,
    Object? issuerName = null,
    Object? issuerRole = null,
    Object? status = null,
    Object? revocationReason = freezed,
    Object? revokedAt = freezed,
    Object? revokedByUserId = freezed,
    Object? pdfUrl = null,
    Object? verificationUrl = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _$CertificateModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        certificateNumber: null == certificateNumber
            ? _value.certificateNumber
            : certificateNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as String,
        studentName: null == studentName
            ? _value.studentName
            : studentName // ignore: cast_nullable_to_non_nullable
                  as String,
        studentRollNo: null == studentRollNo
            ? _value.studentRollNo
            : studentRollNo // ignore: cast_nullable_to_non_nullable
                  as String,
        eventId: null == eventId
            ? _value.eventId
            : eventId // ignore: cast_nullable_to_non_nullable
                  as String,
        eventTitle: null == eventTitle
            ? _value.eventTitle
            : eventTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        clubId: null == clubId
            ? _value.clubId
            : clubId // ignore: cast_nullable_to_non_nullable
                  as String,
        clubName: null == clubName
            ? _value.clubName
            : clubName // ignore: cast_nullable_to_non_nullable
                  as String,
        achievementTitle: null == achievementTitle
            ? _value.achievementTitle
            : achievementTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        issueDate: null == issueDate
            ? _value.issueDate
            : issueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        issuerUserId: null == issuerUserId
            ? _value.issuerUserId
            : issuerUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        issuerName: null == issuerName
            ? _value.issuerName
            : issuerName // ignore: cast_nullable_to_non_nullable
                  as String,
        issuerRole: null == issuerRole
            ? _value.issuerRole
            : issuerRole // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CertificateStatus,
        revocationReason: freezed == revocationReason
            ? _value.revocationReason
            : revocationReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        revokedAt: freezed == revokedAt
            ? _value.revokedAt
            : revokedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        revokedByUserId: freezed == revokedByUserId
            ? _value.revokedByUserId
            : revokedByUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
        pdfUrl: null == pdfUrl
            ? _value.pdfUrl
            : pdfUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        verificationUrl: null == verificationUrl
            ? _value.verificationUrl
            : verificationUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CertificateModelImpl implements _CertificateModel {
  const _$CertificateModelImpl({
    required this.id,
    required this.certificateNumber,
    required this.studentId,
    required this.studentName,
    required this.studentRollNo,
    required this.eventId,
    required this.eventTitle,
    required this.clubId,
    required this.clubName,
    required this.achievementTitle,
    @TimestampConverter() required this.issueDate,
    required this.issuerUserId,
    required this.issuerName,
    required this.issuerRole,
    this.status = CertificateStatus.valid,
    this.revocationReason,
    @NullableTimestampConverter() this.revokedAt,
    this.revokedByUserId,
    required this.pdfUrl,
    required this.verificationUrl,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata;

  factory _$CertificateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CertificateModelImplFromJson(json);

  @override
  final String id;
  @override
  final String certificateNumber;
  @override
  final String studentId;
  @override
  final String studentName;
  @override
  final String studentRollNo;
  @override
  final String eventId;
  @override
  final String eventTitle;
  @override
  final String clubId;
  @override
  final String clubName;
  @override
  final String achievementTitle;
  @override
  @TimestampConverter()
  final DateTime issueDate;
  @override
  final String issuerUserId;
  @override
  final String issuerName;
  @override
  final String issuerRole;
  @override
  @JsonKey()
  final CertificateStatus status;
  @override
  final String? revocationReason;
  @override
  @NullableTimestampConverter()
  final DateTime? revokedAt;
  @override
  final String? revokedByUserId;
  @override
  final String pdfUrl;
  @override
  final String verificationUrl;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'CertificateModel(id: $id, certificateNumber: $certificateNumber, studentId: $studentId, studentName: $studentName, studentRollNo: $studentRollNo, eventId: $eventId, eventTitle: $eventTitle, clubId: $clubId, clubName: $clubName, achievementTitle: $achievementTitle, issueDate: $issueDate, issuerUserId: $issuerUserId, issuerName: $issuerName, issuerRole: $issuerRole, status: $status, revocationReason: $revocationReason, revokedAt: $revokedAt, revokedByUserId: $revokedByUserId, pdfUrl: $pdfUrl, verificationUrl: $verificationUrl, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertificateModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.certificateNumber, certificateNumber) ||
                other.certificateNumber == certificateNumber) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.studentRollNo, studentRollNo) ||
                other.studentRollNo == studentRollNo) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.eventTitle, eventTitle) ||
                other.eventTitle == eventTitle) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.clubName, clubName) ||
                other.clubName == clubName) &&
            (identical(other.achievementTitle, achievementTitle) ||
                other.achievementTitle == achievementTitle) &&
            (identical(other.issueDate, issueDate) ||
                other.issueDate == issueDate) &&
            (identical(other.issuerUserId, issuerUserId) ||
                other.issuerUserId == issuerUserId) &&
            (identical(other.issuerName, issuerName) ||
                other.issuerName == issuerName) &&
            (identical(other.issuerRole, issuerRole) ||
                other.issuerRole == issuerRole) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.revocationReason, revocationReason) ||
                other.revocationReason == revocationReason) &&
            (identical(other.revokedAt, revokedAt) ||
                other.revokedAt == revokedAt) &&
            (identical(other.revokedByUserId, revokedByUserId) ||
                other.revokedByUserId == revokedByUserId) &&
            (identical(other.pdfUrl, pdfUrl) || other.pdfUrl == pdfUrl) &&
            (identical(other.verificationUrl, verificationUrl) ||
                other.verificationUrl == verificationUrl) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    certificateNumber,
    studentId,
    studentName,
    studentRollNo,
    eventId,
    eventTitle,
    clubId,
    clubName,
    achievementTitle,
    issueDate,
    issuerUserId,
    issuerName,
    issuerRole,
    status,
    revocationReason,
    revokedAt,
    revokedByUserId,
    pdfUrl,
    verificationUrl,
    const DeepCollectionEquality().hash(_metadata),
  ]);

  /// Create a copy of CertificateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CertificateModelImplCopyWith<_$CertificateModelImpl> get copyWith =>
      __$$CertificateModelImplCopyWithImpl<_$CertificateModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CertificateModelImplToJson(this);
  }
}

abstract class _CertificateModel implements CertificateModel {
  const factory _CertificateModel({
    required final String id,
    required final String certificateNumber,
    required final String studentId,
    required final String studentName,
    required final String studentRollNo,
    required final String eventId,
    required final String eventTitle,
    required final String clubId,
    required final String clubName,
    required final String achievementTitle,
    @TimestampConverter() required final DateTime issueDate,
    required final String issuerUserId,
    required final String issuerName,
    required final String issuerRole,
    final CertificateStatus status,
    final String? revocationReason,
    @NullableTimestampConverter() final DateTime? revokedAt,
    final String? revokedByUserId,
    required final String pdfUrl,
    required final String verificationUrl,
    final Map<String, dynamic>? metadata,
  }) = _$CertificateModelImpl;

  factory _CertificateModel.fromJson(Map<String, dynamic> json) =
      _$CertificateModelImpl.fromJson;

  @override
  String get id;
  @override
  String get certificateNumber;
  @override
  String get studentId;
  @override
  String get studentName;
  @override
  String get studentRollNo;
  @override
  String get eventId;
  @override
  String get eventTitle;
  @override
  String get clubId;
  @override
  String get clubName;
  @override
  String get achievementTitle;
  @override
  @TimestampConverter()
  DateTime get issueDate;
  @override
  String get issuerUserId;
  @override
  String get issuerName;
  @override
  String get issuerRole;
  @override
  CertificateStatus get status;
  @override
  String? get revocationReason;
  @override
  @NullableTimestampConverter()
  DateTime? get revokedAt;
  @override
  String? get revokedByUserId;
  @override
  String get pdfUrl;
  @override
  String get verificationUrl;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of CertificateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CertificateModelImplCopyWith<_$CertificateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

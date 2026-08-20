// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CertificateModelImpl _$$CertificateModelImplFromJson(
  Map<String, dynamic> json,
) => _$CertificateModelImpl(
  id: json['id'] as String,
  certificateNumber: json['certificateNumber'] as String,
  studentId: json['studentId'] as String,
  studentName: json['studentName'] as String,
  studentRollNo: json['studentRollNo'] as String,
  eventId: json['eventId'] as String,
  eventTitle: json['eventTitle'] as String,
  clubId: json['clubId'] as String,
  clubName: json['clubName'] as String,
  achievementTitle: json['achievementTitle'] as String,
  issueDate: const TimestampConverter().fromJson(
    json['issueDate'] as Timestamp,
  ),
  issuerUserId: json['issuerUserId'] as String,
  issuerName: json['issuerName'] as String,
  issuerRole: json['issuerRole'] as String,
  status:
      $enumDecodeNullable(_$CertificateStatusEnumMap, json['status']) ??
      CertificateStatus.valid,
  revocationReason: json['revocationReason'] as String?,
  revokedAt: const NullableTimestampConverter().fromJson(
    json['revokedAt'] as Timestamp?,
  ),
  revokedByUserId: json['revokedByUserId'] as String?,
  pdfUrl: json['pdfUrl'] as String,
  verificationUrl: json['verificationUrl'] as String,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$CertificateModelImplToJson(
  _$CertificateModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'certificateNumber': instance.certificateNumber,
  'studentId': instance.studentId,
  'studentName': instance.studentName,
  'studentRollNo': instance.studentRollNo,
  'eventId': instance.eventId,
  'eventTitle': instance.eventTitle,
  'clubId': instance.clubId,
  'clubName': instance.clubName,
  'achievementTitle': instance.achievementTitle,
  'issueDate': const TimestampConverter().toJson(instance.issueDate),
  'issuerUserId': instance.issuerUserId,
  'issuerName': instance.issuerName,
  'issuerRole': instance.issuerRole,
  'status': _$CertificateStatusEnumMap[instance.status]!,
  'revocationReason': instance.revocationReason,
  'revokedAt': const NullableTimestampConverter().toJson(instance.revokedAt),
  'revokedByUserId': instance.revokedByUserId,
  'pdfUrl': instance.pdfUrl,
  'verificationUrl': instance.verificationUrl,
  'metadata': instance.metadata,
};

const _$CertificateStatusEnumMap = {
  CertificateStatus.valid: 'VALID',
  CertificateStatus.revoked: 'REVOKED',
};

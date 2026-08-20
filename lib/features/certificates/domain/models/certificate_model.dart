import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'certificate_model.freezed.dart';
part 'certificate_model.g.dart';

enum CertificateStatus {
  @JsonValue('VALID')
  valid,
  @JsonValue('REVOKED')
  revoked,
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

class NullableTimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const NullableTimestampConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) => timestamp?.toDate();

  @override
  Timestamp? toJson(DateTime? date) => date == null ? null : Timestamp.fromDate(date);
}

@freezed
class CertificateModel with _$CertificateModel {
  const factory CertificateModel({
    required String id,
    required String certificateNumber,
    required String studentId,
    required String studentName,
    required String studentRollNo,
    required String eventId,
    required String eventTitle,
    required String clubId,
    required String clubName,
    required String achievementTitle,
    @TimestampConverter() required DateTime issueDate,
    required String issuerUserId,
    required String issuerName,
    required String issuerRole,
    @Default(CertificateStatus.valid) CertificateStatus status,
    String? revocationReason,
    @NullableTimestampConverter() DateTime? revokedAt,
    String? revokedByUserId,
    required String pdfUrl,
    required String verificationUrl,
    Map<String, dynamic>? metadata,
  }) = _CertificateModel;

  factory CertificateModel.fromJson(Map<String, dynamic> json) =>
      _$CertificateModelFromJson(json);
}

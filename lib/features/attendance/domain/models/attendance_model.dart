import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

enum AttendanceStatus {
  @JsonValue('verified')
  verified,
  @JsonValue('flagged')
  flagged,
}

@freezed
class AttendanceModel with _$AttendanceModel {
  const factory AttendanceModel({
    required String id,
    required String sessionId,
    required String eventId,
    required String userId,
    required String clubId,
    @TimestampConverter() required DateTime scannedAt,
    String? verifiedByUserId,
    @Default(AttendanceStatus.verified) AttendanceStatus status,
  }) = _AttendanceModel;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);
}

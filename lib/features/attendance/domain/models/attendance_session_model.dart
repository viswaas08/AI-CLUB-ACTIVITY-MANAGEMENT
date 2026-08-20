import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';

part 'attendance_session_model.freezed.dart';
part 'attendance_session_model.g.dart';

@freezed
class AttendanceSessionModel with _$AttendanceSessionModel {
  const factory AttendanceSessionModel({
    required String id,
    required String eventId,
    required String clubId,
    required String sessionToken,
    @Default(true) bool isActive,
    @TimestampConverter() required DateTime expiresAt,
    required String createdByUserId,
    @TimestampConverter() required DateTime createdAt,
  }) = _AttendanceSessionModel;

  factory AttendanceSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceSessionModelFromJson(json);
}

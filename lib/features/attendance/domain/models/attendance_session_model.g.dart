// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceSessionModelImpl _$$AttendanceSessionModelImplFromJson(
  Map<String, dynamic> json,
) => _$AttendanceSessionModelImpl(
  id: json['id'] as String,
  eventId: json['eventId'] as String,
  clubId: json['clubId'] as String,
  sessionToken: json['sessionToken'] as String,
  isActive: json['isActive'] as bool? ?? true,
  expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
  createdByUserId: json['createdByUserId'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$AttendanceSessionModelImplToJson(
  _$AttendanceSessionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'eventId': instance.eventId,
  'clubId': instance.clubId,
  'sessionToken': instance.sessionToken,
  'isActive': instance.isActive,
  'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
  'createdByUserId': instance.createdByUserId,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};

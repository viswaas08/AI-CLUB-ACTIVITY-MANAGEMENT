// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceModelImpl _$$AttendanceModelImplFromJson(
  Map<String, dynamic> json,
) => _$AttendanceModelImpl(
  id: json['id'] as String,
  sessionId: json['sessionId'] as String,
  eventId: json['eventId'] as String,
  userId: json['userId'] as String,
  clubId: json['clubId'] as String,
  scannedAt: const TimestampConverter().fromJson(json['scannedAt']),
  verifiedByUserId: json['verifiedByUserId'] as String?,
  status:
      $enumDecodeNullable(_$AttendanceStatusEnumMap, json['status']) ??
      AttendanceStatus.verified,
);

Map<String, dynamic> _$$AttendanceModelImplToJson(
  _$AttendanceModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sessionId': instance.sessionId,
  'eventId': instance.eventId,
  'userId': instance.userId,
  'clubId': instance.clubId,
  'scannedAt': const TimestampConverter().toJson(instance.scannedAt),
  'verifiedByUserId': instance.verifiedByUserId,
  'status': _$AttendanceStatusEnumMap[instance.status]!,
};

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.verified: 'verified',
  AttendanceStatus.flagged: 'flagged',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationModelImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  type:
      $enumDecodeNullable(_$NotificationTypeEnumMap, json['type']) ??
      NotificationType.announcement,
  actionRoute: json['actionRoute'] as String?,
  isRead: json['isRead'] as bool? ?? false,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$NotificationModelImplToJson(
  _$NotificationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'body': instance.body,
  'type': _$NotificationTypeEnumMap[instance.type]!,
  'actionRoute': instance.actionRoute,
  'isRead': instance.isRead,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};

const _$NotificationTypeEnumMap = {
  NotificationType.eventReminder: 'eventReminder',
  NotificationType.registrationSuccess: 'registrationSuccess',
  NotificationType.certificateIssued: 'certificateIssued',
  NotificationType.pointsEarned: 'pointsEarned',
  NotificationType.announcement: 'announcement',
};

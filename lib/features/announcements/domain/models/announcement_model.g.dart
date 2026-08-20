// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnnouncementModelImpl _$$AnnouncementModelImplFromJson(
  Map<String, dynamic> json,
) => _$AnnouncementModelImpl(
  id: json['id'] as String,
  clubId: json['clubId'] as String?,
  departmentId: json['departmentId'] as String?,
  title: json['title'] as String,
  content: json['content'] as String,
  priority:
      $enumDecodeNullable(_$AnnouncementPriorityEnumMap, json['priority']) ??
      AnnouncementPriority.normal,
  authorId: json['authorId'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$$AnnouncementModelImplToJson(
  _$AnnouncementModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'clubId': instance.clubId,
  'departmentId': instance.departmentId,
  'title': instance.title,
  'content': instance.content,
  'priority': _$AnnouncementPriorityEnumMap[instance.priority]!,
  'authorId': instance.authorId,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};

const _$AnnouncementPriorityEnumMap = {
  AnnouncementPriority.normal: 'normal',
  AnnouncementPriority.high: 'high',
  AnnouncementPriority.urgent: 'urgent',
};

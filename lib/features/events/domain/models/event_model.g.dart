// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventModelImpl _$$EventModelImplFromJson(Map<String, dynamic> json) =>
    _$EventModelImpl(
      id: json['id'] as String,
      clubId: json['clubId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category:
          $enumDecodeNullable(_$EventCategoryEnumMap, json['category']) ??
          EventCategory.workshop,
      mode:
          $enumDecodeNullable(_$EventModeEnumMap, json['mode']) ??
          EventMode.inPerson,
      venue: json['venue'] as String?,
      eventUrl: json['eventUrl'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      startDateTime: const TimestampConverter().fromJson(json['startDateTime']),
      endDateTime: const TimestampConverter().fromJson(json['endDateTime']),
      registrationDeadline: const TimestampConverter().fromJson(
        json['registrationDeadline'],
      ),
      maxSeats: (json['maxSeats'] as num?)?.toInt(),
      registeredCount: (json['registeredCount'] as num?)?.toInt() ?? 0,
      basePoints: (json['basePoints'] as num?)?.toInt() ?? 50,
      status:
          $enumDecodeNullable(_$EventStatusEnumMap, json['status']) ??
          EventStatus.pendingApproval,
      createdByUserId: json['createdByUserId'] as String,
      approvedByFacultyId: json['approvedByFacultyId'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$EventModelImplToJson(
  _$EventModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'clubId': instance.clubId,
  'title': instance.title,
  'description': instance.description,
  'category': _$EventCategoryEnumMap[instance.category]!,
  'mode': _$EventModeEnumMap[instance.mode]!,
  'venue': instance.venue,
  'eventUrl': instance.eventUrl,
  'bannerUrl': instance.bannerUrl,
  'startDateTime': const TimestampConverter().toJson(instance.startDateTime),
  'endDateTime': const TimestampConverter().toJson(instance.endDateTime),
  'registrationDeadline': const TimestampConverter().toJson(
    instance.registrationDeadline,
  ),
  'maxSeats': instance.maxSeats,
  'registeredCount': instance.registeredCount,
  'basePoints': instance.basePoints,
  'status': _$EventStatusEnumMap[instance.status]!,
  'createdByUserId': instance.createdByUserId,
  'approvedByFacultyId': instance.approvedByFacultyId,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};

const _$EventCategoryEnumMap = {
  EventCategory.workshop: 'workshop',
  EventCategory.hackathon: 'hackathon',
  EventCategory.competition: 'competition',
  EventCategory.guestLecture: 'guestLecture',
  EventCategory.meetup: 'meetup',
};

const _$EventModeEnumMap = {
  EventMode.inPerson: 'inPerson',
  EventMode.virtual: 'virtual',
  EventMode.hybrid: 'hybrid',
};

const _$EventStatusEnumMap = {
  EventStatus.draft: 'draft',
  EventStatus.pendingApproval: 'pendingApproval',
  EventStatus.approved: 'approved',
  EventStatus.rejected: 'rejected',
  EventStatus.ongoing: 'ongoing',
  EventStatus.completed: 'completed',
  EventStatus.cancelled: 'cancelled',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventRegistrationModelImpl _$$EventRegistrationModelImplFromJson(
  Map<String, dynamic> json,
) => _$EventRegistrationModelImpl(
  id: json['id'] as String,
  eventId: json['eventId'] as String,
  userId: json['userId'] as String,
  clubId: json['clubId'] as String,
  registeredAt: const TimestampConverter().fromJson(json['registeredAt']),
  status:
      $enumDecodeNullable(_$RegistrationStatusEnumMap, json['status']) ??
      RegistrationStatus.registered,
  cancellationReason: json['cancellationReason'] as String?,
);

Map<String, dynamic> _$$EventRegistrationModelImplToJson(
  _$EventRegistrationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'eventId': instance.eventId,
  'userId': instance.userId,
  'clubId': instance.clubId,
  'registeredAt': const TimestampConverter().toJson(instance.registeredAt),
  'status': _$RegistrationStatusEnumMap[instance.status]!,
  'cancellationReason': instance.cancellationReason,
};

const _$RegistrationStatusEnumMap = {
  RegistrationStatus.registered: 'registered',
  RegistrationStatus.waitlisted: 'waitlisted',
  RegistrationStatus.cancelled: 'cancelled',
  RegistrationStatus.attended: 'attended',
};

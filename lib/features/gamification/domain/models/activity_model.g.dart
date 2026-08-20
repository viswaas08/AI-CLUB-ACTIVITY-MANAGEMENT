// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityModelImpl _$$ActivityModelImplFromJson(Map<String, dynamic> json) =>
    _$ActivityModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type:
          $enumDecodeNullable(_$ActivityTypeEnumMap, json['type']) ??
          ActivityType.eventAttended,
      title: json['title'] as String,
      description: json['description'] as String,
      referenceId: json['referenceId'] as String?,
      pointsAwarded: (json['pointsAwarded'] as num?)?.toInt() ?? 0,
      timestamp: const TimestampConverter().fromJson(json['timestamp']),
    );

Map<String, dynamic> _$$ActivityModelImplToJson(_$ActivityModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'referenceId': instance.referenceId,
      'pointsAwarded': instance.pointsAwarded,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };

const _$ActivityTypeEnumMap = {
  ActivityType.eventAttended: 'eventAttended',
  ActivityType.competitionWon: 'competitionWon',
  ActivityType.workshopCompleted: 'workshopCompleted',
  ActivityType.clubJoined: 'clubJoined',
  ActivityType.leadershipRole: 'leadershipRole',
};

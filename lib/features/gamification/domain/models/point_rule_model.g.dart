// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_rule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointRuleModelImpl _$$PointRuleModelImplFromJson(Map<String, dynamic> json) =>
    _$PointRuleModelImpl(
      id: json['id'] as String,
      activityType: $enumDecode(_$ActivityTypeEnumMap, json['activityType']),
      points: (json['points'] as num).toInt(),
      description: json['description'] as String,
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      updatedByUserId: json['updatedByUserId'] as String,
    );

Map<String, dynamic> _$$PointRuleModelImplToJson(
  _$PointRuleModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'activityType': _$ActivityTypeEnumMap[instance.activityType]!,
  'points': instance.points,
  'description': instance.description,
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'updatedByUserId': instance.updatedByUserId,
};

const _$ActivityTypeEnumMap = {
  ActivityType.eventAttended: 'eventAttended',
  ActivityType.competitionWon: 'competitionWon',
  ActivityType.workshopCompleted: 'workshopCompleted',
  ActivityType.clubJoined: 'clubJoined',
  ActivityType.leadershipRole: 'leadershipRole',
};

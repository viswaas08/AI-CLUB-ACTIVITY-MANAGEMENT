// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecommendationModelImpl _$$RecommendationModelImplFromJson(
  Map<String, dynamic> json,
) => _$RecommendationModelImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  eventId: json['eventId'] as String,
  matchScore: (json['matchScore'] as num).toDouble(),
  matchReasons:
      (json['matchReasons'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  generatedAt: const TimestampConverter().fromJson(json['generatedAt']),
);

Map<String, dynamic> _$$RecommendationModelImplToJson(
  _$RecommendationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'eventId': instance.eventId,
  'matchScore': instance.matchScore,
  'matchReasons': instance.matchReasons,
  'generatedAt': const TimestampConverter().toJson(instance.generatedAt),
};

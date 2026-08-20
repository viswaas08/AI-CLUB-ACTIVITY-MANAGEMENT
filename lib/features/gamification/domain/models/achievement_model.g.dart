// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AchievementModelImpl _$$AchievementModelImplFromJson(
  Map<String, dynamic> json,
) => _$AchievementModelImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  badgeId: json['badgeId'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  iconUrl: json['iconUrl'] as String?,
  unlockedAt: const TimestampConverter().fromJson(json['unlockedAt']),
);

Map<String, dynamic> _$$AchievementModelImplToJson(
  _$AchievementModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'badgeId': instance.badgeId,
  'title': instance.title,
  'description': instance.description,
  'iconUrl': instance.iconUrl,
  'unlockedAt': const TimestampConverter().toJson(instance.unlockedAt),
};

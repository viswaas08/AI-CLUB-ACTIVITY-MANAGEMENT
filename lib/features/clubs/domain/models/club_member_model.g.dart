// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubMemberModelImpl _$$ClubMemberModelImplFromJson(
  Map<String, dynamic> json,
) => _$ClubMemberModelImpl(
  id: json['id'] as String,
  clubId: json['clubId'] as String,
  userId: json['userId'] as String,
  role:
      $enumDecodeNullable(_$MemberRoleEnumMap, json['role']) ??
      MemberRole.member,
  joinedAt: const TimestampConverter().fromJson(json['joinedAt']),
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$$ClubMemberModelImplToJson(
  _$ClubMemberModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'clubId': instance.clubId,
  'userId': instance.userId,
  'role': _$MemberRoleEnumMap[instance.role]!,
  'joinedAt': const TimestampConverter().toJson(instance.joinedAt),
  'isActive': instance.isActive,
};

const _$MemberRoleEnumMap = {
  MemberRole.member: 'member',
  MemberRole.lead: 'lead',
  MemberRole.coordinator: 'coordinator',
};

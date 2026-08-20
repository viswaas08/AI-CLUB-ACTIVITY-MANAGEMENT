// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProposalModelImpl _$$ProposalModelImplFromJson(Map<String, dynamic> json) =>
    _$ProposalModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      upvoteCount: (json['upvoteCount'] as num?)?.toInt() ?? 0,
      upvotedUserIds:
          (json['upvotedUserIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      status:
          $enumDecodeNullable(_$ProposalStatusEnumMap, json['status']) ??
          ProposalStatus.pending,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$ProposalModelImplToJson(_$ProposalModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'upvoteCount': instance.upvoteCount,
      'upvotedUserIds': instance.upvotedUserIds,
      'status': _$ProposalStatusEnumMap[instance.status]!,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

const _$ProposalStatusEnumMap = {
  ProposalStatus.pending: 'pending',
  ProposalStatus.escalated: 'escalated',
  ProposalStatus.approved: 'approved',
  ProposalStatus.rejected: 'rejected',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubModelImpl _$$ClubModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      description: json['description'] as String,
      category:
          $enumDecodeNullable(_$ClubCategoryEnumMap, json['category']) ??
          ClubCategory.general,
      departmentId: json['departmentId'] as String,
      facultyAdvisorId: json['facultyAdvisorId'] as String?,
      leadStudentIds:
          (json['leadStudentIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      logoUrl: json['logoUrl'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      totalMembers: (json['totalMembers'] as num?)?.toInt() ?? 0,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$ClubModelImplToJson(_$ClubModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'category': _$ClubCategoryEnumMap[instance.category]!,
      'departmentId': instance.departmentId,
      'facultyAdvisorId': instance.facultyAdvisorId,
      'leadStudentIds': instance.leadStudentIds,
      'logoUrl': instance.logoUrl,
      'bannerUrl': instance.bannerUrl,
      'isActive': instance.isActive,
      'totalMembers': instance.totalMembers,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

const _$ClubCategoryEnumMap = {
  ClubCategory.ai: 'ai',
  ClubCategory.technical: 'technical',
  ClubCategory.robotics: 'robotics',
  ClubCategory.coding: 'coding',
  ClubCategory.general: 'general',
};

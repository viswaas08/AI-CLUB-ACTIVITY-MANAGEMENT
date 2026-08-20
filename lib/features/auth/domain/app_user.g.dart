// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      role:
          $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ??
          UserRole.student,
      departmentId: json['departmentId'] as String?,
      studentId: json['studentId'] as String?,
      facultyEmployeeId: json['facultyEmployeeId'] as String?,
      joinedClubIds:
          (json['joinedClubIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      administeredClubIds:
          (json['administeredClubIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      totalPoints: (json['totalPoints'] as num?)?.toInt() ?? 0,
      isProfileComplete: json['isProfileComplete'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'role': _$UserRoleEnumMap[instance.role]!,
      'departmentId': instance.departmentId,
      'studentId': instance.studentId,
      'facultyEmployeeId': instance.facultyEmployeeId,
      'joinedClubIds': instance.joinedClubIds,
      'administeredClubIds': instance.administeredClubIds,
      'totalPoints': instance.totalPoints,
      'isProfileComplete': instance.isProfileComplete,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.student: 'student',
  UserRole.clubAdmin: 'clubAdmin',
  UserRole.faculty: 'faculty',
  UserRole.superAdmin: 'superAdmin',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserModelImpl(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String?,
  photoUrl: json['photoUrl'] as String?,
  role:
      $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ?? UserRole.student,
  departmentId: json['departmentId'] as String?,
  studentRollNo: json['studentRollNo'] as String?,
  facultyId: json['facultyId'] as String?,
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
  streakDays: (json['streakDays'] as num?)?.toInt() ?? 0,
  interests:
      (json['interests'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isProfileComplete: json['isProfileComplete'] as bool? ?? false,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'role': _$UserRoleEnumMap[instance.role]!,
      'departmentId': instance.departmentId,
      'studentRollNo': instance.studentRollNo,
      'facultyId': instance.facultyId,
      'joinedClubIds': instance.joinedClubIds,
      'administeredClubIds': instance.administeredClubIds,
      'totalPoints': instance.totalPoints,
      'streakDays': instance.streakDays,
      'interests': instance.interests,
      'isProfileComplete': instance.isProfileComplete,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

const _$UserRoleEnumMap = {
  UserRole.student: 'student',
  UserRole.clubAdmin: 'clubAdmin',
  UserRole.faculty: 'faculty',
  UserRole.superAdmin: 'superAdmin',
};

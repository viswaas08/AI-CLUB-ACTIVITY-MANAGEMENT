import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';
import '../../../auth/domain/user_role.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
    @Default(UserRole.student) UserRole role,
    String? departmentId,
    String? studentRollNo,
    String? facultyId,
    @Default([]) List<String> joinedClubIds,
    @Default([]) List<String> administeredClubIds,
    @Default(0) int totalPoints,
    @Default(0) int streakDays,
    @Default([]) List<String> interests,
    @Default(false) bool isProfileComplete,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

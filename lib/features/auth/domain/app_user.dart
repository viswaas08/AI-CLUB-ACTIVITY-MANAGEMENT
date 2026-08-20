import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_role.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
    @Default(UserRole.student) UserRole role,
    String? departmentId,
    String? studentId,
    String? facultyEmployeeId,
    @Default([]) List<String> joinedClubIds,
    @Default([]) List<String> administeredClubIds,
    @Default(0) int totalPoints,
    @Default(false) bool isProfileComplete,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}

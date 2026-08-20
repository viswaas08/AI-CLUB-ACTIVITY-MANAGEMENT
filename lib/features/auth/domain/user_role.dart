import 'package:freezed_annotation/freezed_annotation.dart';

enum UserRole {
  @JsonValue('student')
  student,

  @JsonValue('clubAdmin')
  clubAdmin,

  @JsonValue('faculty')
  faculty,

  @JsonValue('superAdmin')
  superAdmin;

  String get label {
    switch (this) {
      case UserRole.student:
        return 'Student';
      case UserRole.clubAdmin:
        return 'Club Administrator';
      case UserRole.faculty:
        return 'Faculty Advisor';
      case UserRole.superAdmin:
        return 'System Super Admin';
    }
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';

part 'club_model.freezed.dart';
part 'club_model.g.dart';

enum ClubCategory {
  @JsonValue('ai')
  ai,
  @JsonValue('technical')
  technical,
  @JsonValue('robotics')
  robotics,
  @JsonValue('coding')
  coding,
  @JsonValue('general')
  general;

  String get label {
    switch (this) {
      case ClubCategory.ai:
        return 'Artificial Intelligence';
      case ClubCategory.technical:
        return 'Technical Special Interest';
      case ClubCategory.robotics:
        return 'Robotics & Automation';
      case ClubCategory.coding:
        return 'Competitive Coding';
      case ClubCategory.general:
        return 'General Student Society';
    }
  }
}

@freezed
class ClubModel with _$ClubModel {
  const factory ClubModel({
    required String id,
    required String name,
    required String code,
    required String description,
    @Default(ClubCategory.general) ClubCategory category,
    required String departmentId,
    String? facultyAdvisorId,
    @Default([]) List<String> leadStudentIds,
    String? logoUrl,
    String? bannerUrl,
    @Default(true) bool isActive,
    @Default(0) int totalMembers,
    @TimestampConverter() required DateTime createdAt,
  }) = _ClubModel;

  factory ClubModel.fromJson(Map<String, dynamic> json) => _$ClubModelFromJson(json);
}

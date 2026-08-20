import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';

part 'achievement_model.freezed.dart';
part 'achievement_model.g.dart';

@freezed
class AchievementModel with _$AchievementModel {
  const factory AchievementModel({
    required String id,
    required String userId,
    required String badgeId,
    required String title,
    required String description,
    String? iconUrl,
    @TimestampConverter() required DateTime unlockedAt,
  }) = _AchievementModel;

  factory AchievementModel.fromJson(Map<String, dynamic> json) =>
      _$AchievementModelFromJson(json);
}

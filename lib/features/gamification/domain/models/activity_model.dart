import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';

part 'activity_model.freezed.dart';
part 'activity_model.g.dart';

enum ActivityType {
  @JsonValue('eventAttended')
  eventAttended,
  @JsonValue('competitionWon')
  competitionWon,
  @JsonValue('workshopCompleted')
  workshopCompleted,
  @JsonValue('clubJoined')
  clubJoined,
  @JsonValue('leadershipRole')
  leadershipRole,
}

@freezed
class ActivityModel with _$ActivityModel {
  const factory ActivityModel({
    required String id,
    required String userId,
    @Default(ActivityType.eventAttended) ActivityType type,
    required String title,
    required String description,
    String? referenceId,
    @Default(0) int pointsAwarded,
    @TimestampConverter() required DateTime timestamp,
  }) = _ActivityModel;

  factory ActivityModel.fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

enum NotificationType {
  @JsonValue('eventReminder')
  eventReminder,
  @JsonValue('registrationSuccess')
  registrationSuccess,
  @JsonValue('certificateIssued')
  certificateIssued,
  @JsonValue('pointsEarned')
  pointsEarned,
  @JsonValue('announcement')
  announcement,
}

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String userId,
    required String title,
    required String body,
    @Default(NotificationType.announcement) NotificationType type,
    String? actionRoute,
    @Default(false) bool isRead,
    @TimestampConverter() required DateTime createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';

part 'announcement_model.freezed.dart';
part 'announcement_model.g.dart';

enum AnnouncementPriority {
  @JsonValue('normal')
  normal,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

@freezed
class AnnouncementModel with _$AnnouncementModel {
  const factory AnnouncementModel({
    required String id,
    String? clubId,
    String? departmentId,
    required String title,
    required String content,
    @Default(AnnouncementPriority.normal) AnnouncementPriority priority,
    required String authorId,
    @TimestampConverter() required DateTime createdAt,
  }) = _AnnouncementModel;

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementModelFromJson(json);
}

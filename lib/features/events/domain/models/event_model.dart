import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

enum EventCategory {
  @JsonValue('workshop')
  workshop,
  @JsonValue('hackathon')
  hackathon,
  @JsonValue('competition')
  competition,
  @JsonValue('guestLecture')
  guestLecture,
  @JsonValue('meetup')
  meetup,
}

enum EventMode {
  @JsonValue('inPerson')
  inPerson,
  @JsonValue('virtual')
  virtual,
  @JsonValue('hybrid')
  hybrid,
}

enum EventStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('pendingApproval')
  pendingApproval,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
  @JsonValue('ongoing')
  ongoing,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required String id,
    required String clubId,
    required String title,
    required String description,
    @Default(EventCategory.workshop) EventCategory category,
    @Default(EventMode.inPerson) EventMode mode,
    String? venue,
    String? eventUrl,
    String? bannerUrl,
    @TimestampConverter() required DateTime startDateTime,
    @TimestampConverter() required DateTime endDateTime,
    @TimestampConverter() required DateTime registrationDeadline,
    int? maxSeats,
    @Default(0) int registeredCount,
    @Default(50) int basePoints,
    @Default(EventStatus.pendingApproval) EventStatus status,
    required String createdByUserId,
    String? approvedByFacultyId,
    @TimestampConverter() required DateTime createdAt,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);
}

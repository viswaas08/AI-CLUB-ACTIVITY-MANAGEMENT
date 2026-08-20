import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';

part 'event_registration_model.freezed.dart';
part 'event_registration_model.g.dart';

enum RegistrationStatus {
  @JsonValue('registered')
  registered,
  @JsonValue('waitlisted')
  waitlisted,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('attended')
  attended,
}

@freezed
class EventRegistrationModel with _$EventRegistrationModel {
  const factory EventRegistrationModel({
    required String id,
    required String eventId,
    required String userId,
    required String clubId,
    @TimestampConverter() required DateTime registeredAt,
    @Default(RegistrationStatus.registered) RegistrationStatus status,
    String? cancellationReason,
  }) = _EventRegistrationModel;

  factory EventRegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$EventRegistrationModelFromJson(json);
}

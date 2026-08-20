import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';

part 'club_member_model.freezed.dart';
part 'club_member_model.g.dart';

enum MemberRole {
  @JsonValue('member')
  member,
  @JsonValue('lead')
  lead,
  @JsonValue('coordinator')
  coordinator,
}

@freezed
class ClubMemberModel with _$ClubMemberModel {
  const factory ClubMemberModel({
    required String id,
    required String clubId,
    required String userId,
    @Default(MemberRole.member) MemberRole role,
    @TimestampConverter() required DateTime joinedAt,
    @Default(true) bool isActive,
  }) = _ClubMemberModel;

  factory ClubMemberModel.fromJson(Map<String, dynamic> json) => _$ClubMemberModelFromJson(json);
}

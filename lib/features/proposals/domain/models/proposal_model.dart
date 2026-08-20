import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';

part 'proposal_model.freezed.dart';
part 'proposal_model.g.dart';

enum ProposalStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('escalated')
  escalated,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
}

@freezed
class ProposalModel with _$ProposalModel {
  const factory ProposalModel({
    required String id,
    required String title,
    required String description,
    required String category,
    required String authorId,
    required String authorName,
    @Default(0) int upvoteCount,
    @Default([]) List<String> upvotedUserIds,
    @Default(ProposalStatus.pending) ProposalStatus status,
    @TimestampConverter() required DateTime createdAt,
  }) = _ProposalModel;

  factory ProposalModel.fromJson(Map<String, dynamic> json) => _$ProposalModelFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';
import 'activity_model.dart';

part 'point_rule_model.freezed.dart';
part 'point_rule_model.g.dart';

@freezed
class PointRuleModel with _$PointRuleModel {
  const factory PointRuleModel({
    required String id,
    required ActivityType activityType,
    required int points,
    required String description,
    @TimestampConverter() required DateTime updatedAt,
    required String updatedByUserId,
  }) = _PointRuleModel;

  factory PointRuleModel.fromJson(Map<String, dynamic> json) =>
      _$PointRuleModelFromJson(json);
}

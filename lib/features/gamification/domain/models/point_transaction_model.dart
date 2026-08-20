import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/firebase/timestamp_converter.dart';

part 'point_transaction_model.freezed.dart';
part 'point_transaction_model.g.dart';

enum TransactionType {
  @JsonValue('credit')
  credit,
  @JsonValue('debit')
  debit,
}

enum TransactionSource {
  @JsonValue('eventAttendance')
  eventAttendance,
  @JsonValue('competitionWin')
  competitionWin,
  @JsonValue('clubJoin')
  clubJoin,
  @JsonValue('leadership')
  leadership,
  @JsonValue('manualAdjustment')
  manualAdjustment,
}

@freezed
class PointTransactionModel with _$PointTransactionModel {
  const factory PointTransactionModel({
    required String id,
    required String userId,
    required int points,
    @Default(TransactionType.credit) TransactionType transactionType,
    @Default(TransactionSource.eventAttendance) TransactionSource source,
    String? referenceId,
    String? performedByUserId,
    @TimestampConverter() required DateTime timestamp,
  }) = _PointTransactionModel;

  factory PointTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$PointTransactionModelFromJson(json);
}

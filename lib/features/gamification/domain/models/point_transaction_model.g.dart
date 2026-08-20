// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointTransactionModelImpl _$$PointTransactionModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointTransactionModelImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  points: (json['points'] as num).toInt(),
  transactionType:
      $enumDecodeNullable(_$TransactionTypeEnumMap, json['transactionType']) ??
      TransactionType.credit,
  source:
      $enumDecodeNullable(_$TransactionSourceEnumMap, json['source']) ??
      TransactionSource.eventAttendance,
  referenceId: json['referenceId'] as String?,
  performedByUserId: json['performedByUserId'] as String?,
  timestamp: const TimestampConverter().fromJson(json['timestamp']),
);

Map<String, dynamic> _$$PointTransactionModelImplToJson(
  _$PointTransactionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'points': instance.points,
  'transactionType': _$TransactionTypeEnumMap[instance.transactionType]!,
  'source': _$TransactionSourceEnumMap[instance.source]!,
  'referenceId': instance.referenceId,
  'performedByUserId': instance.performedByUserId,
  'timestamp': const TimestampConverter().toJson(instance.timestamp),
};

const _$TransactionTypeEnumMap = {
  TransactionType.credit: 'credit',
  TransactionType.debit: 'debit',
};

const _$TransactionSourceEnumMap = {
  TransactionSource.eventAttendance: 'eventAttendance',
  TransactionSource.competitionWin: 'competitionWin',
  TransactionSource.clubJoin: 'clubJoin',
  TransactionSource.leadership: 'leadership',
  TransactionSource.manualAdjustment: 'manualAdjustment',
};

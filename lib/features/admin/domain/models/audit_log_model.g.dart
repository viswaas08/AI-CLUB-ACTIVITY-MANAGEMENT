// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuditLogModelImpl _$$AuditLogModelImplFromJson(Map<String, dynamic> json) =>
    _$AuditLogModelImpl(
      id: json['id'] as String,
      performedByUserId: json['performedByUserId'] as String,
      action: json['action'] as String,
      targetCollection: json['targetCollection'] as String,
      targetDocumentId: json['targetDocumentId'] as String,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      timestamp: const TimestampConverter().fromJson(json['timestamp']),
    );

Map<String, dynamic> _$$AuditLogModelImplToJson(_$AuditLogModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'performedByUserId': instance.performedByUserId,
      'action': instance.action,
      'targetCollection': instance.targetCollection,
      'targetDocumentId': instance.targetDocumentId,
      'metadata': instance.metadata,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };

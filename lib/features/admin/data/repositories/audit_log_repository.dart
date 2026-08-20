import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/firebase/firestore_converters.dart';
import '../../domain/models/audit_log_model.dart';

abstract class AuditLogRepository {
  Future<void> logAction(AuditLogModel auditLog);
  Stream<List<AuditLogModel>> streamAuditLogs();
}

class FirestoreAuditLogRepository implements AuditLogRepository {
  final FirebaseFirestore _firestore;

  FirestoreAuditLogRepository(this._firestore);

  static final List<AuditLogModel> _sampleAuditLogs = [
    AuditLogModel(
      id: 'log_1',
      performedByUserId: 'demo_admin_user',
      action: 'POINT_RULE_UPDATED',
      targetCollection: 'pointRules',
      targetDocumentId: 'rule_workshop',
      metadata: {'newPoints': 50, 'reason': 'Annual curriculum adjustment'},
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    AuditLogModel(
      id: 'log_2',
      performedByUserId: 'demo_faculty_user',
      action: 'EVENT_APPROVED',
      targetCollection: 'events',
      targetDocumentId: 'event_1',
      metadata: {'eventTitle': 'Generative AI & Agentic Architecture Workshop'},
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    AuditLogModel(
      id: 'log_3',
      performedByUserId: 'demo_admin_user',
      action: 'USER_ROLE_UPDATED',
      targetCollection: 'users',
      targetDocumentId: 'demo_clubAdmin_user',
      metadata: {'newRole': 'clubAdmin', 'clubId': 'club_1'},
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Future<void> logAction(AuditLogModel auditLog) async {
    try {
      final docRef = FirestoreConverters.auditLogs(_firestore).doc();
      final logWithId = auditLog.copyWith(id: docRef.id);
      await docRef.set(logWithId);
    } catch (_) {}
  }

  @override
  Stream<List<AuditLogModel>> streamAuditLogs() {
    try {
      return FirestoreConverters.auditLogs(_firestore)
          .snapshots()
          .map((snap) {
            final list = snap.docs.map((d) => d.data()).toList();
            return list.isNotEmpty ? list : _sampleAuditLogs;
          })
          .handleError((_) => _sampleAuditLogs);
    } catch (_) {
      return Stream.value(_sampleAuditLogs);
    }
  }
}

final auditLogRepositoryProvider = Provider<AuditLogRepository>((ref) {
  return FirestoreAuditLogRepository(ref.watch(firebaseFirestoreProvider));
});

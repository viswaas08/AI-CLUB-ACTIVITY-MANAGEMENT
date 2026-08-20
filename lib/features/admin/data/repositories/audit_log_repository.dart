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

  @override
  Future<void> logAction(AuditLogModel auditLog) async {
    final docRef = FirestoreConverters.auditLogs(_firestore).doc();
    final logWithId = auditLog.copyWith(id: docRef.id);
    await docRef.set(logWithId);
  }

  @override
  Stream<List<AuditLogModel>> streamAuditLogs() {
    return FirestoreConverters.auditLogs(_firestore)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }
}

final auditLogRepositoryProvider = Provider<AuditLogRepository>((ref) {
  return FirestoreAuditLogRepository(ref.watch(firebaseFirestoreProvider));
});

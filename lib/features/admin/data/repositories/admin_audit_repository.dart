import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/firebase/firestore_converters.dart';
import '../../../../core/firebase/paginated_result.dart';
import '../../domain/models/audit_log_model.dart';

abstract class AdminAuditRepository {
  Future<PaginatedResult<AuditLogModel>> getAuditLogs({int limit = 50, DocumentSnapshot? startAfter});
  Future<void> recordLog(AuditLogModel log);
}

class FirestoreAdminAuditRepository implements AdminAuditRepository {
  final FirebaseFirestore _firestore;

  FirestoreAdminAuditRepository(this._firestore);

  @override
  Future<PaginatedResult<AuditLogModel>> getAuditLogs({
    int limit = 50,
    DocumentSnapshot? startAfter,
  }) async {
    var query = FirestoreConverters.auditLogs(_firestore)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snap = await query.get();
    final items = snap.docs.map((d) => d.data()).toList();
    final lastDoc = snap.docs.isNotEmpty ? snap.docs.last : null;

    return PaginatedResult(
      items: items,
      lastDocument: lastDoc,
      hasMore: items.length == limit,
    );
  }

  @override
  Future<void> recordLog(AuditLogModel log) async {
    await FirestoreConverters.auditLogs(_firestore).doc(log.id).set(log);
  }
}

final adminAuditRepositoryProvider = Provider<AdminAuditRepository>((ref) {
  return FirestoreAdminAuditRepository(ref.watch(firebaseFirestoreProvider));
});

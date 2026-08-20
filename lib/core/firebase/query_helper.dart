import 'package:cloud_firestore/cloud_firestore.dart';

class QueryHelper {
  static Query<T> applyPagination<T>(
    Query<T> query, {
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) {
    var q = query.limit(limit);
    if (startAfter != null) {
      q = q.startAfterDocument(startAfter);
    }
    return q;
  }

  static Query<T> applyDateRange<T>(
    Query<T> query, {
    required String fieldName,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    var q = query;
    if (startDate != null) {
      q = q.where(fieldName, isGreaterThanOrEqualTo: Timestamp.fromDate(startDate));
    }
    if (endDate != null) {
      q = q.where(fieldName, isLessThanOrEqualTo: Timestamp.fromDate(endDate));
    }
    return q;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/firebase/firestore_converters.dart';
import '../../domain/models/attendance_model.dart';
import '../../domain/models/attendance_session_model.dart';

abstract class AttendanceRepository {
  Future<AttendanceSessionModel?> getActiveSession(String eventId);
  Stream<AttendanceSessionModel?> streamActiveSessionForClub(String clubId);
  Future<void> createSession(AttendanceSessionModel session);
  Future<void> startAttendanceSession({
    required String eventId,
    required String clubId,
    required String createdBy,
  });
  Future<AttendanceModel?> recordAttendance(AttendanceModel attendance);
  Stream<List<AttendanceModel>> streamEventAttendance(String eventId);
}

class FirestoreAttendanceRepository implements AttendanceRepository {
  final FirebaseFirestore _firestore;

  FirestoreAttendanceRepository(this._firestore);

  @override
  Future<AttendanceSessionModel?> getActiveSession(String eventId) async {
    final snap = await FirestoreConverters.attendanceSessions(_firestore)
        .where('eventId', isEqualTo: eventId)
        .where('isActive', isEqualTo: true)
        .where('expiresAt', isGreaterThan: Timestamp.fromDate(DateTime.now()))
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return null;
    return snap.docs.first.data();
  }

  @override
  Stream<AttendanceSessionModel?> streamActiveSessionForClub(String clubId) {
    return FirestoreConverters.attendanceSessions(_firestore)
        .where('clubId', isEqualTo: clubId)
        .where('isActive', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map((snap) => snap.docs.isEmpty ? null : snap.docs.first.data());
  }

  @override
  Future<void> createSession(AttendanceSessionModel session) async {
    await FirestoreConverters.attendanceSessions(_firestore).doc(session.id).set(session);
  }

  @override
  Future<void> startAttendanceSession({
    required String eventId,
    required String clubId,
    required String createdBy,
  }) async {
    final sessionId = '${eventId}_session';
    final session = AttendanceSessionModel(
      id: sessionId,
      eventId: eventId,
      clubId: clubId,
      createdByUserId: createdBy,
      sessionToken: 'TOKEN-${DateTime.now().millisecondsSinceEpoch}',
      isActive: true,
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(hours: 2)),
    );
    await createSession(session);
  }

  @override
  Future<AttendanceModel?> recordAttendance(AttendanceModel attendance) async {
    final docRef = FirestoreConverters.attendance(_firestore).doc(attendance.id);
    await docRef.set(attendance);
    return attendance;
  }

  @override
  Stream<List<AttendanceModel>> streamEventAttendance(String eventId) {
    return FirestoreConverters.attendance(_firestore)
        .where('eventId', isEqualTo: eventId)
        .orderBy('scannedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }
}

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return FirestoreAttendanceRepository(ref.watch(firebaseFirestoreProvider));
});

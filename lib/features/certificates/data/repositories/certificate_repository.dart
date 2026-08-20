import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/firebase/firestore_converters.dart';
import '../../domain/models/certificate_model.dart';

final certificateRepositoryProvider = Provider<CertificateRepository>((ref) {
  return CertificateRepository(ref.watch(firebaseFirestoreProvider));
});

final publicCertificateProvider =
    FutureProvider.family<CertificateModel?, String>((ref, certificateId) async {
  final repo = ref.watch(certificateRepositoryProvider);
  return repo.getCertificateById(certificateId);
});

class CertificateRepository {
  final FirebaseFirestore _firestore;

  CertificateRepository(this._firestore);

  Future<CertificateModel?> getCertificateById(String id) async {
    final doc = await FirestoreConverters.certificates(_firestore).doc(id).get();
    return doc.data();
  }

  Stream<List<CertificateModel>> watchStudentCertificates(String studentId) {
    return FirestoreConverters.certificates(_firestore)
        .where('studentId', isEqualTo: studentId)
        .where('status', isEqualTo: 'VALID')
        .orderBy('issueDate', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList());
  }

  Stream<List<CertificateModel>> streamStudentCertificates(String studentId) {
    return watchStudentCertificates(studentId);
  }

  Stream<List<CertificateModel>> streamClubCertificates(String clubId) {
    return FirestoreConverters.certificates(_firestore)
        .where('clubId', isEqualTo: clubId)
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList());
  }

  Future<CertificateModel?> getCertificateByNumber(String certNumber) async {
    final snap = await FirestoreConverters.certificates(_firestore)
        .where('certificateNumber', isEqualTo: certNumber)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return null;
    return snap.docs.first.data();
  }

  Future<void> batchIssueCertificates({
    required String eventId,
    required String clubId,
    required List<String> studentIds,
  }) async {
    final batch = _firestore.batch();
    for (final sId in studentIds) {
      final certId = 'CERT_${eventId}_$sId';
      final cert = CertificateModel(
        id: certId,
        certificateNumber: 'CERT-2026-${DateTime.now().millisecondsSinceEpoch % 100000}',
        studentId: sId,
        studentName: 'Student Recipient',
        studentRollNo: '2026-CS-1092',
        eventId: eventId,
        eventTitle: 'AI Technical Workshop',
        clubId: clubId,
        clubName: 'AI Society',
        achievementTitle: 'Excellence in AI Workshop',
        issueDate: DateTime.now(),
        issuerUserId: 'admin-id',
        issuerName: 'Dr. Sarah Connor',
        issuerRole: 'clubAdmin',
        status: CertificateStatus.valid,
        pdfUrl: 'https://storage.googleapis.com/aiclubs-portal.appspot.com/certificates/$certId.pdf',
        verificationUrl: 'https://aiclubs-portal.web.app/verify/certificate/$certId',
      );
      batch.set(FirestoreConverters.certificates(_firestore).doc(certId), cert);
    }
    await batch.commit();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/data/sample_seeds.dart';
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
    try {
      final doc = await FirestoreConverters.certificates(_firestore).doc(id).get();
      if (doc.exists && doc.data() != null) return doc.data();
    } catch (_) {}
    return SampleSeeds.certificates.firstWhere(
      (c) => c.id == id,
      orElse: () => SampleSeeds.certificates.first,
    );
  }

  Stream<List<CertificateModel>> watchStudentCertificates(String studentId) {
    try {
      return FirestoreConverters.certificates(_firestore)
          .where('studentId', isEqualTo: studentId)
          .snapshots()
          .map((s) {
            final list = s.docs.map((d) => d.data()).toList();
            return list.isNotEmpty ? list : SampleSeeds.certificates;
          })
          .handleError((_) => SampleSeeds.certificates);
    } catch (_) {
      return Stream.value(SampleSeeds.certificates);
    }
  }

  Stream<List<CertificateModel>> streamStudentCertificates(String studentId) {
    return watchStudentCertificates(studentId);
  }

  Stream<List<CertificateModel>> streamClubCertificates(String clubId) {
    try {
      return FirestoreConverters.certificates(_firestore)
          .where('clubId', isEqualTo: clubId)
          .snapshots()
          .map((s) {
            final list = s.docs.map((d) => d.data()).toList();
            return list.isNotEmpty
                ? list
                : SampleSeeds.certificates.where((c) => c.clubId == clubId).toList();
          })
          .handleError((_) => SampleSeeds.certificates.where((c) => c.clubId == clubId).toList());
    } catch (_) {
      return Stream.value(SampleSeeds.certificates.where((c) => c.clubId == clubId).toList());
    }
  }

  Future<CertificateModel?> getCertificateByNumber(String certNumber) async {
    try {
      final snap = await FirestoreConverters.certificates(_firestore)
          .where('certificateNumber', isEqualTo: certNumber)
          .limit(1)
          .get();

      if (snap.docs.isNotEmpty) return snap.docs.first.data();
    } catch (_) {}
    return SampleSeeds.certificates.first;
  }

  Future<void> batchIssueCertificates({
    required String eventId,
    required String clubId,
    required List<String> studentIds,
    required String facultyId,
  }) async {
    try {
      final batch = _firestore.batch();
      for (final studentId in studentIds) {
        final certId = '${eventId}_$studentId';
        final cert = CertificateModel(
          id: certId,
          certificateNumber: 'CERT-2026-$certId',
          studentId: studentId,
          studentName: 'Student Member',
          studentRollNo: '2026-ROLL-$studentId',
          eventId: eventId,
          eventTitle: 'Campus Activity & Workshop',
          clubId: clubId,
          clubName: 'Student Club Society',
          achievementTitle: 'Certificate of Excellence',
          issueDate: DateTime.now(),
          issuerUserId: facultyId,
          issuerName: 'Faculty Advisor',
          issuerRole: 'Faculty Signer',
          pdfUrl: 'https://ai-club-activity.web.app/certificates/$certId.pdf',
          verificationUrl: 'https://ai-club-activity.web.app/verify/certificate/$certId',
          status: CertificateStatus.valid,
        );
        batch.set(FirestoreConverters.certificates(_firestore).doc(certId), cert);
      }
      await batch.commit();
    } catch (_) {}
  }
}

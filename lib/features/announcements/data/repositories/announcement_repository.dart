import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/firebase/firestore_converters.dart';
import '../../domain/models/announcement_model.dart';

abstract class AnnouncementRepository {
  Stream<List<AnnouncementModel>> streamClubAnnouncements(String clubId);
  Future<void> createAnnouncement(AnnouncementModel announcement);
}

class FirestoreAnnouncementRepository implements AnnouncementRepository {
  final FirebaseFirestore _firestore;

  FirestoreAnnouncementRepository(this._firestore);

  @override
  Stream<List<AnnouncementModel>> streamClubAnnouncements(String clubId) {
    return FirestoreConverters.announcements(_firestore)
        .where('clubId', isEqualTo: clubId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  @override
  Future<void> createAnnouncement(AnnouncementModel announcement) async {
    await FirestoreConverters.announcements(_firestore).doc(announcement.id).set(announcement);
  }
}

final announcementRepositoryProvider = Provider<AnnouncementRepository>((ref) {
  return FirestoreAnnouncementRepository(ref.watch(firebaseFirestoreProvider));
});

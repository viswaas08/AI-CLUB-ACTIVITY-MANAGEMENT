import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/data/sample_seeds.dart';
import '../../../../core/firebase/firestore_converters.dart';
import '../../domain/models/club_member_model.dart';
import '../../domain/models/club_model.dart';

abstract class ClubRepository {
  Future<ClubModel?> getClubById(String id);
  Stream<ClubModel?> streamClubById(String id);
  Stream<List<ClubModel>> streamActiveClubs();
  Stream<List<ClubModel>> streamAdminClubs(String userId);
  Future<void> createClub(ClubModel club);
  Future<void> updateClub(ClubModel club);
  Future<void> joinClub({required String clubId, required String userId});
  Stream<List<ClubMemberModel>> streamClubMembers(String clubId);
  Future<void> updateMemberRole(String memberId, MemberRole newRole);
}

class FirestoreClubRepository implements ClubRepository {
  final FirebaseFirestore _firestore;

  FirestoreClubRepository(this._firestore);

  @override
  Future<ClubModel?> getClubById(String id) async {
    try {
      final doc = await FirestoreConverters.clubs(_firestore).doc(id).get();
      if (doc.exists && doc.data() != null) return doc.data();
    } catch (_) {}
    return SampleSeeds.clubs.firstWhere(
      (c) => c.id == id,
      orElse: () => SampleSeeds.clubs.first,
    );
  }

  @override
  Stream<ClubModel?> streamClubById(String id) {
    return FirestoreConverters.clubs(_firestore)
        .doc(id)
        .snapshots()
        .map((snap) => snap.data() ?? SampleSeeds.clubs.firstWhere((c) => c.id == id, orElse: () => SampleSeeds.clubs.first))
        .handleError((_) => SampleSeeds.clubs.firstWhere((c) => c.id == id, orElse: () => SampleSeeds.clubs.first));
  }

  @override
  Stream<List<ClubModel>> streamActiveClubs() {
    return FirestoreConverters.clubs(_firestore)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snap) {
          final list = snap.docs.map((d) => d.data()).toList();
          return list.isNotEmpty ? list : SampleSeeds.clubs;
        })
        .handleError((_) => SampleSeeds.clubs);
  }

  @override
  Stream<List<ClubModel>> streamAdminClubs(String userId) {
    return FirestoreConverters.clubs(_firestore)
        .where('administeredClubIds', arrayContains: userId)
        .snapshots()
        .map((snap) {
          final list = snap.docs.map((d) => d.data()).toList();
          return list.isNotEmpty ? list : SampleSeeds.clubs.take(2).toList();
        })
        .handleError((_) => SampleSeeds.clubs.take(2).toList());
  }

  @override
  Future<void> createClub(ClubModel club) async {
    try {
      await FirestoreConverters.clubs(_firestore).doc(club.id).set(club);
    } catch (_) {}
  }

  @override
  Future<void> updateClub(ClubModel club) async {
    try {
      await FirestoreConverters.clubs(_firestore).doc(club.id).set(club, SetOptions(merge: true));
    } catch (_) {}
  }

  @override
  Future<void> joinClub({required String clubId, required String userId}) async {
    try {
      final memberId = '${clubId}_$userId';
      final member = ClubMemberModel(
        id: memberId,
        clubId: clubId,
        userId: userId,
        role: MemberRole.member,
        joinedAt: DateTime.now(),
        isActive: true,
      );

      final batch = _firestore.batch();
      batch.set(FirestoreConverters.clubMembers(_firestore).doc(memberId), member);
      batch.update(FirestoreConverters.clubs(_firestore).doc(clubId), {
        'totalMembers': FieldValue.increment(1),
      });
      batch.update(FirestoreConverters.users(_firestore).doc(userId), {
        'joinedClubIds': FieldValue.arrayUnion([clubId]),
      });
      await batch.commit();
    } catch (_) {}
  }

  @override
  Stream<List<ClubMemberModel>> streamClubMembers(String clubId) {
    return FirestoreConverters.clubMembers(_firestore)
        .where('clubId', isEqualTo: clubId)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList())
        .handleError((_) => <ClubMemberModel>[]);
  }

  @override
  Future<void> updateMemberRole(String memberId, MemberRole newRole) async {
    try {
      await FirestoreConverters.clubMembers(_firestore).doc(memberId).update({
        'role': newRole.name,
      });
    } catch (_) {}
  }
}

final clubRepositoryProvider = Provider<ClubRepository>((ref) {
  return FirestoreClubRepository(ref.watch(firebaseFirestoreProvider));
});

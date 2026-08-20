import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
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
    final doc = await FirestoreConverters.clubs(_firestore).doc(id).get();
    return doc.data();
  }

  @override
  Stream<ClubModel?> streamClubById(String id) {
    return FirestoreConverters.clubs(_firestore)
        .doc(id)
        .snapshots()
        .map((snap) => snap.data());
  }

  @override
  Stream<List<ClubModel>> streamActiveClubs() {
    return FirestoreConverters.clubs(_firestore)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  @override
  Stream<List<ClubModel>> streamAdminClubs(String userId) {
    return FirestoreConverters.clubs(_firestore)
        .where('administeredClubIds', arrayContains: userId)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  @override
  Future<void> createClub(ClubModel club) async {
    await FirestoreConverters.clubs(_firestore).doc(club.id).set(club);
  }

  @override
  Future<void> updateClub(ClubModel club) async {
    await FirestoreConverters.clubs(_firestore).doc(club.id).set(club, SetOptions(merge: true));
  }

  @override
  Future<void> joinClub({required String clubId, required String userId}) async {
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
  }

  @override
  Stream<List<ClubMemberModel>> streamClubMembers(String clubId) {
    return FirestoreConverters.clubMembers(_firestore)
        .where('clubId', isEqualTo: clubId)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  @override
  Future<void> updateMemberRole(String memberId, MemberRole newRole) async {
    await FirestoreConverters.clubMembers(_firestore).doc(memberId).update({
      'role': newRole.name,
    });
  }
}

final clubRepositoryProvider = Provider<ClubRepository>((ref) {
  return FirestoreClubRepository(ref.watch(firebaseFirestoreProvider));
});

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/firebase/firestore_converters.dart';
import '../../../../core/firebase/paginated_result.dart';
import '../../domain/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> getUserById(String uid);
  Stream<UserModel?> streamUser(String uid);
  Future<void> createUserProfile(UserModel user);
  Future<void> updateUserProfile(UserModel user);
  Future<PaginatedResult<UserModel>> getLeaderboard({int limit = 20, DocumentSnapshot? startAfter});
}

class FirestoreUserRepository implements UserRepository {
  final FirebaseFirestore _firestore;

  FirestoreUserRepository(this._firestore);

  @override
  Future<UserModel?> getUserById(String uid) async {
    final doc = await FirestoreConverters.users(_firestore).doc(uid).get();
    return doc.data();
  }

  @override
  Stream<UserModel?> streamUser(String uid) {
    return FirestoreConverters.users(_firestore).doc(uid).snapshots().map((snap) => snap.data());
  }

  @override
  Future<void> createUserProfile(UserModel user) async {
    await FirestoreConverters.users(_firestore).doc(user.id).set(user);
  }

  @override
  Future<void> updateUserProfile(UserModel user) async {
    await FirestoreConverters.users(_firestore).doc(user.id).set(user, SetOptions(merge: true));
  }

  @override
  Future<PaginatedResult<UserModel>> getLeaderboard({
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    var query = FirestoreConverters.users(_firestore)
        .orderBy('totalPoints', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();
    final items = snapshot.docs.map((doc) => doc.data()).toList();
    final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

    return PaginatedResult(
      items: items,
      lastDocument: lastDoc,
      hasMore: items.length == limit,
    );
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return FirestoreUserRepository(ref.watch(firebaseFirestoreProvider));
});

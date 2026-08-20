import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/firebase/firestore_converters.dart';
import '../../domain/models/achievement_model.dart';
import '../../domain/models/activity_model.dart';
import '../../domain/models/point_rule_model.dart';
import '../../domain/models/point_transaction_model.dart';

abstract class GamificationRepository {
  Stream<List<ActivityModel>> streamUserActivities(String userId);
  Stream<List<AchievementModel>> streamUserAchievements(String userId);
  Stream<List<PointTransactionModel>> streamUserTransactions(String userId);
  Future<List<PointRuleModel>> getPointRules();
}

class FirestoreGamificationRepository implements GamificationRepository {
  final FirebaseFirestore _firestore;

  FirestoreGamificationRepository(this._firestore);

  @override
  Stream<List<ActivityModel>> streamUserActivities(String userId) {
    return FirestoreConverters.activities(_firestore)
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  @override
  Stream<List<AchievementModel>> streamUserAchievements(String userId) {
    return FirestoreConverters.achievements(_firestore)
        .where('userId', isEqualTo: userId)
        .orderBy('unlockedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  @override
  Stream<List<PointTransactionModel>> streamUserTransactions(String userId) {
    return FirestoreConverters.pointTransactions(_firestore)
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  @override
  Future<List<PointRuleModel>> getPointRules() async {
    final snap = await FirestoreConverters.pointRules(_firestore).get();
    return snap.docs.map((d) => d.data()).toList();
  }
}

final gamificationRepositoryProvider = Provider<GamificationRepository>((ref) {
  return FirestoreGamificationRepository(ref.watch(firebaseFirestoreProvider));
});

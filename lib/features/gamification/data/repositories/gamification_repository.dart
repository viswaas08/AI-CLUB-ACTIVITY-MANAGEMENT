import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/data/sample_seeds.dart';
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
    try {
      return FirestoreConverters.activities(_firestore)
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snap) {
            final list = snap.docs.map((d) => d.data()).toList();
            return list.isNotEmpty ? list : SampleSeeds.activities;
          })
          .handleError((_) => SampleSeeds.activities);
    } catch (_) {
      return Stream.value(SampleSeeds.activities);
    }
  }

  @override
  Stream<List<AchievementModel>> streamUserAchievements(String userId) {
    try {
      return FirestoreConverters.achievements(_firestore)
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snap) {
            final list = snap.docs.map((d) => d.data()).toList();
            return list.isNotEmpty ? list : SampleSeeds.achievements;
          })
          .handleError((_) => SampleSeeds.achievements);
    } catch (_) {
      return Stream.value(SampleSeeds.achievements);
    }
  }

  @override
  Stream<List<PointTransactionModel>> streamUserTransactions(String userId) {
    try {
      return FirestoreConverters.pointTransactions(_firestore)
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snap) => snap.docs.map((d) => d.data()).toList())
          .handleError((_) => <PointTransactionModel>[]);
    } catch (_) {
      return Stream.value([]);
    }
  }

  @override
  Future<List<PointRuleModel>> getPointRules() async {
    try {
      final snap = await FirestoreConverters.pointRules(_firestore).get();
      return snap.docs.map((d) => d.data()).toList();
    } catch (_) {
      return [];
    }
  }
}

final gamificationRepositoryProvider = Provider<GamificationRepository>((ref) {
  return FirestoreGamificationRepository(ref.watch(firebaseFirestoreProvider));
});

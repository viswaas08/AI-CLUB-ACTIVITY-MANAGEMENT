import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/data/sample_seeds.dart';
import '../../../../core/firebase/firestore_converters.dart';
import '../../domain/models/notification_model.dart';

abstract class NotificationRepository {
  Stream<List<NotificationModel>> streamUserNotifications(String userId);
  Future<void> markAsRead(String notificationId);
}

class FirestoreNotificationRepository implements NotificationRepository {
  final FirebaseFirestore _firestore;

  FirestoreNotificationRepository(this._firestore);

  @override
  Stream<List<NotificationModel>> streamUserNotifications(String userId) {
    try {
      return FirestoreConverters.notifications(_firestore)
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snap) {
            final list = snap.docs.map((d) => d.data()).toList();
            return list.isNotEmpty ? list : SampleSeeds.notifications;
          })
          .handleError((_) => SampleSeeds.notifications);
    } catch (_) {
      return Stream.value(SampleSeeds.notifications);
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await FirestoreConverters.notifications(_firestore)
          .doc(notificationId)
          .update({'isRead': true});
    } catch (_) {}
  }
}

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return FirestoreNotificationRepository(ref.watch(firebaseFirestoreProvider));
});

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
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
    return FirestoreConverters.notifications(_firestore)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.data()).toList());
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await FirestoreConverters.notifications(_firestore)
        .doc(notificationId)
        .update({'isRead': true});
  }
}

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return FirestoreNotificationRepository(ref.watch(firebaseFirestoreProvider));
});

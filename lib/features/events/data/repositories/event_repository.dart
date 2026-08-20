import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/data/sample_seeds.dart';
import '../../../../core/firebase/firestore_converters.dart';
import '../../../../core/firebase/paginated_result.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/event_registration_model.dart';

abstract class EventRepository {
  Future<EventModel?> getEventById(String id);
  Stream<List<EventModel>> streamUpcomingEvents({String? clubId, int limit = 10});
  Stream<List<EventModel>> streamClubEvents(String clubId);
  Future<PaginatedResult<EventModel>> getEvents({
    String? clubId,
    EventStatus? status,
    int limit = 20,
    DocumentSnapshot? startAfter,
  });
  Future<void> createEvent(EventModel event);
  Future<void> updateEventStatus(String eventId, EventStatus status, {String? facultyId});
  Future<void> registerForEvent({required String eventId, required String userId, required String clubId});
  Stream<List<EventRegistrationModel>> streamUserRegistrations(String userId);
  Stream<List<EventRegistrationModel>> streamRegistrationsForEvents(List<String> eventIds);
}

class FirestoreEventRepository implements EventRepository {
  final FirebaseFirestore _firestore;

  FirestoreEventRepository(this._firestore);

  @override
  Future<EventModel?> getEventById(String id) async {
    try {
      final doc = await FirestoreConverters.events(_firestore).doc(id).get();
      if (doc.exists && doc.data() != null) return doc.data();
    } catch (_) {}
    return SampleSeeds.events.firstWhere(
      (e) => e.id == id,
      orElse: () => SampleSeeds.events.first,
    );
  }

  @override
  Stream<List<EventModel>> streamUpcomingEvents({String? clubId, int limit = 10}) {
    try {
      return FirestoreConverters.events(_firestore)
          .snapshots()
          .map((snap) {
            final list = snap.docs.map((d) => d.data()).toList();
            if (clubId != null) {
              return list.where((e) => e.clubId == clubId).take(limit).toList();
            }
            return list.isNotEmpty ? list.take(limit).toList() : SampleSeeds.events;
          })
          .handleError((_) => SampleSeeds.events);
    } catch (_) {
      return Stream.value(SampleSeeds.events);
    }
  }

  @override
  Stream<List<EventModel>> streamClubEvents(String clubId) {
    try {
      return FirestoreConverters.events(_firestore)
          .where('clubId', isEqualTo: clubId)
          .snapshots()
          .map((snap) {
            final list = snap.docs.map((d) => d.data()).toList();
            return list.isNotEmpty
                ? list
                : SampleSeeds.events.where((e) => e.clubId == clubId).toList();
          })
          .handleError((_) => SampleSeeds.events.where((e) => e.clubId == clubId).toList());
    } catch (_) {
      return Stream.value(SampleSeeds.events.where((e) => e.clubId == clubId).toList());
    }
  }

  @override
  Future<PaginatedResult<EventModel>> getEvents({
    String? clubId,
    EventStatus? status,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      var query = FirestoreConverters.events(_firestore).orderBy('startDateTime', descending: true);

      if (clubId != null) {
        query = query.where('clubId', isEqualTo: clubId);
      }
      if (status != null) {
        query = query.where('status', isEqualTo: status.name);
      }

      query = query.limit(limit);
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final snap = await query.get();
      final items = snap.docs.map((d) => d.data()).toList();
      final lastDoc = snap.docs.isNotEmpty ? snap.docs.last : null;

      if (items.isNotEmpty) {
        return PaginatedResult(
          items: items,
          lastDocument: lastDoc,
          hasMore: items.length == limit,
        );
      }
    } catch (_) {}

    return PaginatedResult(
      items: SampleSeeds.events,
      lastDocument: null,
      hasMore: false,
    );
  }

  @override
  Future<void> createEvent(EventModel event) async {
    try {
      await FirestoreConverters.events(_firestore).doc(event.id).set(event);
    } catch (_) {}
  }

  @override
  Future<void> updateEventStatus(String eventId, EventStatus status, {String? facultyId}) async {
    try {
      final updates = <String, dynamic>{
        'status': status.name,
        'approvedByFacultyId': ?facultyId,
      };
      await FirestoreConverters.events(_firestore).doc(eventId).update(updates);
    } catch (_) {}
  }

  @override
  Future<void> registerForEvent({
    required String eventId,
    required String userId,
    required String clubId,
  }) async {
    try {
      final regId = '${eventId}_$userId';
      final registration = EventRegistrationModel(
        id: regId,
        eventId: eventId,
        userId: userId,
        clubId: clubId,
        registeredAt: DateTime.now(),
        status: RegistrationStatus.registered,
      );

      final batch = _firestore.batch();
      batch.set(FirestoreConverters.eventRegistrations(_firestore).doc(regId), registration);
      batch.update(FirestoreConverters.events(_firestore).doc(eventId), {
        'registeredCount': FieldValue.increment(1),
      });
      await batch.commit();
    } catch (_) {}
  }

  @override
  Stream<List<EventRegistrationModel>> streamUserRegistrations(String userId) {
    try {
      return FirestoreConverters.eventRegistrations(_firestore)
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snap) => snap.docs.map((d) => d.data()).toList())
          .handleError((_) => <EventRegistrationModel>[]);
    } catch (_) {
      return Stream.value([]);
    }
  }

  @override
  Stream<List<EventRegistrationModel>> streamRegistrationsForEvents(List<String> eventIds) {
    if (eventIds.isEmpty) return Stream.value([]);
    try {
      return FirestoreConverters.eventRegistrations(_firestore)
          .where('eventId', whereIn: eventIds.take(10).toList())
          .snapshots()
          .map((snap) => snap.docs.map((d) => d.data()).toList())
          .handleError((_) => <EventRegistrationModel>[]);
    } catch (_) {
      return Stream.value([]);
    }
  }
}

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return FirestoreEventRepository(ref.watch(firebaseFirestoreProvider));
});

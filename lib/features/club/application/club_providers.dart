import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../announcements/data/repositories/announcement_repository.dart';
import '../../announcements/domain/models/announcement_model.dart';
import '../../attendance/data/repositories/attendance_repository.dart';
import '../../attendance/domain/models/attendance_session_model.dart';
import '../../auth/application/auth_providers.dart';
import '../../certificates/data/repositories/certificate_repository.dart';
import '../../certificates/domain/models/certificate_model.dart';
import '../../clubs/data/repositories/club_repository.dart';
import '../../clubs/domain/models/club_member_model.dart';
import '../../clubs/domain/models/club_model.dart';
import '../../events/data/repositories/event_repository.dart';
import '../../events/domain/models/event_model.dart';
import '../../events/domain/models/event_registration_model.dart';

final adminClubsProvider = StreamProvider<List<ClubModel>>((ref) {
  final user = ref.watch(currentUserProvider).value;
  return ref.watch(clubRepositoryProvider).streamAdminClubs(user?.id ?? 'demo_clubAdmin_user');
});

final selectedAdminClubIdProvider = StateProvider<String?>((ref) {
  final adminClubs = ref.watch(adminClubsProvider).value;
  if (adminClubs != null && adminClubs.isNotEmpty) {
    return adminClubs.first.id;
  }
  return 'club_1';
});

final activeAdminClubProvider = StreamProvider<ClubModel?>((ref) {
  final selectedId = ref.watch(selectedAdminClubIdProvider);
  if (selectedId == null) return Stream.value(null);
  return ref.watch(clubRepositoryProvider).streamClubById(selectedId);
});

final clubEventsProvider = StreamProvider<List<EventModel>>((ref) {
  final selectedId = ref.watch(selectedAdminClubIdProvider);
  if (selectedId == null) return Stream.value([]);
  return ref.watch(eventRepositoryProvider).streamClubEvents(selectedId);
});

final clubMembersProvider = StreamProvider<List<ClubMemberModel>>((ref) {
  final selectedId = ref.watch(selectedAdminClubIdProvider);
  if (selectedId == null) return Stream.value([]);
  return ref.watch(clubRepositoryProvider).streamClubMembers(selectedId);
});

final clubRegistrationsProvider = StreamProvider<List<EventRegistrationModel>>((ref) {
  final events = ref.watch(clubEventsProvider).value ?? [];
  if (events.isEmpty) return Stream.value([]);
  final eventIds = events.map((e) => e.id).toList();
  return ref.watch(eventRepositoryProvider).streamRegistrationsForEvents(eventIds);
});

final clubAttendanceSessionProvider = StreamProvider<AttendanceSessionModel?>((ref) {
  final selectedId = ref.watch(selectedAdminClubIdProvider);
  if (selectedId == null) return Stream.value(null);
  return ref.watch(attendanceRepositoryProvider).streamActiveSessionForClub(selectedId);
});

final clubCertificatesProvider = StreamProvider<List<CertificateModel>>((ref) {
  final selectedId = ref.watch(selectedAdminClubIdProvider);
  if (selectedId == null) return Stream.value([]);
  return ref.watch(certificateRepositoryProvider).streamClubCertificates(selectedId);
});

final clubAnnouncementsProvider = StreamProvider<List<AnnouncementModel>>((ref) {
  final selectedId = ref.watch(selectedAdminClubIdProvider);
  if (selectedId == null) return Stream.value([]);
  return ref.watch(announcementRepositoryProvider).streamClubAnnouncements(selectedId);
});

class ClubAdminActionsController extends StateNotifier<AsyncValue<void>> {
  final EventRepository _eventRepo;
  final ClubRepository _clubRepo;
  final AttendanceRepository _attendanceRepo;
  final CertificateRepository _certRepo;
  final AnnouncementRepository _announcementRepo;

  ClubAdminActionsController(
    this._eventRepo,
    this._clubRepo,
    this._attendanceRepo,
    this._certRepo,
    this._announcementRepo,
  ) : super(const AsyncValue.data(null));

  Future<bool> createEvent({
    required String title,
    required String description,
    required String clubId,
    required EventCategory category,
    required EventMode mode,
    required DateTime date,
    required int basePoints,
    required int maxSeats,
    required String location,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final event = EventModel(
        id: '',
        title: title,
        description: description,
        clubId: clubId,
        category: category,
        mode: mode,
        startDateTime: date,
        endDateTime: date.add(const Duration(hours: 2)),
        registrationDeadline: date.subtract(const Duration(hours: 12)),
        createdByUserId: 'admin-id',
        venue: location,
        basePoints: basePoints,
        maxSeats: maxSeats,
        status: EventStatus.pendingApproval,
        registeredCount: 0,
        createdAt: DateTime.now(),
      );
      await _eventRepo.createEvent(event);
    });
    return !state.hasError;
  }

  Future<bool> cancelEvent(String eventId, String reason) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _eventRepo.updateEventStatus(eventId, EventStatus.cancelled),
    );
    return !state.hasError;
  }

  Future<bool> updateMemberRole(String memberId, MemberRole newRole) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _clubRepo.updateMemberRole(memberId, newRole),
    );
    return !state.hasError;
  }

  Future<bool> startAttendanceSession({
    required String eventId,
    required String clubId,
    required String createdBy,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _attendanceRepo.startAttendanceSession(
        eventId: eventId,
        clubId: clubId,
        createdBy: createdBy,
      ),
    );
    return !state.hasError;
  }

  Future<bool> batchIssueCertificates({
    required String eventId,
    required String clubId,
    required List<String> studentIds,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _certRepo.batchIssueCertificates(
        eventId: eventId,
        clubId: clubId,
        studentIds: studentIds,
        facultyId: 'fac_1',
      ),
    );
    return !state.hasError;
  }

  Future<bool> broadcastAnnouncement({
    required String clubId,
    required String title,
    required String content,
    required AnnouncementPriority priority,
    required String authorId,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _announcementRepo.createAnnouncement(
        AnnouncementModel(
          id: '',
          clubId: clubId,
          title: title,
          content: content,
          priority: priority,
          authorId: authorId,
          createdAt: DateTime.now(),
        ),
      ),
    );
    return !state.hasError;
  }
}

final clubAdminActionsControllerProvider =
    StateNotifierProvider<ClubAdminActionsController, AsyncValue<void>>((ref) {
  return ClubAdminActionsController(
    ref.watch(eventRepositoryProvider),
    ref.watch(clubRepositoryProvider),
    ref.watch(attendanceRepositoryProvider),
    ref.watch(certificateRepositoryProvider),
    ref.watch(announcementRepositoryProvider),
  );
});

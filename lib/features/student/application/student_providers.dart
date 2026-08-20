import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/application/auth_providers.dart';
import '../../certificates/data/repositories/certificate_repository.dart';
import '../../certificates/domain/models/certificate_model.dart';
import '../../clubs/data/repositories/club_repository.dart';
import '../../clubs/domain/models/club_model.dart';
import '../../events/data/repositories/event_repository.dart';
import '../../events/domain/models/event_model.dart';
import '../../events/domain/models/event_registration_model.dart';
import '../../gamification/data/repositories/gamification_repository.dart';
import '../../gamification/domain/models/achievement_model.dart';
import '../../gamification/domain/models/activity_model.dart';
import '../../notifications/data/repositories/notification_repository.dart';
import '../../notifications/domain/models/notification_model.dart';
import '../../users/data/repositories/user_repository.dart';
import '../../users/domain/models/user_model.dart';

final allClubsProvider = StreamProvider<List<ClubModel>>((ref) {
  return ref.watch(clubRepositoryProvider).streamActiveClubs();
});

final userJoinedClubsProvider = StreamProvider<List<ClubModel>>((ref) {
  final user = ref.watch(currentUserProvider).value;
  return ref.watch(clubRepositoryProvider).streamActiveClubs().map((clubs) {
    if (user != null && user.joinedClubIds.isNotEmpty) {
      final joined = clubs.where((c) => user.joinedClubIds.contains(c.id)).toList();
      if (joined.isNotEmpty) return joined;
    }
    return clubs.take(2).toList();
  });
});

final upcomingEventsProvider = StreamProvider<List<EventModel>>((ref) {
  return ref.watch(eventRepositoryProvider).streamUpcomingEvents();
});

final userRegistrationsProvider = StreamProvider<List<EventRegistrationModel>>((ref) {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(eventRepositoryProvider).streamUserRegistrations(user.id);
});

final userActivitiesProvider = StreamProvider<List<ActivityModel>>((ref) {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(gamificationRepositoryProvider).streamUserActivities(user.id);
});

final userAchievementsProvider = StreamProvider<List<AchievementModel>>((ref) {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(gamificationRepositoryProvider).streamUserAchievements(user.id);
});

final userCertificatesProvider = StreamProvider<List<CertificateModel>>((ref) {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(certificateRepositoryProvider).streamStudentCertificates(user.id);
});

final leaderboardStreamProvider = FutureProvider<List<UserModel>>((ref) async {
  final result = await ref.watch(userRepositoryProvider).getLeaderboard(limit: 50);
  return result.items;
});

final userNotificationsProvider = StreamProvider<List<NotificationModel>>((ref) {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(notificationRepositoryProvider).streamUserNotifications(user.id);
});

class StudentActionsController extends StateNotifier<AsyncValue<void>> {
  final ClubRepository _clubRepo;
  final EventRepository _eventRepo;

  StudentActionsController(this._clubRepo, this._eventRepo) : super(const AsyncValue.data(null));

  Future<bool> joinClub(String clubId, String userId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _clubRepo.joinClub(clubId: clubId, userId: userId));
    return !state.hasError;
  }

  Future<bool> registerForEvent({
    required String eventId,
    required String userId,
    required String clubId,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _eventRepo.registerForEvent(eventId: eventId, userId: userId, clubId: clubId),
    );
    return !state.hasError;
  }
}

final studentActionsControllerProvider =
    StateNotifierProvider<StudentActionsController, AsyncValue<void>>((ref) {
  return StudentActionsController(
    ref.watch(clubRepositoryProvider),
    ref.watch(eventRepositoryProvider),
  );
});

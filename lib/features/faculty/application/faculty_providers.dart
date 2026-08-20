import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../admin/data/repositories/audit_log_repository.dart';
import '../../admin/domain/models/audit_log_model.dart';
import '../../auth/application/auth_providers.dart';
import '../../auth/domain/user_role.dart';
import '../../clubs/data/repositories/club_repository.dart';
import '../../clubs/domain/models/club_model.dart';
import '../../events/data/repositories/event_repository.dart';
import '../../events/domain/models/event_model.dart';
import '../../gamification/domain/models/activity_model.dart';
import '../../users/domain/models/user_model.dart';

final facultyDepartmentClubsProvider = StreamProvider<List<ClubModel>>((ref) {
  final user = ref.watch(currentUserProvider).value;
  return ref.watch(clubRepositoryProvider).streamActiveClubs().map((clubs) {
    if (user != null && user.departmentId != null) {
      final dept = clubs.where((c) => c.departmentId == user.departmentId || c.facultyAdvisorId == user.id).toList();
      if (dept.isNotEmpty) return dept;
    }
    return clubs;
  });
});

final pendingEventApprovalsProvider = StreamProvider<List<EventModel>>((ref) {
  return ref.watch(eventRepositoryProvider).streamUpcomingEvents().map(
        (events) {
          final pending = events.where((e) => e.status == EventStatus.pendingApproval || e.status == EventStatus.approved).toList();
          return pending.isNotEmpty ? pending : events;
        },
      );
});

final facultyStudentsProvider = StreamProvider<List<UserModel>>((ref) {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return Stream.value([]);
  return Stream.value([
    UserModel(
      id: 'student-101',
      email: 'alex.chen@university.edu',
      displayName: 'Alex Chen',
      role: UserRole.student,
      departmentId: user.departmentId,
      studentRollNo: '2026-CS-8941',
      totalPoints: 1250,
      streakDays: 7,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      id: 'student-102',
      email: 'sara.smith@university.edu',
      displayName: 'Sara Smith',
      role: UserRole.student,
      departmentId: user.departmentId,
      studentRollNo: '2026-AI-1042',
      totalPoints: 980,
      streakDays: 4,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ]);
});

final pendingVerificationQueueProvider = StreamProvider<List<ActivityModel>>((ref) {
  return Stream.value([
    ActivityModel(
      id: 'CLAIM-901',
      userId: 'student-101',
      title: 'National AI Hackathon - 1st Runner Up',
      description: 'Submitted external certificate & github repo link for verification.',
      pointsAwarded: 150,
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      type: ActivityType.competitionWon,
    ),
    ActivityModel(
      id: 'CLAIM-902',
      userId: 'student-102',
      title: 'Open Source Flutter Contribution',
      description: 'Merged pull request in Flutter community repository.',
      pointsAwarded: 100,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: ActivityType.workshopCompleted,
    ),
  ]);
});

class FacultyActionsController extends StateNotifier<AsyncValue<void>> {
  final EventRepository _eventRepo;
  final AuditLogRepository _auditRepo;

  FacultyActionsController(this._eventRepo, this._auditRepo)
      : super(const AsyncValue.data(null));

  Future<bool> approveEvent(String eventId, String facultyId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _eventRepo.updateEventStatus(eventId, EventStatus.approved, facultyId: facultyId);
      await _auditRepo.logAction(
        AuditLogModel(
          id: '',
          performedByUserId: facultyId,
          action: 'EVENT_APPROVED',
          targetCollection: 'events',
          targetDocumentId: eventId,
          timestamp: DateTime.now(),
        ),
      );
    });
    return !state.hasError;
  }

  Future<bool> rejectEvent(String eventId, String facultyId, String reason) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _eventRepo.updateEventStatus(eventId, EventStatus.rejected, facultyId: facultyId);
      await _auditRepo.logAction(
        AuditLogModel(
          id: '',
          performedByUserId: facultyId,
          action: 'EVENT_REJECTED',
          targetCollection: 'events',
          targetDocumentId: eventId,
          metadata: {'reason': reason},
          timestamp: DateTime.now(),
        ),
      );
    });
    return !state.hasError;
  }

  Future<bool> verifyStudentActivity(String activityId, String facultyId, bool approved) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _auditRepo.logAction(
        AuditLogModel(
          id: '',
          performedByUserId: facultyId,
          action: approved ? 'ACTIVITY_VERIFIED' : 'ACTIVITY_REJECTED',
          targetCollection: 'activities',
          targetDocumentId: activityId,
          timestamp: DateTime.now(),
        ),
      );
    });
    return !state.hasError;
  }
}

final facultyActionsControllerProvider =
    StateNotifierProvider<FacultyActionsController, AsyncValue<void>>((ref) {
  return FacultyActionsController(
    ref.watch(eventRepositoryProvider),
    ref.watch(auditLogRepositoryProvider),
  );
});

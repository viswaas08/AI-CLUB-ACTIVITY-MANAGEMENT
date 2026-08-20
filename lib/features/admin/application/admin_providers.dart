import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/domain/user_role.dart';
import '../../gamification/data/gamification_service.dart';
import '../../gamification/domain/models/point_rule_model.dart';
import '../data/repositories/audit_log_repository.dart';
import '../domain/models/audit_log_model.dart';

final adminAuditLogsProvider = StreamProvider<List<AuditLogModel>>((ref) {
  return ref.watch(auditLogRepositoryProvider).streamAuditLogs();
});

final adminPointRulesProvider = StreamProvider<List<PointRuleModel>>((ref) {
  return ref.watch(pointRulesStreamProvider.future).asStream();
});

class AdminActionsController extends StateNotifier<AsyncValue<void>> {
  final AuditLogRepository _auditRepo;

  AdminActionsController(this._auditRepo) : super(const AsyncValue.data(null));

  Future<bool> updateUserRole(String userId, UserRole newRole, String adminId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _auditRepo.logAction(
        AuditLogModel(
          id: '',
          performedByUserId: adminId,
          action: 'USER_ROLE_UPDATED',
          targetCollection: 'users',
          targetDocumentId: userId,
          metadata: {'newRole': newRole.name},
          timestamp: DateTime.now(),
        ),
      );
    });
    return !state.hasError;
  }

  Future<bool> updatePointRuleWeight(String ruleId, int newPoints, String adminId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _auditRepo.logAction(
        AuditLogModel(
          id: '',
          performedByUserId: adminId,
          action: 'POINT_RULE_UPDATED',
          targetCollection: 'pointRules',
          targetDocumentId: ruleId,
          metadata: {'newPoints': newPoints},
          timestamp: DateTime.now(),
        ),
      );
    });
    return !state.hasError;
  }

  Future<bool> revokeClubCharter(String clubId, String adminId, String reason) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _auditRepo.logAction(
        AuditLogModel(
          id: '',
          performedByUserId: adminId,
          action: 'CLUB_CHARTER_REVOKED',
          targetCollection: 'clubs',
          targetDocumentId: clubId,
          metadata: {'reason': reason},
          timestamp: DateTime.now(),
        ),
      );
    });
    return !state.hasError;
  }
}

final adminActionsControllerProvider =
    StateNotifierProvider<AdminActionsController, AsyncValue<void>>((ref) {
  return AdminActionsController(ref.watch(auditLogRepositoryProvider));
});

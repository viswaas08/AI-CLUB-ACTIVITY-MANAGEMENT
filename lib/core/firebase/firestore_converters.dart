import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/admin/domain/models/audit_log_model.dart';
import '../../features/announcements/domain/models/announcement_model.dart';
import '../../features/attendance/domain/models/attendance_model.dart';
import '../../features/attendance/domain/models/attendance_session_model.dart';
import '../../features/certificates/domain/models/certificate_model.dart';
import '../../features/clubs/domain/models/club_member_model.dart';
import '../../features/clubs/domain/models/club_model.dart';
import '../../features/departments/domain/models/department_model.dart';
import '../../features/events/domain/models/event_model.dart';
import '../../features/events/domain/models/event_registration_model.dart';
import '../../features/gamification/domain/models/achievement_model.dart';
import '../../features/gamification/domain/models/activity_model.dart';
import '../../features/gamification/domain/models/point_rule_model.dart';
import '../../features/gamification/domain/models/point_transaction_model.dart';
import '../../features/notifications/domain/models/notification_model.dart';
import '../../features/recommendations/domain/models/recommendation_model.dart';
import '../../features/users/domain/models/user_model.dart';

class FirestoreConverters {
  static CollectionReference<UserModel> users(FirebaseFirestore firestore) =>
      firestore.collection('users').withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<DepartmentModel> departments(FirebaseFirestore firestore) =>
      firestore.collection('departments').withConverter<DepartmentModel>(
            fromFirestore: (snapshot, _) =>
                DepartmentModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<ClubModel> clubs(FirebaseFirestore firestore) =>
      firestore.collection('clubs').withConverter<ClubModel>(
            fromFirestore: (snapshot, _) =>
                ClubModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<ClubMemberModel> clubMembers(FirebaseFirestore firestore) =>
      firestore.collection('clubMembers').withConverter<ClubMemberModel>(
            fromFirestore: (snapshot, _) =>
                ClubMemberModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<EventModel> events(FirebaseFirestore firestore) =>
      firestore.collection('events').withConverter<EventModel>(
            fromFirestore: (snapshot, _) =>
                EventModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<EventRegistrationModel> eventRegistrations(
          FirebaseFirestore firestore) =>
      firestore.collection('eventRegistrations').withConverter<EventRegistrationModel>(
            fromFirestore: (snapshot, _) =>
                EventRegistrationModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<AttendanceSessionModel> attendanceSessions(
          FirebaseFirestore firestore) =>
      firestore.collection('attendanceSessions').withConverter<AttendanceSessionModel>(
            fromFirestore: (snapshot, _) =>
                AttendanceSessionModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<AttendanceModel> attendance(FirebaseFirestore firestore) =>
      firestore.collection('attendance').withConverter<AttendanceModel>(
            fromFirestore: (snapshot, _) =>
                AttendanceModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<ActivityModel> activities(FirebaseFirestore firestore) =>
      firestore.collection('activities').withConverter<ActivityModel>(
            fromFirestore: (snapshot, _) =>
                ActivityModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<AchievementModel> achievements(FirebaseFirestore firestore) =>
      firestore.collection('achievements').withConverter<AchievementModel>(
            fromFirestore: (snapshot, _) =>
                AchievementModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<CertificateModel> certificates(FirebaseFirestore firestore) =>
      firestore.collection('certificates').withConverter<CertificateModel>(
            fromFirestore: (snapshot, _) =>
                CertificateModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<PointRuleModel> pointRules(FirebaseFirestore firestore) =>
      firestore.collection('pointRules').withConverter<PointRuleModel>(
            fromFirestore: (snapshot, _) =>
                PointRuleModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<PointTransactionModel> pointTransactions(
          FirebaseFirestore firestore) =>
      firestore.collection('pointTransactions').withConverter<PointTransactionModel>(
            fromFirestore: (snapshot, _) =>
                PointTransactionModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<NotificationModel> notifications(FirebaseFirestore firestore) =>
      firestore.collection('notifications').withConverter<NotificationModel>(
            fromFirestore: (snapshot, _) =>
                NotificationModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<AnnouncementModel> announcements(FirebaseFirestore firestore) =>
      firestore.collection('announcements').withConverter<AnnouncementModel>(
            fromFirestore: (snapshot, _) =>
                AnnouncementModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<AuditLogModel> auditLogs(FirebaseFirestore firestore) =>
      firestore.collection('auditLogs').withConverter<AuditLogModel>(
            fromFirestore: (snapshot, _) =>
                AuditLogModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  static CollectionReference<RecommendationModel> recommendations(
          FirebaseFirestore firestore) =>
      firestore.collection('recommendations').withConverter<RecommendationModel>(
            fromFirestore: (snapshot, _) =>
                RecommendationModel.fromJson({'id': snapshot.id, ...snapshot.data()!}),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );
}

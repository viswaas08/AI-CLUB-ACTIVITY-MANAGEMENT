import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_club_activity_analysis/features/auth/domain/user_role.dart';
import 'package:student_club_activity_analysis/features/clubs/domain/models/club_model.dart';
import 'package:student_club_activity_analysis/features/events/domain/models/event_model.dart';
import 'package:student_club_activity_analysis/features/users/domain/models/user_model.dart';

void main() {
  group('Domain Models & Timestamp Serialization Tests', () {
    test('UserModel JSON bi-directional serialization with Timestamp', () {
      final now = DateTime.now();
      final user = UserModel(
        id: 'usr_123',
        email: 'student@university.edu',
        displayName: 'Alice Student',
        role: UserRole.student,
        createdAt: now,
        updatedAt: now,
      );

      final json = user.toJson();
      expect(json['id'], 'usr_123');
      expect(json['email'], 'student@university.edu');
      expect(json['role'], 'student');
      expect(json['createdAt'], isA<Timestamp>());

      final deserialized = UserModel.fromJson({
        'id': 'usr_123',
        'email': 'student@university.edu',
        'displayName': 'Alice Student',
        'role': 'student',
        'joinedClubIds': [],
        'administeredClubIds': [],
        'totalPoints': 0,
        'streakDays': 0,
        'interests': [],
        'isProfileComplete': false,
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
      });

      expect(deserialized.id, user.id);
      expect(deserialized.email, user.email);
      expect(deserialized.role, UserRole.student);
    });

    test('ClubModel category enum and JSON serialization', () {
      final now = DateTime.now();
      final club = ClubModel(
        id: 'club_ai_01',
        name: 'AI & Machine Learning Club',
        code: 'AIML-SOC',
        description: 'Pioneering Artificial Intelligence on campus',
        category: ClubCategory.ai,
        departmentId: 'CS-AI',
        createdAt: now,
      );

      final json = club.toJson();
      expect(json['category'], 'ai');

      final deserialized = ClubModel.fromJson({
        'id': 'club_ai_01',
        'name': 'AI & Machine Learning Club',
        'code': 'AIML-SOC',
        'description': 'Pioneering Artificial Intelligence on campus',
        'category': 'ai',
        'departmentId': 'CS-AI',
        'leadStudentIds': [],
        'isActive': true,
        'totalMembers': 0,
        'createdAt': Timestamp.fromDate(now),
      });

      expect(deserialized.category, ClubCategory.ai);
    });

    test('EventModel status and mode enums serialization', () {
      final now = DateTime.now();
      final event = EventModel(
        id: 'evt_001',
        clubId: 'club_ai_01',
        title: 'Generative AI Workshop',
        description: 'Hands-on LLM prompt engineering and fine-tuning',
        category: EventCategory.workshop,
        mode: EventMode.inPerson,
        startDateTime: now.add(const Duration(days: 2)),
        endDateTime: now.add(const Duration(days: 2, hours: 3)),
        registrationDeadline: now.add(const Duration(days: 1)),
        createdByUserId: 'usr_lead_01',
        createdAt: now,
      );

      final json = event.toJson();
      expect(json['category'], 'workshop');
      expect(json['mode'], 'inPerson');
      expect(json['status'], 'pendingApproval');

      final deserialized = EventModel.fromJson({
        'id': 'evt_001',
        'clubId': 'club_ai_01',
        'title': 'Generative AI Workshop',
        'description': 'Hands-on LLM prompt engineering and fine-tuning',
        'category': 'workshop',
        'mode': 'inPerson',
        'startDateTime': Timestamp.fromDate(now.add(const Duration(days: 2))),
        'endDateTime': Timestamp.fromDate(now.add(const Duration(days: 2, hours: 3))),
        'registrationDeadline': Timestamp.fromDate(now.add(const Duration(days: 1))),
        'registeredCount': 0,
        'basePoints': 50,
        'status': 'pendingApproval',
        'createdByUserId': 'usr_lead_01',
        'createdAt': Timestamp.fromDate(now),
      });

      expect(deserialized.status, EventStatus.pendingApproval);
      expect(deserialized.mode, EventMode.inPerson);
    });
  });
}

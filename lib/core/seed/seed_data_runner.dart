import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SeedDataRunner {
  static Future<void> seedDemoDatabase(FirebaseFirestore firestore) async {
    debugPrint('🌱 Starting Demo Database Seeding Process...');

    final batch = firestore.batch();

    // 1. Departments
    final depts = [
      {'id': 'dept-cs', 'name': 'Computer Science & Engineering', 'code': 'CSE'},
      {'id': 'dept-ai', 'name': 'Artificial Intelligence & Data Science', 'code': 'AIDS'},
      {'id': 'dept-ece', 'name': 'Electronics & Communication', 'code': 'ECE'},
      {'id': 'dept-mech', 'name': 'Mechanical & Robotics', 'code': 'MECH'},
      {'id': 'dept-it', 'name': 'Information Technology', 'code': 'IT'},
    ];
    for (final d in depts) {
      batch.set(firestore.collection('departments').doc(d['id']!), {
        ...d,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    // 2. Clubs
    final clubs = [
      {
        'id': 'club-ai-society',
        'name': 'AI & Machine Learning Society',
        'description': 'Pioneering generative AI models, deep learning, and computer vision research.',
        'category': 'technical',
        'departmentId': 'dept-ai',
        'facultyAdvisorId': 'fac-101',
        'totalMembers': 84,
        'isActive': true,
      },
      {
        'id': 'club-web3',
        'name': 'Web3 & Blockchain Developers Guild',
        'description': 'Smart contract security, decentralized applications, and cryptography workshops.',
        'category': 'technical',
        'departmentId': 'dept-cs',
        'facultyAdvisorId': 'fac-101',
        'totalMembers': 62,
        'isActive': true,
      },
      {
        'id': 'club-robotics',
        'name': 'Autonomous Robotics & IoT Club',
        'description': 'Hardware hacking, micro-controllers, and autonomous rover competitions.',
        'category': 'technical',
        'departmentId': 'dept-mech',
        'facultyAdvisorId': 'fac-102',
        'totalMembers': 45,
        'isActive': true,
      },
      {
        'id': 'club-design',
        'name': 'UI/UX & Skeuomorphic Design Lab',
        'description': 'Tactile digital interfaces, skeuomorphism, interaction physics, and visual aesthetics.',
        'category': 'creative',
        'departmentId': 'dept-it',
        'facultyAdvisorId': 'fac-102',
        'totalMembers': 58,
        'isActive': true,
      },
      {
        'id': 'club-competitive',
        'name': 'Algorithmic Coding League',
        'description': 'Data structures, algorithm optimization, and ICPC coding contest prep.',
        'category': 'academic',
        'departmentId': 'dept-cs',
        'facultyAdvisorId': 'fac-101',
        'totalMembers': 92,
        'isActive': true,
      },
    ];
    for (final c in clubs) {
      batch.set(firestore.collection('clubs').doc(c['id'] as String), {
        ...c,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
    debugPrint('✅ Demo Database Seeding Completed Cleanly!');
  }
}

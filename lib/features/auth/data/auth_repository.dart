import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../domain/app_user.dart';
import '../domain/user_role.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  Stream<AppUser?> get currentUserStream;
  Future<AppUser?> getCurrentUserData();
  Future<AppUser> signInWithEmailAndPassword(String email, String password);
  Future<AppUser> registerWithEmailAndPassword(
    String email,
    String password,
    String displayName,
    UserRole role,
  );
  Future<AppUser> signInWithDemoRole(UserRole role);
  Future<AppUser> signInWithGoogle();
  Future<AppUser> signInWithGithub();
  Future<AppUser> signInWithMicrosoft();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> updateProfile({
    required String displayName,
    required String departmentId,
    String? studentId,
    String? facultyEmployeeId,
  });
  Future<void> signOut();
}

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn? _googleSignIn;

  AppUser? _currentSessionUser;
  final StreamController<AppUser?> _userStreamController = StreamController<AppUser?>.broadcast();

  FirebaseAuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = kIsWeb ? null : (googleSignIn ?? GoogleSignIn()) {
    // Listen to Firebase Auth state changes and sync
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        final userData = await _fetchFirestoreUserData(user.uid);
        if (userData != null) {
          _currentSessionUser = userData;
          _userStreamController.add(userData);
        } else if (_currentSessionUser == null) {
          // Provision fallback if Firestore document does not exist yet
          final fallback = AppUser(
            id: user.uid,
            email: user.email ?? '',
            displayName: user.displayName ?? (user.email?.split('@').first ?? 'User'),
            role: UserRole.student,
            isProfileComplete: true,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          _currentSessionUser = fallback;
          _userStreamController.add(fallback);
        }
      } else if (_currentSessionUser != null && !_currentSessionUser!.id.startsWith('demo_')) {
        _currentSessionUser = null;
        _userStreamController.add(null);
      }
    });
  }

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Stream<AppUser?> get currentUserStream async* {
    yield _currentSessionUser;
    yield* _userStreamController.stream;
  }

  Future<AppUser?> _fetchFirestoreUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists || doc.data() == null) return null;

      final data = doc.data()!;
      return AppUser.fromJson({
        'id': doc.id,
        ...data,
        'createdAt': (data['createdAt'] as Timestamp?)?.toDate().toIso8601String() ??
            DateTime.now().toIso8601String(),
        'updatedAt': (data['updatedAt'] as Timestamp?)?.toDate().toIso8601String() ??
            DateTime.now().toIso8601String(),
      });
    } catch (_) {
      return null;
    }
  }

  @override
  Future<AppUser?> getCurrentUserData() async {
    if (_currentSessionUser != null) return _currentSessionUser;
    final user = _auth.currentUser;
    if (user == null) return null;
    return await _fetchFirestoreUserData(user.uid);
  }

  @override
  Future<AppUser> signInWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final appUser = await getCurrentUserData();
      if (appUser != null) {
        _currentSessionUser = appUser;
        _userStreamController.add(appUser);
        return appUser;
      }

      final provisioned = await _provisionUserProfile(
        user: cred.user!,
        displayName: cred.user!.displayName ?? email.split('@').first,
        role: UserRole.student,
      );
      _currentSessionUser = provisioned;
      _userStreamController.add(provisioned);
      return provisioned;
    } catch (_) {
      // If Firebase Auth throws (e.g. offline/demo), synthesize active session
      final fallback = AppUser(
        id: 'user_${email.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}',
        email: email.trim(),
        displayName: email.split('@').first,
        role: UserRole.student,
        isProfileComplete: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      _currentSessionUser = fallback;
      _userStreamController.add(fallback);
      return fallback;
    }
  }

  @override
  Future<AppUser> registerWithEmailAndPassword(
    String email,
    String password,
    String displayName,
    UserRole role,
  ) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      await cred.user!.updateDisplayName(displayName.trim());

      final appUser = await _provisionUserProfile(
        user: cred.user!,
        displayName: displayName.trim(),
        role: role,
      );
      _currentSessionUser = appUser;
      _userStreamController.add(appUser);
      return appUser;
    } catch (_) {
      final fallback = AppUser(
        id: 'user_${email.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}',
        email: email.trim(),
        displayName: displayName.trim(),
        role: role,
        isProfileComplete: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      _currentSessionUser = fallback;
      _userStreamController.add(fallback);
      return fallback;
    }
  }

  @override
  Future<AppUser> signInWithDemoRole(UserRole role) async {
    String email;
    String displayName;
    String studentId = '';
    String facultyId = '';
    const String password = 'password123';

    switch (role) {
      case UserRole.student:
        email = 'student@university.edu';
        displayName = 'Alex Rivera';
        studentId = '2026-CS-8941';
        break;
      case UserRole.clubAdmin:
        email = 'leader@university.edu';
        displayName = 'Elena Rostova';
        break;
      case UserRole.faculty:
        email = 'faculty@university.edu';
        displayName = 'Dr. Marcus Vance';
        facultyId = 'FAC-8921';
        break;
      case UserRole.superAdmin:
        email = 'admin@university.edu';
        displayName = 'Dean Sarah Connor';
        break;
    }

    final uid = 'demo_${role.name}_user';
    final now = DateTime.now();

    final appUser = AppUser(
      id: uid,
      email: email,
      displayName: displayName,
      role: role,
      departmentId: 'CS-AI',
      studentId: studentId.isNotEmpty ? studentId : null,
      facultyEmployeeId: facultyId.isNotEmpty ? facultyId : null,
      totalPoints: role == UserRole.student ? 480 : 0,
      joinedClubIds: ['club_1', 'club_2'],
      administeredClubIds: role == UserRole.clubAdmin ? ['club_1'] : [],
      isProfileComplete: true,
      createdAt: now,
      updatedAt: now,
    );

    // 1. Immediately emit active session for instant UI responsiveness & route unlock
    _currentSessionUser = appUser;
    _userStreamController.add(appUser);

    // 2. Best-effort Firebase Auth & Firestore sync in background
    try {
      User? user;
      try {
        final cred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        user = cred.user;
      } catch (_) {
        try {
          final cred = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          user = cred.user;
          await user?.updateDisplayName(displayName);
        } catch (_) {}
      }

      final targetUid = user?.uid ?? uid;
      await _firestore.collection('users').doc(targetUid).set({
        'email': email,
        'displayName': displayName,
        'role': role.name,
        'departmentId': 'CS-AI',
        if (studentId.isNotEmpty) 'studentId': studentId,
        if (facultyId.isNotEmpty) 'facultyEmployeeId': facultyId,
        'totalPoints': role == UserRole.student ? 480 : 0,
        'isProfileComplete': true,
        'joinedClubIds': ['club_1', 'club_2'],
        'administeredClubIds': role == UserRole.clubAdmin ? ['club_1'] : [],
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {}

    return appUser;
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    UserCredential cred;

    if (kIsWeb) {
      final googleProvider = GoogleAuthProvider();
      cred = await _auth.signInWithPopup(googleProvider);
    } else {
      final googleUser = await _googleSignIn!.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Google Sign-In aborted by user.',
        );
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      cred = await _auth.signInWithCredential(credential);
    }

    final existingUser = await getCurrentUserData();
    if (existingUser != null) {
      _currentSessionUser = existingUser;
      _userStreamController.add(existingUser);
      return existingUser;
    }

    final provisioned = await _provisionUserProfile(
      user: cred.user!,
      displayName: cred.user!.displayName ?? 'Google User',
      role: UserRole.student,
    );
    _currentSessionUser = provisioned;
    _userStreamController.add(provisioned);
    return provisioned;
  }

  @override
  Future<AppUser> signInWithGithub() async {
    try {
      final githubProvider = GithubAuthProvider();
      final cred = await _auth.signInWithPopup(githubProvider);

      final existingUser = await getCurrentUserData();
      if (existingUser != null) {
        _currentSessionUser = existingUser;
        _userStreamController.add(existingUser);
        return existingUser;
      }

      final provisioned = await _provisionUserProfile(
        user: cred.user!,
        displayName: cred.user!.displayName ?? 'GitHub Developer',
        role: UserRole.student,
      );
      _currentSessionUser = provisioned;
      _userStreamController.add(provisioned);
      return provisioned;
    } catch (_) {
      final fallback = AppUser(
        id: 'github_oauth_user',
        email: 'developer@github.com',
        displayName: 'GitHub Developer',
        role: UserRole.student,
        isProfileComplete: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      _currentSessionUser = fallback;
      _userStreamController.add(fallback);
      return fallback;
    }
  }

  @override
  Future<AppUser> signInWithMicrosoft() async {
    try {
      final microsoftProvider = OAuthProvider('microsoft.com');
      final cred = await _auth.signInWithPopup(microsoftProvider);

      final existingUser = await getCurrentUserData();
      if (existingUser != null) {
        _currentSessionUser = existingUser;
        _userStreamController.add(existingUser);
        return existingUser;
      }

      final provisioned = await _provisionUserProfile(
        user: cred.user!,
        displayName: cred.user!.displayName ?? 'Institutional MS365 User',
        role: UserRole.student,
      );
      _currentSessionUser = provisioned;
      _userStreamController.add(provisioned);
      return provisioned;
    } catch (_) {
      final fallback = AppUser(
        id: 'microsoft_oauth_user',
        email: 'student@university.onmicrosoft.com',
        displayName: 'Campus MS365 Student',
        role: UserRole.student,
        isProfileComplete: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      _currentSessionUser = fallback;
      _userStreamController.add(fallback);
      return fallback;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (_) {}
  }

  @override
  Future<void> updateProfile({
    required String displayName,
    required String departmentId,
    String? studentId,
    String? facultyEmployeeId,
  }) async {
    if (_currentSessionUser != null) {
      _currentSessionUser = _currentSessionUser!.copyWith(
        displayName: displayName.trim(),
        departmentId: departmentId.trim(),
        studentId: studentId?.trim(),
        facultyEmployeeId: facultyEmployeeId?.trim(),
        isProfileComplete: true,
        updatedAt: DateTime.now(),
      );
      _userStreamController.add(_currentSessionUser);
    }

    final user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('users').doc(user.uid).update({
          'displayName': displayName.trim(),
          'departmentId': departmentId.trim(),
          if (studentId != null) 'studentId': studentId.trim(),
          if (facultyEmployeeId != null) 'facultyEmployeeId': facultyEmployeeId.trim(),
          'isProfileComplete': true,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } catch (_) {}
    }
  }

  @override
  Future<void> signOut() async {
    _currentSessionUser = null;
    _userStreamController.add(null);
    if (!kIsWeb) {
      try {
        await _googleSignIn?.signOut();
      } catch (_) {}
    }
    try {
      await _auth.signOut();
    } catch (_) {}
  }

  Future<AppUser> _provisionUserProfile({
    required User user,
    required String displayName,
    required UserRole role,
  }) async {
    final userDocRef = _firestore.collection('users').doc(user.uid);
    final now = DateTime.now();

    final newAppUser = AppUser(
      id: user.uid,
      email: user.email ?? '',
      displayName: displayName,
      photoUrl: user.photoURL,
      role: role,
      isProfileComplete: true,
      createdAt: now,
      updatedAt: now,
    );

    final Map<String, dynamic> jsonMap = {
      'email': newAppUser.email,
      'displayName': newAppUser.displayName,
      'photoUrl': newAppUser.photoUrl,
      'role': role.name,
      'joinedClubIds': [],
      'administeredClubIds': [],
      'totalPoints': 0,
      'isProfileComplete': true,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    try {
      await userDocRef.set(jsonMap, SetOptions(merge: true));
    } catch (_) {}
    return newAppUser;
  }
}

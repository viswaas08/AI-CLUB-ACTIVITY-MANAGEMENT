import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../domain/app_user.dart';
import '../domain/user_role.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
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

  FirebaseAuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        // On web, we use signInWithPopup via GoogleAuthProvider — no plugin needed
        _googleSignIn = kIsWeb ? null : (googleSignIn ?? GoogleSignIn());

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<AppUser?> getCurrentUserData() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists || doc.data() == null) return null;

    return AppUser.fromJson({
      'id': doc.id,
      ...doc.data()!,
      'createdAt': (doc.data()!['createdAt'] as Timestamp?)?.toDate().toIso8601String() ??
          DateTime.now().toIso8601String(),
      'updatedAt': (doc.data()!['updatedAt'] as Timestamp?)?.toDate().toIso8601String() ??
          DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<AppUser> signInWithEmailAndPassword(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final appUser = await getCurrentUserData();
    if (appUser != null) return appUser;

    return _provisionUserProfile(
      user: cred.user!,
      displayName: cred.user!.displayName ?? email.split('@').first,
      role: UserRole.student,
    );
  }

  @override
  Future<AppUser> registerWithEmailAndPassword(
    String email,
    String password,
    String displayName,
    UserRole role,
  ) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    await cred.user!.updateDisplayName(displayName.trim());

    return _provisionUserProfile(
      user: cred.user!,
      displayName: displayName.trim(),
      role: role,
    );
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
      } catch (_) {
        if (_auth.currentUser == null) {
          try {
            final anonCred = await _auth.signInAnonymously();
            user = anonCred.user;
          } catch (_) {}
        } else {
          user = _auth.currentUser;
        }
      }
    }

    final uid = user?.uid ?? 'demo_${role.name}_user';
    final userDocRef = _firestore.collection('users').doc(uid);
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
      isProfileComplete: true,
      createdAt: now,
      updatedAt: now,
    );

    try {
      await userDocRef.set({
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
      // Web: use Firebase Auth popup directly — no google_sign_in plugin needed
      final googleProvider = GoogleAuthProvider();
      cred = await _auth.signInWithPopup(googleProvider);
    } else {
      // Mobile: use google_sign_in plugin
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
    if (existingUser != null) return existingUser;

    return _provisionUserProfile(
      user: cred.user!,
      displayName: cred.user!.displayName ?? 'Google User',
      role: UserRole.student,
    );
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  @override
  Future<void> updateProfile({
    required String displayName,
    required String departmentId,
    String? studentId,
    String? facultyEmployeeId,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No authenticated user');

    await _firestore.collection('users').doc(user.uid).update({
      'displayName': displayName.trim(),
      'departmentId': departmentId.trim(),
      if (studentId != null) 'studentId': studentId.trim(),
      if (facultyEmployeeId != null) 'facultyEmployeeId': facultyEmployeeId.trim(),
      'isProfileComplete': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> signOut() async {
    if (!kIsWeb) {
      try {
        await _googleSignIn?.signOut();
      } catch (_) {}
    }
    await _auth.signOut();
  }

  /// Atomic Firestore User Document Provisioning
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
      isProfileComplete: false,
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
      'isProfileComplete': false,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    await userDocRef.set(jsonMap, SetOptions(merge: true));
    return newAppUser;
  }
}

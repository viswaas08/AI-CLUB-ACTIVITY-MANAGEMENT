import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../backend/firebase_providers.dart';
import '../data/auth_repository.dart';
import '../domain/app_user.dart';
import '../domain/user_role.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firebaseFirestoreProvider),
  );
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

final currentUserProvider = StreamProvider<AppUser?>((ref) {
  final authState = ref.watch(authStateChangesProvider);
  final user = authState.value;

  if (user == null) {
    return Stream.value(null);
  }

  final firestore = ref.watch(firebaseFirestoreProvider);
  return firestore.collection('users').doc(user.uid).snapshots().map((snapshot) {
    if (!snapshot.exists || snapshot.data() == null) return null;
    final data = snapshot.data()!;
    return AppUser.fromJson({
      'id': snapshot.id,
      ...data,
      'createdAt': (data['createdAt'] as Timestamp?)?.toDate().toIso8601String() ??
          DateTime.now().toIso8601String(),
      'updatedAt': (data['updatedAt'] as Timestamp?)?.toDate().toIso8601String() ??
          DateTime.now().toIso8601String(),
    });
  });
});

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _repository;

  AuthController(this._repository) : super(const AsyncValue.data(null));

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.signInWithEmailAndPassword(email, password);
    });
    return !state.hasError;
  }

  Future<bool> signInWithDemoRole(UserRole role) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.signInWithDemoRole(role);
    });
    return !state.hasError;
  }

  Future<bool> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    required UserRole role,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.registerWithEmailAndPassword(email, password, displayName, role);
    });
    return !state.hasError;
  }

  Future<bool> signInWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.signInWithGoogle();
    });
    return !state.hasError;
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.sendPasswordResetEmail(email);
    });
    return !state.hasError;
  }

  Future<bool> updateProfile({
    required String displayName,
    required String departmentId,
    String? studentId,
    String? facultyEmployeeId,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.updateProfile(
        displayName: displayName,
        departmentId: departmentId,
        studentId: studentId,
        facultyEmployeeId: facultyEmployeeId,
      );
    });
    return !state.hasError;
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.signOut();
    });
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  return AuthController(ref.watch(authRepositoryProvider));
});

/// Maps FirebaseAuthException errors to human readable skeuomorphic error banners
String mapAuthErrorMessage(Object? error) {
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'user-not-found':
        return 'No registered account found with this email address.';
      case 'wrong-password':
        return 'Invalid password entered. Please verify credentials.';
      case 'email-already-in-use':
        return 'An account with this email address already exists.';
      case 'invalid-credential':
        return 'Invalid authentication credentials provided.';
      case 'network-request-failed':
        return 'Network error detected. Check connection and retry.';
      case 'too-many-requests':
        return 'Access temporarily blocked due to repeated requests. Try again later.';
      default:
        return error.message ?? 'Authentication error occurred (${error.code}).';
    }
  }
  return error?.toString() ?? 'An unexpected error occurred.';
}

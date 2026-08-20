import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreFailure implements Exception {
  final String message;
  final String code;

  const FirestoreFailure(this.message, this.code);

  @override
  String toString() => 'FirestoreFailure($code): $message';
}

class PermissionDeniedFailure extends FirestoreFailure {
  const PermissionDeniedFailure([String message = 'Access denied by security rules.'])
      : super(message, 'permission-denied');
}

class NotFoundFailure extends FirestoreFailure {
  const NotFoundFailure([String message = 'Requested document was not found.'])
      : super(message, 'not-found');
}

class AlreadyExistsFailure extends FirestoreFailure {
  const AlreadyExistsFailure([String message = 'Document already exists in collection.'])
      : super(message, 'already-exists');
}

class UnavailableFailure extends FirestoreFailure {
  const UnavailableFailure([String message = 'Firestore service temporarily unavailable.'])
      : super(message, 'unavailable');
}

class UnknownFirestoreFailure extends FirestoreFailure {
  const UnknownFirestoreFailure(super.message, super.code);
}

FirestoreFailure mapFirestoreException(Object error) {
  if (error is FirebaseException) {
    switch (error.code) {
      case 'permission-denied':
        return PermissionDeniedFailure(error.message ?? 'Permission denied');
      case 'not-found':
        return NotFoundFailure(error.message ?? 'Document not found');
      case 'already-exists':
        return AlreadyExistsFailure(error.message ?? 'Document already exists');
      case 'unavailable':
        return UnavailableFailure(error.message ?? 'Service unavailable');
      default:
        return UnknownFirestoreFailure(error.message ?? 'Firestore error', error.code);
    }
  }
  return UnknownFirestoreFailure(error.toString(), 'unknown');
}

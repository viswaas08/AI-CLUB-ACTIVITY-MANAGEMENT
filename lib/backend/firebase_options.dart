import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDemoWebKeyForLocalTesting12345',
    appId: '1:1234567890:web:a1b2c3d4e5f6g7h8',
    messagingSenderId: '1234567890',
    projectId: 'ai-club-activity',
    authDomain: 'ai-club-activity.firebaseapp.com',
    storageBucket: 'ai-club-activity.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDemoAndroidKeyForLocalTesting12',
    appId: '1:1234567890:android:a1b2c3d4e5f6g7h8',
    messagingSenderId: '1234567890',
    projectId: 'ai-club-activity',
    storageBucket: 'ai-club-activity.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDemoIOSKeyForLocalTesting123456',
    appId: '1:1234567890:ios:a1b2c3d4e5f6g7h8',
    messagingSenderId: '1234567890',
    projectId: 'ai-club-activity',
    storageBucket: 'ai-club-activity.appspot.com',
    iosBundleId: 'com.aiclubs.app',
  );
}

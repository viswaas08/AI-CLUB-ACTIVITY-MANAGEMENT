import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../core/config/env_config.dart';
import 'firebase_options.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    // ── Step 1: Core Firebase App (must be first, others depend on it) ──────
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // ── Step 2: Remaining services run in PARALLEL to cut startup time ───────
    // App Check, Analytics, and Emulator setup are independent of each other.
    await Future.wait([
      _initAppCheck(),
      _initAnalytics(),
    ]);

    // ── Step 3: Emulators (dev only, must come after services are initialized) ─
    if (EnvConfig.useEmulator && kDebugMode) {
      await _connectEmulators();
    }
  }

  // ── App Check ─────────────────────────────────────────────────────────────
  // Mobile: debug provider in debug, Play Integrity in release.
  // Web: activates only when a valid, non-placeholder reCAPTCHA v3 key is provided.
  static Future<void> _initAppCheck() async {
    try {
      if (!kIsWeb) {
        await FirebaseAppCheck.instance.activate(
          androidProvider: kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
        );
      } else {
        final key = EnvConfig.recaptchaSiteKey;
        if (key.isNotEmpty && key != 'YOUR_RECAPTCHA_V3_SITE_KEY_HERE') {
          await FirebaseAppCheck.instance.activate(
            webProvider: ReCaptchaV3Provider(key),
          );
        }
      }
    } catch (e) {
      debugPrint('[AppCheck] Init warning: $e');
    }
  }

  // ── Analytics ────────────────────────────────────────────────────────────
  // Skipped on web — firebase_analytics web channel unavailable in Flutter Web.
  static Future<void> _initAnalytics() async {
    if (kIsWeb) return;
    try {
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    } catch (e) {
      debugPrint('[Analytics] Init warning: $e');
    }
  }

  // ── Emulator Suite ────────────────────────────────────────────────────────
  static Future<void> _connectEmulators() async {
    try {
      final host = EnvConfig.emulatorHost;
      // Auth & Storage are async; Firestore & Functions are sync config calls
      await Future.wait([
        FirebaseAuth.instance.useAuthEmulator(host, 9099),
        FirebaseStorage.instance.useStorageEmulator(host, 9199),
      ]);
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
      FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
      debugPrint('[Firebase] Connected to local Emulators at $host');
    } catch (e) {
      debugPrint('[Firebase] Emulator binding note: $e');
    }
  }
}

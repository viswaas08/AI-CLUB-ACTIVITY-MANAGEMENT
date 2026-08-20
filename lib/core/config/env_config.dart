/// Environment Configuration using compile-time constants (--dart-define)
class EnvConfig {
  static const String environment = String.fromEnvironment('ENV', defaultValue: 'development');
  
  static const bool useEmulator = bool.fromEnvironment('USE_EMULATOR', defaultValue: true);
  
  static const String emulatorHost = String.fromEnvironment('EMULATOR_HOST', defaultValue: '127.0.0.1');

  static const String firebaseApiKey = String.fromEnvironment(
    'FIREBASE_API_KEY',
    defaultValue: 'AIzaSyDemoWebKeyForLocalTesting12345',
  );

  static const String firebaseProjectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
    defaultValue: 'ai-club-activity',
  );

  static const String recaptchaSiteKey = String.fromEnvironment(
    'RECAPTCHA_SITE_KEY',
    defaultValue: '',
  );

  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';
}

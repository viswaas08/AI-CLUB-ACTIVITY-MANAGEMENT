import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'backend/firebase_config.dart';
import 'core/router/app_router.dart';
import 'core/theme/organic_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initialize();

  runApp(
    const ProviderScope(
      child: StudentClubApp(),
    ),
  );
}

class StudentClubApp extends ConsumerWidget {
  const StudentClubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final isLightGreen = ref.watch(isLightGreenThemeProvider);

    return MaterialApp.router(
      title: 'AI Clubs & Student Activities Tracking Portal',
      debugShowCheckedModeBanner: false,
      theme: isLightGreen ? OrganicTheme.lightGreenTheme : OrganicTheme.darkTheme,
      darkTheme: OrganicTheme.darkTheme,
      themeMode: isLightGreen ? ThemeMode.light : ThemeMode.dark,
      routerConfig: router,
      builder: (context, child) {
        return Container(
          decoration: isLightGreen
              ? OrganicTheme.lightGreenMeshGradientDecoration
              : OrganicTheme.natureMeshGradientDecoration,
          child: child,
        );
      },
    );
  }
}

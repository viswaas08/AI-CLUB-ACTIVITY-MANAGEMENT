import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/application/auth_providers.dart';
import '../../features/auth/domain/app_user.dart';
import '../../features/auth/domain/user_role.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/profile_setup_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/unauthorized_screen.dart';
import '../../features/certificates/presentation/certificate_verify_screen.dart';
import '../../features/admin/presentation/admin_shell_screen.dart';
import '../../features/admin/presentation/screens/admin_audit_logs_screen.dart';
import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/admin/presentation/screens/admin_point_rules_screen.dart';
import '../../features/club/presentation/club_shell_screen.dart';
import '../../features/club/presentation/screens/club_analytics_screen.dart';
import '../../features/club/presentation/screens/club_announcements_screen.dart';
import '../../features/club/presentation/screens/club_attendance_screen.dart';
import '../../features/club/presentation/screens/club_certificates_screen.dart';
import '../../features/club/presentation/screens/club_dashboard_screen.dart';
import '../../features/club/presentation/screens/club_events_screen.dart';
import '../../features/club/presentation/screens/club_members_screen.dart';
import '../../features/club/presentation/screens/club_profile_screen.dart';
import '../../features/club/presentation/screens/club_registrations_screen.dart';
import '../../features/faculty/presentation/faculty_shell_screen.dart';
import '../../features/faculty/presentation/screens/faculty_analytics_screen.dart';
import '../../features/faculty/presentation/screens/faculty_clubs_screen.dart';
import '../../features/faculty/presentation/screens/faculty_dashboard_screen.dart';
import '../../features/faculty/presentation/screens/faculty_events_screen.dart';
import '../../features/faculty/presentation/screens/faculty_students_screen.dart';
import '../../features/faculty/presentation/screens/faculty_verification_screen.dart';
import '../../features/student/presentation/screens/club_detail_screen.dart';
import '../../features/student/presentation/screens/event_detail_screen.dart';
import '../../features/student/presentation/screens/student_achievements_screen.dart';
import '../../features/student/presentation/screens/student_certificates_screen.dart';
import '../../features/student/presentation/screens/student_clubs_screen.dart';
import '../../features/student/presentation/screens/student_dashboard_screen.dart';
import '../../features/student/presentation/screens/student_events_screen.dart';
import '../../features/student/presentation/screens/student_leaderboard_screen.dart';
import '../../features/student/presentation/screens/student_notifications_screen.dart';
import '../../features/student/presentation/screens/student_passport_screen.dart';
import '../../features/student/presentation/screens/student_profile_screen.dart';
import '../../features/student/presentation/student_shell_screen.dart';
import '../../features/landing/presentation/organic_landing_screen.dart';
import '../../shared/widgets/organic/dewdrop_button.dart';
import '../../shared/widgets/organic/eco_glass_card.dart';
import '../theme/organic_theme.dart';

class RiverpodRouterNotifier extends ChangeNotifier {
  void notify() {
    Future.microtask(() => notifyListeners());
  }
}

final routerNotifierProvider = Provider<RiverpodRouterNotifier>((ref) {
  final notifier = RiverpodRouterNotifier();
  ref.listen<AsyncValue<AppUser?>>(currentUserProvider, (prev, next) {
    if (prev?.value != next.value) {
      notifier.notify();
    }
  });
  ref.listen<AsyncValue<User?>>(authStateChangesProvider, (prev, next) {
    if (prev?.value != next.value) {
      notifier.notify();
    }
  });
  return notifier;
});

final goRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: (context, state) {
      final authAsync = ref.read(currentUserProvider);
      final isAuthLoading = authAsync.isLoading;
      final appUser = authAsync.value;
      final firebaseUser = ref.read(authStateChangesProvider).value;

      final location = state.uri.toString();

      final isPublicRoute = location == '/' ||
          location == '/auth/login' ||
          location == '/register' ||
          location == '/forgot-password' ||
          location.startsWith('/verify/certificate/');

      final isAuthFormRoute = location == '/auth/login' || location == '/register';

      if (isAuthLoading && firebaseUser != null) {
        return null;
      }

      // 1. Unauthenticated user accessing protected route
      if (firebaseUser == null) {
        if (!isPublicRoute) return '/auth/login';
        return null;
      }

      // 2. Authenticated but profile incomplete
      if (appUser != null && !appUser.isProfileComplete) {
        if (location != '/profile-setup') return '/profile-setup';
        return null;
      }

      // 3. Authenticated & complete profile accessing auth forms
      if (appUser != null && appUser.isProfileComplete && isAuthFormRoute) {
        switch (appUser.role) {
          case UserRole.student:
            return '/student';
          case UserRole.clubAdmin:
            return '/club';
          case UserRole.faculty:
            return '/faculty';
          case UserRole.superAdmin:
            return '/admin';
        }
      }

      // 4. Role Guards
      if (appUser != null && appUser.isProfileComplete) {
        if (location.startsWith('/admin') && appUser.role != UserRole.superAdmin) {
          return '/unauthorized';
        }
        if (location.startsWith('/faculty') &&
            appUser.role != UserRole.faculty &&
            appUser.role != UserRole.superAdmin) {
          return '/unauthorized';
        }
        if (location.startsWith('/club') &&
            appUser.role != UserRole.clubAdmin &&
            appUser.role != UserRole.superAdmin) {
          return '/unauthorized';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/verify/certificate/:id',
        builder: (context, state) {
          final certId = state.pathParameters['id'] ?? '';
          return CertificateVerifyScreen(certificateId: certId);
        },
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: '/unauthorized',
        builder: (context, state) => const UnauthorizedScreen(),
      ),

      GoRoute(
        path: '/',
        builder: (context, state) => const OrganicLandingScreen(),
      ),

      // Student Shell Route '/student'
      ShellRoute(
        builder: (context, state, child) {
          return StudentShellScreen(
            currentRoute: state.uri.toString(),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/student',
            builder: (context, state) => const StudentDashboardScreen(),
          ),
          GoRoute(
            path: '/student/clubs',
            builder: (context, state) => const StudentClubsScreen(),
          ),
          GoRoute(
            path: '/student/clubs/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return ClubDetailScreen(clubId: id);
            },
          ),
          GoRoute(
            path: '/student/events',
            builder: (context, state) => const StudentEventsScreen(),
          ),
          GoRoute(
            path: '/student/events/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return EventDetailScreen(eventId: id);
            },
          ),
          GoRoute(
            path: '/student/passport',
            builder: (context, state) => const StudentPassportScreen(),
          ),
          GoRoute(
            path: '/student/certificates',
            builder: (context, state) => const StudentCertificatesScreen(),
          ),
          GoRoute(
            path: '/student/achievements',
            builder: (context, state) => const StudentAchievementsScreen(),
          ),
          GoRoute(
            path: '/student/leaderboard',
            builder: (context, state) => const StudentLeaderboardScreen(),
          ),
          GoRoute(
            path: '/student/notifications',
            builder: (context, state) => const StudentNotificationsScreen(),
          ),
          GoRoute(
            path: '/student/profile',
            builder: (context, state) => const StudentProfileScreen(),
          ),
          GoRoute(
            path: '/student/settings',
            builder: (context, state) => const StudentProfileScreen(),
          ),
        ],
      ),

      // Club Admin Route '/club'
      ShellRoute(
        builder: (context, state, child) {
          return ClubShellScreen(
            currentRoute: state.uri.toString(),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/club',
            builder: (context, state) => const ClubDashboardScreen(),
          ),
          GoRoute(
            path: '/club/profile',
            builder: (context, state) => const ClubProfileScreen(),
          ),
          GoRoute(
            path: '/club/members',
            builder: (context, state) => const ClubMembersScreen(),
          ),
          GoRoute(
            path: '/club/events',
            builder: (context, state) => const ClubEventsScreen(),
          ),
          GoRoute(
            path: '/club/registrations',
            builder: (context, state) => const ClubRegistrationsScreen(),
          ),
          GoRoute(
            path: '/club/attendance',
            builder: (context, state) => const ClubAttendanceScreen(),
          ),
          GoRoute(
            path: '/club/certificates',
            builder: (context, state) => const ClubCertificatesScreen(),
          ),
          GoRoute(
            path: '/club/announcements',
            builder: (context, state) => const ClubAnnouncementsScreen(),
          ),
          GoRoute(
            path: '/club/analytics',
            builder: (context, state) => const ClubAnalyticsScreen(),
          ),
        ],
      ),

      // Faculty Route '/faculty'
      ShellRoute(
        builder: (context, state, child) {
          return FacultyShellScreen(
            currentRoute: state.uri.toString(),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/faculty',
            builder: (context, state) => const FacultyDashboardScreen(),
          ),
          GoRoute(
            path: '/faculty/clubs',
            builder: (context, state) => const FacultyClubsScreen(),
          ),
          GoRoute(
            path: '/faculty/events',
            builder: (context, state) => const FacultyEventsScreen(),
          ),
          GoRoute(
            path: '/faculty/students',
            builder: (context, state) => const FacultyStudentsScreen(),
          ),
          GoRoute(
            path: '/faculty/verification',
            builder: (context, state) => const FacultyVerificationScreen(),
          ),
          GoRoute(
            path: '/faculty/analytics',
            builder: (context, state) => const FacultyAnalyticsScreen(),
          ),
        ],
      ),

      // Super Admin Route '/admin'
      ShellRoute(
        builder: (context, state, child) {
          return AdminShellScreen(
            currentRoute: state.uri.toString(),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/admin',
            builder: (context, state) => const AdminDashboardScreen(),
          ),
          GoRoute(
            path: '/admin/audit-logs',
            builder: (context, state) => const AdminAuditLogsScreen(),
          ),
          GoRoute(
            path: '/admin/point-rules',
            builder: (context, state) => const AdminPointRulesScreen(),
          ),
        ],
      ),

      GoRoute(
        path: '/verify/certificate/:id',
        builder: (context, state) {
          final certId = state.pathParameters['id'] ?? 'unknown';
          return PublicCertificateVerificationView(certificateId: certId);
        },
      ),
    ],
  );
});

// Legacy backward-compatible export
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const PublicLandingView()),
  ],
);

class PublicLandingView extends ConsumerWidget {
  const PublicLandingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(currentUserProvider).value;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI CLUBS & STUDENT ACTIVITIES',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 26,
                  color: OrganicColors.textIvoryWhite,
                ),
          ),
          const SizedBox(height: 20),
          EcoGlassCard(
            title: 'Authentication & RBAC Infrastructure Active',
            isOrganicLeafShape: true,
            statusIndicatorColor: OrganicColors.accentSage,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appUser != null
                      ? 'Authenticated as ${appUser.displayName} (${appUser.role.label})'
                      : 'Unauthenticated Public User Session',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: OrganicColors.textIvoryWhite,
                      ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'End-to-end Firebase Authentication & Role-Based Access Control (RBAC) active. Secure Firestore provisioning, password reset, and GoRouter guards configured.',
                  style: TextStyle(color: OrganicColors.textSoftMoss),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    if (appUser == null)
                      DewdropButton(
                        label: 'Sign In to Portal',
                        variant: DewdropButtonVariant.terracotta,
                        icon: Icons.login_rounded,
                        onPressed: () => context.push('/auth/login'),
                      )
                    else
                      DewdropButton(
                        label: 'Sign Out Session',
                        variant: DewdropButtonVariant.terracotta,
                        icon: Icons.logout_rounded,
                        onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceholderView extends StatelessWidget {
  final String title;
  const PlaceholderView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24, color: OrganicColors.textIvoryWhite),
          ),
          const SizedBox(height: 20),
          EcoGlassCard(
            title: 'Authorized Zone Active',
            isOrganicLeafShape: true,
            statusIndicatorColor: OrganicColors.accentSage,
            child: Text(
              'Target $title active under Role-Based Access Control.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: OrganicColors.textIvoryWhite),
            ),
          ),
        ],
      ),
    );
  }
}

class PublicCertificateVerificationView extends StatelessWidget {
  final String certificateId;
  const PublicCertificateVerificationView({super.key, required this.certificateId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Public Certificate Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: EcoGlassCard(
            title: 'Certificate #$certificateId',
            isOrganicLeafShape: true,
            statusIndicatorColor: OrganicColors.accentSage,
            child: Text(
              'Public Verification Route for Certificate ID: $certificateId',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: OrganicColors.textIvoryWhite),
            ),
          ),
        ),
      ),
    );
  }
}

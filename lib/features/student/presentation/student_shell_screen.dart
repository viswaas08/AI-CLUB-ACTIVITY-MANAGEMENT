import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/organic_theme.dart';
import '../../../../shared/widgets/organic/dewdrop_button.dart';
import '../../../../shared/widgets/organic/floating_forest_nav.dart';
import '../../auth/application/auth_providers.dart';
import '../../notifications/presentation/notification_drawer.dart';

class StudentShellScreen extends ConsumerWidget {
  final Widget child;
  final String currentRoute;

  const StudentShellScreen({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navItems = [
      const NavigationDestination(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
      const NavigationDestination(icon: Icon(Icons.groups_rounded), label: 'Clubs'),
      const NavigationDestination(icon: Icon(Icons.event_note_rounded), label: 'Events'),
      const NavigationDestination(icon: Icon(Icons.menu_book_rounded), label: 'Passport'),
      const NavigationDestination(icon: Icon(Icons.workspace_premium_rounded), label: 'Certificates'),
      const NavigationDestination(icon: Icon(Icons.emoji_events_rounded), label: 'Trophies'),
      const NavigationDestination(icon: Icon(Icons.leaderboard_rounded), label: 'Leaderboard'),
      const NavigationDestination(icon: Icon(Icons.notifications_rounded), label: 'Alerts'),
      const NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Profile'),
    ];

    int getSelectedIndex() {
      if (currentRoute.startsWith('/student/clubs')) return 1;
      if (currentRoute.startsWith('/student/events')) return 2;
      if (currentRoute.startsWith('/student/passport')) return 3;
      if (currentRoute.startsWith('/student/certificates')) return 4;
      if (currentRoute.startsWith('/student/achievements')) return 5;
      if (currentRoute.startsWith('/student/leaderboard')) return 6;
      if (currentRoute.startsWith('/student/notifications')) return 7;
      if (currentRoute.startsWith('/student/profile') || currentRoute.startsWith('/student/settings')) return 8;
      return 0;
    }

    void onDestinationSelected(int index) {
      switch (index) {
        case 0:
          context.go('/student');
          break;
        case 1:
          context.go('/student/clubs');
          break;
        case 2:
          context.go('/student/events');
          break;
        case 3:
          context.go('/student/passport');
          break;
        case 4:
          context.go('/student/certificates');
          break;
        case 5:
          context.go('/student/achievements');
          break;
        case 6:
          context.go('/student/leaderboard');
          break;
        case 7:
          context.go('/student/notifications');
          break;
        case 8:
          context.go('/student/profile');
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      endDrawer: const NotificationDrawer(),
      body: ResponsiveLayout(
        mobile: Scaffold(
          backgroundColor: Colors.transparent,
          endDrawer: const NotificationDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'AI CLUBS PORTAL',
              style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
            ),
            actions: [
              const NotificationBellIcon(),
              IconButton(
                icon: const Icon(Icons.logout_rounded, color: OrganicColors.accentTerracotta),
                onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
              ),
            ],
          ),
          body: child,
          bottomNavigationBar: FloatingForestBottomNav(
            selectedIndex: getSelectedIndex(),
            onDestinationSelected: onDestinationSelected,
            destinations: navItems.take(5).toList(),
          ),
        ),
        desktop: Row(
          children: [
            FloatingForestSidebar(
              width: 250,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: OrganicColors.primaryMint.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Icon(Icons.school_rounded, color: OrganicColors.primaryMint, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            'STUDENT PORTAL',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 1, color: OrganicColors.borderLightGrayGreen),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: navItems.length,
                      itemBuilder: (context, index) {
                        final selected = getSelectedIndex() == index;
                        final item = navItems[index];
                        final isDark = Theme.of(context).brightness == Brightness.dark;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            onTap: () => onDestinationSelected(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: selected
                                    ? OrganicColors.primaryMint.withValues(alpha: isDark ? 0.25 : 0.10)
                                    : Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    (item.icon as Icon).icon,
                                    color: selected
                                        ? OrganicColors.primaryMint
                                        : (isDark ? OrganicColors.textSoftMoss : OrganicColors.textSlateGreen),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    item.label,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: selected
                                          ? (isDark ? OrganicColors.textIvoryWhite : OrganicColors.textForestCharcoal)
                                          : (isDark ? OrganicColors.textSoftMoss : OrganicColors.textSlateGreen),
                                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(height: 1, color: OrganicColors.borderLightGrayGreen),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DewdropButton(
                      label: 'SIGN OUT SESSION',
                      variant: DewdropButtonVariant.terracotta,
                      icon: Icons.logout_rounded,
                      width: double.infinity,
                      onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}


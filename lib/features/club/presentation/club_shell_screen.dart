import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/organic_theme.dart';
import '../../../../shared/widgets/organic/dewdrop_button.dart';
import '../../../../shared/widgets/organic/floating_forest_nav.dart';
import '../../auth/application/auth_providers.dart';
import '../../auth/domain/user_role.dart';
import '../../notifications/presentation/notification_drawer.dart';
import '../application/club_providers.dart';

class ClubShellScreen extends ConsumerWidget {
  final Widget child;
  final String currentRoute;

  const ClubShellScreen({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).value;
    final adminClubsAsync = ref.watch(adminClubsProvider);
    final selectedClubId = ref.watch(selectedAdminClubIdProvider);

    if (user != null &&
        user.role != UserRole.clubAdmin &&
        user.role != UserRole.superAdmin &&
        user.administeredClubIds.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/unauthorized');
      });
    }

    final navItems = [
      const NavigationDestination(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
      const NavigationDestination(icon: Icon(Icons.tune_rounded), label: 'Profile'),
      const NavigationDestination(icon: Icon(Icons.people_alt_rounded), label: 'Members'),
      const NavigationDestination(icon: Icon(Icons.event_note_rounded), label: 'Events'),
      const NavigationDestination(icon: Icon(Icons.how_to_reg_rounded), label: 'Registrations'),
      const NavigationDestination(icon: Icon(Icons.qr_code_scanner_rounded), label: 'Attendance'),
      const NavigationDestination(icon: Icon(Icons.workspace_premium_rounded), label: 'Certificates'),
      const NavigationDestination(icon: Icon(Icons.campaign_rounded), label: 'Announcements'),
      const NavigationDestination(icon: Icon(Icons.analytics_rounded), label: 'Analytics'),
    ];

    int getSelectedIndex() {
      if (currentRoute.startsWith('/club/profile')) return 1;
      if (currentRoute.startsWith('/club/members')) return 2;
      if (currentRoute.startsWith('/club/events')) return 3;
      if (currentRoute.startsWith('/club/registrations')) return 4;
      if (currentRoute.startsWith('/club/attendance')) return 5;
      if (currentRoute.startsWith('/club/certificates')) return 6;
      if (currentRoute.startsWith('/club/announcements')) return 7;
      if (currentRoute.startsWith('/club/analytics')) return 8;
      return 0;
    }

    void onDestinationSelected(int index) {
      switch (index) {
        case 0:
          context.go('/club');
          break;
        case 1:
          context.go('/club/profile');
          break;
        case 2:
          context.go('/club/members');
          break;
        case 3:
          context.go('/club/events');
          break;
        case 4:
          context.go('/club/registrations');
          break;
        case 5:
          context.go('/club/attendance');
          break;
        case 6:
          context.go('/club/certificates');
          break;
        case 7:
          context.go('/club/announcements');
          break;
        case 8:
          context.go('/club/analytics');
          break;
      }
    }

    Widget buildOrganicClubSelector() {
      return adminClubsAsync.when(
        data: (clubs) {
          if (clubs.isEmpty) return const Text('No Admin Clubs');
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withValues(alpha: 0.1),
              border: Border.all(color: OrganicColors.glassBorder, width: 1.2),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedClubId ?? clubs.first.id,
                dropdownColor: OrganicColors.bgMidnightTeal,
                icon: const Icon(Icons.tune_rounded, color: OrganicColors.accentSage, size: 18),
                onChanged: (newId) {
                  if (newId != null) {
                    ref.read(selectedAdminClubIdProvider.notifier).state = newId;
                  }
                },
                items: clubs.map((c) {
                  return DropdownMenuItem<String>(
                    value: c.id,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.groups_rounded, color: OrganicColors.accentSage, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          c.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: OrganicColors.textIvoryWhite),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
        loading: () => const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
        error: (err, stack) => const Text('Club Select Error'),
      );
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
            title: const Text('CLUB ADMIN CONSOLE'),
            actions: [
              buildOrganicClubSelector(),
              const SizedBox(width: 8),
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.admin_panel_settings_rounded, color: OrganicColors.accentSage, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        'CLUB ADMIN',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ACTIVE CLUB CONTEXT',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: OrganicColors.textSoftMoss),
                        ),
                        const SizedBox(height: 6),
                        buildOrganicClubSelector(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: ListView.builder(
                      itemCount: navItems.length,
                      itemBuilder: (context, index) {
                        final selected = getSelectedIndex() == index;
                        final item = navItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => onDestinationSelected(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOutSine,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: selected
                                    ? OrganicColors.accentSage.withValues(alpha: 0.28)
                                    : Colors.transparent,
                                border: selected
                                    ? Border.all(color: OrganicColors.accentSage.withValues(alpha: 0.5), width: 1.2)
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    (item.icon as Icon).icon,
                                    color: selected ? OrganicColors.accentSage : OrganicColors.textSoftMoss,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    item.label,
                                    style: TextStyle(
                                      color: selected ? OrganicColors.textIvoryWhite : OrganicColors.textSoftMoss,
                                      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
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

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DewdropButton(
                      label: 'EXIT ADMIN SESSION',
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

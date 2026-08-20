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

class AdminShellScreen extends ConsumerWidget {
  final Widget child;
  final String currentRoute;

  const AdminShellScreen({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).value;

    // RBAC Security Guard
    if (user != null && user.role != UserRole.superAdmin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/unauthorized');
      });
    }

    final navItems = [
      const NavigationDestination(icon: Icon(Icons.shield_rounded), label: 'Control Center'),
      const NavigationDestination(icon: Icon(Icons.terminal_rounded), label: 'Audit Logs'),
      const NavigationDestination(icon: Icon(Icons.tune_rounded), label: 'Point Rules'),
    ];

    int getSelectedIndex() {
      if (currentRoute.startsWith('/admin/audit-logs')) return 1;
      if (currentRoute.startsWith('/admin/point-rules')) return 2;
      return 0;
    }

    void onDestinationSelected(int index) {
      switch (index) {
        case 0:
          context.go('/admin');
          break;
        case 1:
          context.go('/admin/audit-logs');
          break;
        case 2:
          context.go('/admin/point-rules');
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
            title: const Text('SUPER ADMIN CONTROL CENTER'),
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
            destinations: navItems,
          ),
        ),
        desktop: Row(
          children: [
            FloatingForestSidebar(
              width: 250,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shield_rounded, color: OrganicColors.accentTerracotta, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        'SUPER ADMIN',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Expanded(
                    child: ListView.builder(
                      itemCount: navItems.length,
                      itemBuilder: (context, index) {
                        final selected = getSelectedIndex() == index;
                        final item = navItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                                    ? OrganicColors.accentTerracotta.withValues(alpha: 0.28)
                                    : Colors.transparent,
                                border: selected
                                    ? Border.all(color: OrganicColors.accentTerracotta.withValues(alpha: 0.5), width: 1.2)
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    (item.icon as Icon).icon,
                                    color: selected ? OrganicColors.accentTerracotta : OrganicColors.textSoftMoss,
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
                      label: 'EXIT ROOT SESSION',
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

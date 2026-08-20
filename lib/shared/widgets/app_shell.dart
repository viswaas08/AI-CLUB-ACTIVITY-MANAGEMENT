import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/theme/organic_theme.dart';
import 'organic/floating_forest_nav.dart';

class NavDestinationItem {
  final String label;
  final IconData icon;
  final String route;

  const NavDestinationItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}

const List<NavDestinationItem> appNavDestinations = [
  NavDestinationItem(label: 'Home', icon: Icons.home_rounded, route: '/'),
  NavDestinationItem(label: 'Student', icon: Icons.dashboard_rounded, route: '/student'),
  NavDestinationItem(label: 'Clubs', icon: Icons.groups_rounded, route: '/clubs'),
  NavDestinationItem(label: 'Events', icon: Icons.event_note_rounded, route: '/events'),
  NavDestinationItem(label: 'Passport', icon: Icons.workspace_premium_rounded, route: '/student/passport'),
  NavDestinationItem(label: 'Certificates', icon: Icons.verified_rounded, route: '/student/certificates'),
  NavDestinationItem(label: 'Admin', icon: Icons.admin_panel_settings_rounded, route: '/student/admin'),
];

class AppShell extends StatelessWidget {
  final Widget child;
  final String currentRoute;

  const AppShell({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  int _getSelectedIndex() {
    if (currentRoute == '/') return 0;
    final index = appNavDestinations.indexWhere(
      (item) => item.route != '/' && currentRoute.startsWith(item.route),
    );
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex();

    final navDestinations = appNavDestinations
        .map((item) => NavigationDestination(icon: Icon(item.icon), label: item.label))
        .toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ResponsiveLayout(
        mobile: Scaffold(
          backgroundColor: Colors.transparent,
          body: child,
          bottomNavigationBar: FloatingForestBottomNav(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) => context.go(appNavDestinations[index].route),
            destinations: navDestinations.take(5).toList(),
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
                          child: const Icon(Icons.eco_rounded, color: OrganicColors.primaryMint, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            'AI CLUBS PORTAL',
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
                      itemCount: appNavDestinations.length,
                      itemBuilder: (context, index) {
                        final item = appNavDestinations[index];
                        final isSelected = selectedIndex == index;
                        final isDark = Theme.of(context).brightness == Brightness.dark;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            onTap: () => context.go(item.route),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: isSelected
                                    ? OrganicColors.primaryMint.withValues(alpha: isDark ? 0.25 : 0.10)
                                    : Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    item.icon,
                                    color: isSelected
                                        ? OrganicColors.primaryMint
                                        : (isDark ? OrganicColors.textSoftMoss : OrganicColors.textSlateGreen),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    item.label,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: isSelected
                                          ? (isDark ? OrganicColors.textIvoryWhite : OrganicColors.textForestCharcoal)
                                          : (isDark ? OrganicColors.textSoftMoss : OrganicColors.textSlateGreen),
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
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


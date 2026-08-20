import 'package:flutter/material.dart';
import '../../../../core/theme/glass_theme.dart';
import 'glass_container.dart';

class FloatingGlassSidebar extends StatelessWidget {
  final Widget child;
  final double width;

  const FloatingGlassSidebar({
    super.key,
    required this.child,
    this.width = 260.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassContainer(
        width: width,
        borderRadius: 20.0,
        blurSigma: 16.0,
        color: Colors.white.withValues(alpha: 0.07),
        border: Border.all(color: GlassColors.glassBorder, width: 1.0),
        child: child,
      ),
    );
  }
}

class FloatingGlassBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;

  const FloatingGlassBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassContainer(
        borderRadius: 28.0,
        blurSigma: 16.0,
        color: Colors.white.withValues(alpha: 0.09),
        border: Border.all(color: GlassColors.glassBorder, width: 1.0),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(destinations.length, (index) {
            final dest = destinations[index];
            final isSelected = selectedIndex == index;

            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => onDestinationSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCirc,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isSelected
                      ? GlassColors.accentCyan.withValues(alpha: 0.25)
                      : Colors.transparent,
                ),
                child: Row(
                  children: [
                    Icon(
                      (dest.icon as Icon).icon,
                      color: isSelected ? GlassColors.accentCyan : GlassColors.textIceBlue,
                      size: 20,
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      Text(
                        dest.label,
                        style: const TextStyle(
                          color: GlassColors.textFrostyWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

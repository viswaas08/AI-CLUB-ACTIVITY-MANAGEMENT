import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';

class FloatingForestSidebar extends StatelessWidget {
  final Widget child;
  final double width;

  const FloatingForestSidebar({
    super.key,
    required this.child,
    this.width = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: isDark
            ? OrganicColors.bgMidnightTeal.withValues(alpha: 0.85)
            : Colors.white.withValues(alpha: 0.88),
        border: Border(
          right: BorderSide(
            color: isDark ? OrganicColors.glassBorder : OrganicColors.borderLightGrayGreen,
            width: 1.0,
          ),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
        child: child,
      ),
    );
  }
}

class FloatingForestBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;

  const FloatingForestBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? OrganicColors.bgMidnightTeal.withValues(alpha: 0.85)
            : Colors.white.withValues(alpha: 0.88),
        border: Border(
          top: BorderSide(
            color: isDark ? OrganicColors.glassBorder : OrganicColors.borderLightGrayGreen,
            width: 1.0,
          ),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(destinations.length, (index) {
              final dest = destinations[index];
              final isSelected = selectedIndex == index;

              return InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () => onDestinationSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: isSelected
                        ? OrganicColors.primaryMint.withValues(alpha: isDark ? 0.25 : 0.12)
                        : Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        (dest.icon as Icon).icon,
                        color: isSelected
                            ? OrganicColors.primaryMint
                            : (isDark ? OrganicColors.textSoftMoss : OrganicColors.textSlateGreen),
                        size: 20,
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 6),
                        Text(
                          dest.label,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: isDark ? OrganicColors.textIvoryWhite : OrganicColors.textForestCharcoal,
                            fontWeight: FontWeight.w700,
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
      ),
    );
  }
}

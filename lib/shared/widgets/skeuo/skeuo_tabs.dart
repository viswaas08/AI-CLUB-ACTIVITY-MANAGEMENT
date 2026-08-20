import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';

class SkeuomorphicTab extends StatelessWidget {
  final List<String>? tabs;
  final int? selectedIndex;
  final ValueChanged<int>? onTabSelected;

  // Single tab support
  final String? label;
  final bool? isSelected;
  final VoidCallback? onTap;
  final IconData? icon;

  const SkeuomorphicTab({
    super.key,
    this.tabs,
    this.selectedIndex,
    this.onTabSelected,
    this.label,
    this.isSelected,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (tabs != null) {
      final activeIdx = selectedIndex ?? 0;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(tabs!.length, (index) {
            final isItemActive = index == activeIdx;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: () => onTabSelected?.call(index),
                borderRadius: BorderRadius.circular(20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOutSine,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isItemActive
                        ? (isDark
                            ? OrganicColors.accentSage.withValues(alpha: 0.35)
                            : OrganicColors.accentEmeraldMedium.withValues(alpha: 0.20))
                        : Colors.transparent,
                    border: isItemActive
                        ? Border.all(
                            color: isDark ? OrganicColors.accentSage : OrganicColors.accentEmeraldMedium,
                            width: 1.2,
                          )
                        : Border.all(
                            color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
                            width: 1.0,
                          ),
                  ),
                  child: Text(
                    tabs![index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isItemActive ? FontWeight.bold : FontWeight.w500,
                      letterSpacing: 0.5,
                      color: isItemActive
                          ? (isDark ? OrganicColors.textIvoryWhite : OrganicColors.accentEmeraldMedium)
                          : (isDark ? OrganicColors.textSoftMoss : const Color(0xFF64748B)),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    }

    final isSingleSelected = isSelected ?? false;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOutSine,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSingleSelected
              ? (isDark
                  ? OrganicColors.accentSage.withValues(alpha: 0.35)
                  : OrganicColors.accentEmeraldMedium.withValues(alpha: 0.20))
              : Colors.transparent,
          border: isSingleSelected
              ? Border.all(
                  color: isDark ? OrganicColors.accentSage : OrganicColors.accentEmeraldMedium,
                  width: 1.2,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSingleSelected
                    ? (isDark ? OrganicColors.textIvoryWhite : OrganicColors.accentEmeraldMedium)
                    : (isDark ? OrganicColors.textSoftMoss : const Color(0xFF64748B)),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label ?? '',
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSingleSelected ? FontWeight.bold : FontWeight.normal,
                color: isSingleSelected
                    ? (isDark ? OrganicColors.textIvoryWhite : OrganicColors.accentEmeraldMedium)
                    : (isDark ? OrganicColors.textSoftMoss : const Color(0xFF64748B)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'organic_theme.dart';

class SkeuoShadows {
  static List<BoxShadow> raised({
    required bool isDark,
    double distance = 4.0,
    double blur = 8.0,
    double highlightIntensity = 1.0,
    double shadowIntensity = 1.0,
  }) {
    return [
      BoxShadow(
        color: (isDark ? Colors.black : const Color(0xFF15803D)).withValues(alpha: 0.08 * shadowIntensity),
        offset: Offset(0, distance),
        blurRadius: blur,
      ),
    ];
  }

  static BoxDecoration bevelBox({
    required bool isDark,
    required bool isPressed,
    double borderRadius = 16.0,
    Color? customColor,
    Gradient? customGradient,
  }) {
    final baseColor = customColor ??
        (isDark ? OrganicColors.glassSurfaceDark : OrganicColors.glassSurfaceLightGreen);

    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: baseColor,
      border: Border.all(
        color: isDark ? OrganicColors.glassBorder : OrganicColors.glassBorderLightGreen,
        width: 1.2,
      ),
      boxShadow: isPressed
          ? []
          : [
              BoxShadow(
                color: (isDark ? Colors.black : const Color(0xFF15803D)).withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
    );
  }

  static BoxDecoration recessedBox({
    required bool isDark,
    double borderRadius = 14.0,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.white.withValues(alpha: 0.65),
      border: Border.all(
        color: isDark ? OrganicColors.glassBorder : OrganicColors.glassBorderLightGreen,
        width: 1.0,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'organic_theme.dart';

abstract class SkeuoColors {
  static const Color darkBase = OrganicColors.bgDeepForest;
  static const Color darkRaised = OrganicColors.bgMidnightTeal;
  static const Color darkRecessed = Color(0xFF132219);

  static const Color lightBase = OrganicColors.bgMintOffWhite;
  static const Color lightRaised = Colors.white;
  static const Color lightRecessed = OrganicColors.borderLightGrayGreen;

  static const Color darkTopHighlight = Colors.transparent;
  static const Color darkBottomShadow = Colors.transparent;
  static const Color lightTopHighlight = Colors.transparent;
  static const Color lightBottomShadow = Colors.transparent;

  static const Color primaryBlue = OrganicColors.primaryMint;
  static const Color accentAmber = Color(0xFFD97706);
  static const Color activeGreen = OrganicColors.primaryMint;
  static const Color alertRed = OrganicColors.accentTerracotta;
}

class SkeuoShadows {
  // Clean minimal subtle elevation - avoid heavy drop shadows
  static List<BoxShadow> raisedLevel1({required bool isDark}) {
    return [
      BoxShadow(
        color: (isDark ? Colors.black : const Color(0xFF1A2E22)).withValues(alpha: isDark ? 0.2 : 0.04),
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
    ];
  }

  static List<BoxShadow> raisedLevel2({required bool isDark}) {
    return [
      BoxShadow(
        color: (isDark ? Colors.black : const Color(0xFF1A2E22)).withValues(alpha: isDark ? 0.3 : 0.06),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }

  static List<BoxShadow> sunkenLevel1({required bool isDark}) => const [];
  static List<BoxShadow> sunkenLevel2({required bool isDark}) => const [];
}

class SkeuoTheme {
  static ThemeData get darkTheme => OrganicTheme.darkTheme;
  static ThemeData get lightTheme => OrganicTheme.lightGreenTheme;
}


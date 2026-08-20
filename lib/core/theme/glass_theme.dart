import 'package:flutter/material.dart';

class GlassColors {
  // Deep Cool Mesh Gradient Colors
  static const Color bgDarkSlate = Color(0xFF0F172A);
  static const Color bgOceanBlue = Color(0xFF1E293B);
  static const Color bgSlateTeal = Color(0xFF0D9488);
  static const Color bgIcyPurple = Color(0xFF4C1D95);

  // Frosty Text & Accent Colors
  static const Color textFrostyWhite = Color(0xFFF8FAFC);
  static const Color textIceBlue = Color(0xFF94A3B8);
  static const Color accentCyan = Color(0xFF38BDF8);
  static const Color accentTeal = Color(0xFF2DD4BF);
  static const Color accentPurple = Color(0xFFA855F7);
  static const Color accentAmber = Color(0xFFF59E0B);
  static const Color alertRose = Color(0xFFF43F5E);

  // Glass Surface & Border Opacities
  static Color glassSurfaceDark = Colors.white.withValues(alpha: 0.08);
  static Color glassSurfaceLight = Colors.white.withValues(alpha: 0.18);
  static Color glassBorder = Colors.white.withValues(alpha: 0.20);
  static Color glassBorderFocused = Color(0xFF38BDF8).withValues(alpha: 0.60);
}

class GlassTheme {
  static BoxDecoration get meshGradientDecoration => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            GlassColors.bgDarkSlate,
            Color(0xFF111827),
            Color(0xFF0F172A),
            GlassColors.bgIcyPurple,
          ],
          stops: [0.0, 0.35, 0.7, 1.0],
        ),
      );

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: GlassColors.bgDarkSlate,
      colorScheme: const ColorScheme.dark(
        primary: GlassColors.accentCyan,
        secondary: GlassColors.accentTeal,
        surface: GlassColors.bgOceanBlue,
        error: GlassColors.alertRose,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: GlassColors.textFrostyWhite,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          color: GlassColors.textFrostyWhite,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: GlassColors.textFrostyWhite),
        bodyMedium: TextStyle(color: GlassColors.textIceBlue),
      ),
    );
  }
}

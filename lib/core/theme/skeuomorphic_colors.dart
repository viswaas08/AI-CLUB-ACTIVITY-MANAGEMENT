import 'package:flutter/material.dart';
import 'organic_theme.dart';

abstract class SkeuoColors {
  static const Color darkBackground = OrganicColors.bgDeepForest;
  static const Color darkSurfaceMatte = OrganicColors.bgMidnightTeal;
  static const Color darkSurfaceRaised = Color(0xFF1C2A21);
  static const Color darkSurfaceRecessed = Color(0xFF142419);

  static const Color lightBackground = OrganicColors.bgLightMint;
  static const Color lightSurfaceMatte = OrganicColors.bgLightSoftEmerald;
  static const Color lightSurfaceRaised = Colors.white;
  static const Color lightSurfaceRecessed = Color(0xFFE8F5E9);

  static const Color darkTopHighlight = Colors.transparent;
  static const Color darkBottomShadow = Colors.transparent;
  static const Color lightTopHighlight = Colors.transparent;
  static const Color lightBottomShadow = Colors.transparent;

  static const Color amberLED = OrganicColors.accentTerracotta;
  static const Color amberGlow = OrganicColors.accentTerracotta;

  static const Color blueControl = OrganicColors.accentSage;
  static const Color blueGlow = OrganicColors.accentSage;

  static const Color emeraldActive = OrganicColors.accentEmeraldMedium;
  static const Color emeraldGlow = OrganicColors.accentEmeraldMedium;

  static const Color crimsonAlert = OrganicColors.accentTerracotta;
  static const Color crimsonGlow = OrganicColors.accentTerracotta;

  static const LinearGradient darkConvexGradient = LinearGradient(
    colors: [Color(0xFF1C2A21), Color(0xFF0F2922)],
  );

  static const LinearGradient darkConcaveGradient = LinearGradient(
    colors: [Color(0xFF0F2922), Color(0xFF1C2A21)],
  );

  static const LinearGradient lightConvexGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF0FDF4)],
  );

  static const LinearGradient lightConcaveGradient = LinearGradient(
    colors: [Color(0xFFDCFCE7), Colors.white],
  );

  static const LinearGradient primaryButtonGradient = LinearGradient(
    colors: [OrganicColors.accentEmeraldMedium, Color(0xFF14532D)],
  );

  static const LinearGradient amberButtonGradient = LinearGradient(
    colors: [OrganicColors.accentTerracotta, Color(0xFF9A3412)],
  );
}

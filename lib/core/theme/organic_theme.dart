import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Default to Mint Minimalist Light Theme
final isLightGreenThemeProvider = StateProvider<bool>((ref) => true);

class OrganicColors {
  // Mint Minimalist Theme Palette
  static const Color bgMintOffWhite = Color(0xFFF4F7F5); // Crisp, cool off-white background
  static const Color borderLightGrayGreen = Color(0xFFE2EAE5); // Very thin light gray-green grid/border/divider
  static const Color primaryMint = Color(0xFF00A86B); // Energetic soft mint green CTA & status
  static const Color primaryMintSoft = Color(0xFF48BB78); // Secondary soft mint green
  static const Color textForestCharcoal = Color(0xFF1A2E22); // Deep forest charcoal headings
  static const Color textSlateGreen = Color(0xFF5A6E63); // Muted slate green body copy
  static const Color cardSurface = Colors.white; // Crisp white surface for light mode

  // Backward compatible references & dark theme fallbacks
  static const Color bgDeepForest = Color(0xFF132219);
  static const Color bgMidnightTeal = Color(0xFF1A2E22);
  static const Color bgSoilBrown = Color(0xFF223629);
  static const Color bgSageGreen = Color(0xFF5A6E63);

  static const Color bgLightMint = bgMintOffWhite;
  static const Color bgLightSoftEmerald = Color(0xFFFFFFFF);
  static const Color bgLightLeaf = Color(0xFFE8F2EC);
  static const Color accentEmeraldDark = textForestCharcoal;
  static const Color accentEmeraldMedium = primaryMint;
  static const Color accentEmeraldLight = primaryMintSoft;
  static const Color accentLime = Color(0xFF48BB78);

  // Accent & Status Colors
  static const Color accentMoss = Color(0xFF00A86B);
  static const Color accentTerracotta = Color(0xFFE07A5F);
  static const Color accentSage = Color(0xFF00A86B);
  static const Color accentIvory = Color(0xFFF4F7F5);
  static const Color accentClay = Color(0xFFD9534F);

  // Text Colors
  static const Color textIvoryWhite = Color(0xFFF4F7F5);
  static const Color textSoftMoss = Color(0xFF8BA695);
  static const Color textDarkForest = textForestCharcoal;
  static const Color textSubtleEmerald = textSlateGreen;

  // Surfaces & Borders
  static Color glassSurfaceDark = const Color(0xFF1A2E22).withValues(alpha: 0.85);
  static Color glassSurfaceLightGreen = Colors.white;
  static Color glassBorder = const Color(0xFF2D4536);
  static Color glassBorderLightGreen = borderLightGrayGreen;
  static Color glassBorderFocused = primaryMint;

  // Standard 8px rounded corners for Mint Minimalist design
  static BorderRadius get standardBorderRadius => BorderRadius.circular(8.0);
  static BorderRadius get leafBorderRadius => BorderRadius.circular(8.0);
}

class OrganicTheme {
  // Ambient background mesh gradient for glassmorphism refraction
  static BoxDecoration get natureMeshGradientDecoration => const BoxDecoration(
        color: OrganicColors.bgDeepForest,
      );

  static BoxDecoration get lightGreenMeshGradientDecoration => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF4F7F5),
            Color(0xFFEAF5EE),
            Color(0xFFF4F7F5),
            Color(0xFFE2EFE7),
          ],
          stops: [0.0, 0.35, 0.70, 1.0],
        ),
      );

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: OrganicColors.bgDeepForest,
      dividerColor: OrganicColors.glassBorder,
      cardTheme: CardThemeData(
        color: OrganicColors.bgMidnightTeal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Color(0xFF2D4536), width: 1.0),
        ),
        elevation: 0,
      ),
      colorScheme: const ColorScheme.dark(
        primary: OrganicColors.primaryMint,
        secondary: OrganicColors.primaryMintSoft,
        surface: OrganicColors.bgMidnightTeal,
        error: OrganicColors.accentTerracotta,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: OrganicColors.textIvoryWhite,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          fontFamily: 'Inter',
        ),
        titleLarge: TextStyle(
          color: OrganicColors.textIvoryWhite,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        bodyLarge: TextStyle(color: OrganicColors.textIvoryWhite, fontFamily: 'Inter'),
        bodyMedium: TextStyle(color: OrganicColors.textSoftMoss, fontFamily: 'Inter'),
      ),
    );
  }

  static ThemeData get lightGreenTheme {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: OrganicColors.bgMintOffWhite,
      dividerColor: OrganicColors.borderLightGrayGreen,
      cardTheme: CardThemeData(
        color: OrganicColors.cardSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: OrganicColors.borderLightGrayGreen, width: 1.0),
        ),
        elevation: 0,
      ),
      colorScheme: const ColorScheme.light(
        primary: OrganicColors.primaryMint,
        secondary: OrganicColors.primaryMintSoft,
        surface: OrganicColors.cardSurface,
        error: OrganicColors.accentTerracotta,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: OrganicColors.textForestCharcoal,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          fontFamily: 'Inter',
        ),
        titleLarge: TextStyle(
          color: OrganicColors.textForestCharcoal,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        bodyLarge: TextStyle(color: OrganicColors.textForestCharcoal, fontFamily: 'Inter'),
        bodyMedium: TextStyle(color: OrganicColors.textSlateGreen, fontFamily: 'Inter'),
      ),
    );
  }
}


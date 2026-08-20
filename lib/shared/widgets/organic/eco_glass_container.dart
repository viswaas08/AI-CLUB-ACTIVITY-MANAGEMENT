import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';

class EcoGlassContainer extends StatelessWidget {
  final Widget child;
  final double blurSigma;
  final BorderRadius? borderRadius;
  final bool isOrganicLeafShape;
  final Color? color;
  final Border? border;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  const EcoGlassContainer({
    super.key,
    required this.child,
    this.blurSigma = 16.0,
    this.borderRadius,
    this.isOrganicLeafShape = false,
    this.color,
    this.border,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveRadius = borderRadius ?? BorderRadius.circular(8.0);

    final effectiveColor = color ??
        (isDark
            ? const Color(0xFF132219).withValues(alpha: 0.75)
            : Colors.white.withValues(alpha: 0.85));

    final effectiveBorder = border ??
        Border.all(
          color: isDark
              ? OrganicColors.glassBorder.withValues(alpha: 0.8)
              : Colors.white.withValues(alpha: 0.9),
          width: 1.0,
        );

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: effectiveRadius,
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : const Color(0xFF00A86B)).withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          if (!isDark)
            BoxShadow(
              color: const Color(0xFF1A2E22).withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: effectiveRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: effectiveColor,
              borderRadius: effectiveRadius,
              border: effectiveBorder,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}



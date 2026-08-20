import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';

class FluidCustomCursor extends StatelessWidget {
  final Offset mousePosition;
  final bool isHoveringInteractive;

  const FluidCustomCursor({
    super.key,
    required this.mousePosition,
    this.isHoveringInteractive = false,
  });

  @override
  Widget build(BuildContext context) {
    if (mousePosition == Offset.zero) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final glowColor = isDark ? OrganicColors.accentSage : const Color(0xFF22C55E);
    final size = isHoveringInteractive ? 32.0 : 18.0;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 60),
      curve: Curves.easeOutCubic,
      left: mousePosition.dx - (size / 2),
      top: mousePosition.dy - (size / 2),
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: glowColor.withValues(alpha: isDark ? 0.25 : 0.35),
            boxShadow: [
              BoxShadow(
                color: glowColor.withValues(alpha: isDark ? 0.45 : 0.30),
                blurRadius: isHoveringInteractive ? 14 : 8,
                spreadRadius: isHoveringInteractive ? 2 : 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

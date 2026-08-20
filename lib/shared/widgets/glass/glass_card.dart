import 'package:flutter/material.dart';
import '../../../../core/theme/glass_theme.dart';
import 'glass_container.dart';

class GlassCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final Color statusIndicatorColor;
  final List<Widget>? actions;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const GlassCard({
    super.key,
    this.title,
    required this.child,
    this.statusIndicatorColor = GlassColors.accentCyan,
    this.actions,
    this.padding = const EdgeInsets.all(20.0),
    this.borderRadius = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: borderRadius,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: statusIndicatorColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: statusIndicatorColor.withValues(alpha: 0.6),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title!,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 0.5,
                      color: GlassColors.textFrostyWhite,
                    ),
                  ),
                ),
                ...?actions,
              ],
            ),
            const SizedBox(height: 16),
          ],
          child,
        ],
      ),
    );
  }
}

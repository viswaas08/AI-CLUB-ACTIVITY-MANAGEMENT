import 'package:flutter/material.dart';
import '../../core/theme/organic_theme.dart';

class TactileProgressBar extends StatelessWidget {
  final double progress;
  final String? label;
  final Color barColor;
  final double height;
  final bool showPercentage;

  const TactileProgressBar({
    super.key,
    required this.progress,
    this.label,
    this.barColor = OrganicColors.accentEmeraldMedium,
    this.height = 10.0,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final clamped = progress.clamp(0.0, 1.0);

    final barWidget = Container(
      height: height,
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(height / 2),
        border: Border.all(
          color: isDark ? OrganicColors.glassBorder : const Color(0xFFCBD5E1),
          width: 0.8,
        ),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: clamped,
        child: Container(
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(height / 2),
            boxShadow: [
              BoxShadow(
                color: barColor.withValues(alpha: 0.35),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );

    if (label != null || showPercentage) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: isDark ? OrganicColors.textSoftMoss : OrganicColors.textSubtleEmerald,
                  ),
                ),
              if (showPercentage)
                Text(
                  '${(clamped * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isDark ? OrganicColors.textIvoryWhite : OrganicColors.textDarkForest,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          barWidget,
        ],
      );
    }

    return barWidget;
  }
}

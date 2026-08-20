import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';

class SkeuomorphicProgress extends StatelessWidget {
  final double? value;
  final double? progress;
  final String? label;
  final Color? fillColor;
  final Color? barColor;
  final double height;
  final double borderRadius;

  const SkeuomorphicProgress({
    super.key,
    this.value,
    this.progress,
    this.label,
    this.fillColor,
    this.barColor,
    this.height = 8.0,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double rawVal = value ?? progress ?? 0.0;
    final clampedValue = rawVal.clamp(0.0, 1.0);
    final effectiveColor = fillColor ?? barColor ?? OrganicColors.primaryMint;

    final barWidget = Container(
      height: height,
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFE8F2EC),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: isDark ? OrganicColors.glassBorder : OrganicColors.borderLightGrayGreen,
          width: 1.0,
        ),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: clampedValue,
        child: Container(
          decoration: BoxDecoration(
            color: effectiveColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );

    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                  color: isDark ? OrganicColors.textSoftMoss : OrganicColors.textSlateGreen,
                ),
              ),
              Text(
                '${(clampedValue * 100).toInt()}%',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDark ? OrganicColors.textIvoryWhite : OrganicColors.textForestCharcoal,
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


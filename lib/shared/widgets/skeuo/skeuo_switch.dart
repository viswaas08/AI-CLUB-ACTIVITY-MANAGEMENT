import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';

class SkeuomorphicSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final Color activeColor;

  const SkeuomorphicSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.activeColor = OrganicColors.primaryMint,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final toggle = GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOutSine,
        width: 44,
        height: 24,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: value
              ? activeColor
              : (isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xFFE8F2EC)),
          border: Border.all(
            color: value
                ? activeColor
                : (isDark ? OrganicColors.glassBorder : OrganicColors.borderLightGrayGreen),
            width: 1.0,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOutSine,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

    if (label != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          toggle,
          const SizedBox(width: 10),
          Text(
            label!,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? OrganicColors.textIvoryWhite : OrganicColors.textForestCharcoal,
            ),
          ),
        ],
      );
    }

    return toggle;
  }
}


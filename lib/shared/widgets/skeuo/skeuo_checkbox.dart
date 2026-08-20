import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';

class SkeuomorphicCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;

  const SkeuomorphicCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const activeColor = OrganicColors.primaryMint;

    final box = GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: value
              ? activeColor
              : (isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white),
          border: Border.all(
            color: value
                ? activeColor
                : (isDark ? OrganicColors.glassBorder : OrganicColors.borderLightGrayGreen),
            width: 1.0,
          ),
        ),
        child: value
            ? const Icon(
                Icons.check_rounded,
                size: 14,
                color: Colors.white,
              )
            : null,
      ),
    );

    if (label == null) return box;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        box,
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
}


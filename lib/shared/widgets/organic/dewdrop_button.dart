import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';

enum DewdropButtonVariant { moss, sage, terracotta, clay, translucent }

class DewdropButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final DewdropButtonVariant variant;
  final bool isLoading;
  final double height;
  final double? width;

  const DewdropButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = DewdropButtonVariant.sage,
    this.isLoading = false,
    this.height = 40.0,
    this.width,
  });

  @override
  State<DewdropButton> createState() => _DewdropButtonState();
}

class _DewdropButtonState extends State<DewdropButton> {
  bool _isHovered = false;

  Color _getAccentColor(bool isDark) {
    switch (widget.variant) {
      case DewdropButtonVariant.moss:
      case DewdropButtonVariant.sage:
        return OrganicColors.primaryMint; // #00A86B energetic soft mint
      case DewdropButtonVariant.terracotta:
        return isDark ? OrganicColors.accentTerracotta : const Color(0xFFD97706);
      case DewdropButtonVariant.clay:
        return isDark ? OrganicColors.accentClay : const Color(0xFFDC2626);
      case DewdropButtonVariant.translucent:
        return isDark ? OrganicColors.accentIvory : OrganicColors.textForestCharcoal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = _getAccentColor(isDark);
    final isDisabled = widget.onPressed == null || widget.isLoading;

    Color buttonTextColor;
    Color buttonFillColor;
    Border buttonBorder;

    if (isDark) {
      if (widget.variant == DewdropButtonVariant.translucent) {
        buttonTextColor = isDisabled ? OrganicColors.textSoftMoss : OrganicColors.textIvoryWhite;
        buttonFillColor = _isHovered
            ? Colors.white.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: 0.06);
        buttonBorder = Border.all(
          color: OrganicColors.glassBorder,
          width: 1.0,
        );
      } else {
        buttonTextColor = Colors.white;
        buttonFillColor = _isHovered
            ? accentColor.withValues(alpha: 0.9)
            : accentColor;
        buttonBorder = Border.all(
          color: accentColor,
          width: 1.0,
        );
      }
    } else {
      // Mint Minimalist Light Mode
      if (widget.variant == DewdropButtonVariant.translucent) {
        buttonTextColor = isDisabled ? const Color(0xFF94A3B8) : OrganicColors.textForestCharcoal;
        buttonFillColor = _isHovered
            ? const Color(0xFFE8F2EC)
            : Colors.white;
        buttonBorder = Border.all(
          color: _isHovered ? OrganicColors.primaryMint : OrganicColors.borderLightGrayGreen,
          width: 1.0,
        );
      } else {
        // Primary CTA (#00A86B)
        buttonTextColor = Colors.white;
        buttonFillColor = _isHovered
            ? const Color(0xFF00965F)
            : accentColor;
        buttonBorder = Border.all(
          color: buttonFillColor,
          width: 1.0,
        );
      }
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutQuad,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: buttonFillColor,
          borderRadius: BorderRadius.circular(8.0),
          border: buttonBorder,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: isDisabled ? null : widget.onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isLoading) ...[
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(buttonTextColor),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ] else if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 16,
                      color: buttonTextColor,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                      color: buttonTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


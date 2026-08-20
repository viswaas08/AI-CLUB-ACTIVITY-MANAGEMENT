import 'package:flutter/material.dart';
import '../../../../core/theme/glass_theme.dart';
import 'glass_container.dart';

enum GlassButtonVariant { cyan, teal, purple, rose, translucent }

class GlassButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final GlassButtonVariant variant;
  final bool isLoading;
  final double height;
  final double? width;

  const GlassButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = GlassButtonVariant.cyan,
    this.isLoading = false,
    this.height = 44.0,
    this.width,
  });

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _isHovered = false;

  Color _getVariantColor() {
    switch (widget.variant) {
      case GlassButtonVariant.cyan:
        return GlassColors.accentCyan;
      case GlassButtonVariant.teal:
        return GlassColors.accentTeal;
      case GlassButtonVariant.purple:
        return GlassColors.accentPurple;
      case GlassButtonVariant.rose:
        return GlassColors.alertRose;
      case GlassButtonVariant.translucent:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = _getVariantColor();
    final isDisabled = widget.onPressed == null || widget.isLoading;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCirc,
        child: GlassContainer(
          borderRadius: 24.0,
          color: _isHovered
              ? accentColor.withValues(alpha: 0.25)
              : accentColor.withValues(alpha: 0.12),
          border: Border.all(
            color: _isHovered
                ? accentColor.withValues(alpha: 0.7)
                : accentColor.withValues(alpha: 0.35),
            width: 1.2,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          height: widget.height,
          width: widget.width,
          child: InkWell(
            borderRadius: BorderRadius.circular(24.0),
            onTap: isDisabled ? null : widget.onPressed,
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
                      valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                    ),
                  ),
                  const SizedBox(width: 8),
                ] else if (widget.icon != null) ...[
                  Icon(widget.icon, size: 18, color: accentColor),
                  const SizedBox(width: 8),
                ],
                Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDisabled ? GlassColors.textIceBlue : GlassColors.textFrostyWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

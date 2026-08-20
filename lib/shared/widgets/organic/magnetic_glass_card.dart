import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';
import 'eco_glass_container.dart';

class MagneticGlassCard extends StatefulWidget {
  final Widget child;
  final String? title;
  final Color? statusIndicatorColor;
  final List<Widget>? actions;
  final EdgeInsetsGeometry padding;
  final bool isOrganicLeafShape;
  final double tiltSensitivity;

  const MagneticGlassCard({
    super.key,
    required this.child,
    this.title,
    this.statusIndicatorColor,
    this.actions,
    this.padding = const EdgeInsets.all(24.0),
    this.isOrganicLeafShape = false,
    this.tiltSensitivity = 0.0006,
  });

  @override
  State<MagneticGlassCard> createState() => _MagneticGlassCardState();
}

class _MagneticGlassCardState extends State<MagneticGlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final indicatorColor = widget.statusIndicatorColor ?? OrganicColors.primaryMint;

    final titleColor = isDark ? OrganicColors.textIvoryWhite : OrganicColors.textForestCharcoal;

    final cardBackgroundColor = isDark
        ? (_isHovered
            ? const Color(0xFF132219).withValues(alpha: 0.85)
            : const Color(0xFF132219).withValues(alpha: 0.70))
        : (_isHovered
            ? Colors.white.withValues(alpha: 0.95)
            : Colors.white.withValues(alpha: 0.85));

    final cardBorderColor = isDark
        ? (_isHovered
            ? OrganicColors.primaryMint.withValues(alpha: 0.85)
            : OrganicColors.glassBorder)
        : (_isHovered
            ? OrganicColors.primaryMint.withValues(alpha: 0.80)
            : OrganicColors.borderLightGrayGreen);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -6.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: _isHovered ? 0.45 : 0.15)
                  : const Color(0xFF15803D).withValues(alpha: _isHovered ? 0.20 : 0.06),
              blurRadius: _isHovered ? 24 : 10,
              offset: Offset(0, _isHovered ? 12 : 4),
            ),
          ],
        ),
        child: EcoGlassContainer(
          isOrganicLeafShape: widget.isOrganicLeafShape,
          blurSigma: 12.0,
          padding: widget.padding,
          color: cardBackgroundColor,
          border: Border.all(
            color: cardBorderColor,
            width: _isHovered ? 1.8 : 1.2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title != null) ...[
                Row(
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: indicatorColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: indicatorColor.withValues(alpha: 0.7),
                            blurRadius: 7,
                            spreadRadius: 1.5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.title!,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 0.4,
                          color: titleColor,
                        ),
                      ),
                    ),
                    ...?widget.actions,
                  ],
                ),
                const SizedBox(height: 16),
              ],
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}

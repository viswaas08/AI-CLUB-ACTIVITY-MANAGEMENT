import 'package:flutter/material.dart';
import '../../core/theme/organic_theme.dart';
import 'organic/eco_glass_card.dart';

class TactileCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? color;
  final bool isPressed;

  const TactileCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 16.0,
    this.color,
    this.isPressed = false,
  });

  @override
  Widget build(BuildContext context) {
    return EcoGlassCard(
      padding: padding,
      isOrganicLeafShape: true,
      statusIndicatorColor: OrganicColors.accentSage,
      child: child,
    );
  }
}

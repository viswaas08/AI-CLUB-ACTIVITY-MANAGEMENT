import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';
import '../organic/eco_glass_card.dart';

class SkeuomorphicCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final Color ledColor;
  final List<Widget>? actions;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool isInset;

  const SkeuomorphicCard({
    super.key,
    this.title,
    required this.child,
    this.ledColor = OrganicColors.primaryMint,
    this.actions,
    this.padding = const EdgeInsets.all(20.0),
    this.borderRadius = 8.0,
    this.isInset = false,
  });

  @override
  Widget build(BuildContext context) {
    return EcoGlassCard(
      title: title,
      statusIndicatorColor: ledColor,
      actions: actions,
      padding: padding,
      isOrganicLeafShape: false,
      child: child,
    );
  }
}


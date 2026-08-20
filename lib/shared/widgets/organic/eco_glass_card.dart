import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';
import 'eco_glass_container.dart';

class EcoGlassCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final Color statusIndicatorColor;
  final List<Widget>? actions;
  final EdgeInsetsGeometry padding;
  final bool isOrganicLeafShape;

  const EcoGlassCard({
    super.key,
    this.title,
    required this.child,
    this.statusIndicatorColor = OrganicColors.primaryMint,
    this.actions,
    this.padding = const EdgeInsets.all(20.0),
    this.isOrganicLeafShape = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? OrganicColors.textIvoryWhite : OrganicColors.textForestCharcoal;

    return EcoGlassContainer(
      borderRadius: BorderRadius.circular(8.0),
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
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      letterSpacing: 0.5,
                      color: titleColor,
                    ),
                  ),
                ),
                ...?actions,
              ],
            ),
            const SizedBox(height: 18),
          ],
          child,
        ],
      ),
    );
  }
}


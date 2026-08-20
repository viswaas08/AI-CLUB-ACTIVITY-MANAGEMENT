import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';
import '../organic/eco_glass_container.dart';

class SkeuomorphicLoadingState extends StatelessWidget {
  final String label;
  final double size;

  const SkeuomorphicLoadingState({
    super.key,
    this.label = 'Loading live data...',
    this.size = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? OrganicColors.accentSage : OrganicColors.accentEmeraldMedium;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: EcoGlassContainer(
          borderRadius: BorderRadius.circular(20),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(accent),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? OrganicColors.textSoftMoss : OrganicColors.textDarkForest,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

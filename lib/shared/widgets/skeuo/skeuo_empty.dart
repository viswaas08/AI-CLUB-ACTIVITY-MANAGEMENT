import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';
import '../organic/eco_glass_container.dart';

class SkeuomorphicEmptyState extends StatelessWidget {
  final String title;
  final String? description;
  final String? message;
  final IconData icon;
  final Widget? action;

  const SkeuomorphicEmptyState({
    super.key,
    required this.title,
    this.description,
    this.message,
    this.icon = Icons.inbox_rounded,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? OrganicColors.accentSage : OrganicColors.accentEmeraldMedium;
    final bodyText = description ?? message ?? '';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: EcoGlassContainer(
          borderRadius: BorderRadius.circular(24),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor.withValues(alpha: isDark ? 0.2 : 0.12),
                  border: Border.all(
                    color: iconColor.withValues(alpha: 0.4),
                    width: 1.2,
                  ),
                ),
                child: Icon(icon, size: 36, color: iconColor),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? OrganicColors.textIvoryWhite : OrganicColors.textDarkForest,
                ),
              ),
              if (bodyText.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  bodyText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: isDark ? OrganicColors.textSoftMoss : OrganicColors.textSubtleEmerald,
                  ),
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: 20),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

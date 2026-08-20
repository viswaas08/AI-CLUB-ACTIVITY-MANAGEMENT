import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';

class AdaptivePathWidget extends StatelessWidget {
  const AdaptivePathWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? OrganicColors.textIvoryWhite : OrganicColors.textForestCharcoal;
    final subtextColor = isDark ? OrganicColors.textSoftMoss : OrganicColors.textSlateGreen;

    final steps = [
      {
        'title': 'Step 1: Beginner Data Structures Lab',
        'status': 'RECOMMENDED FOUNDATION',
        'points': '+40 PTS',
        'isDone': false,
      },
      {
        'title': 'Step 2: Inter-College Coding Sprint',
        'status': 'TARGET COMPETITION',
        'points': '+120 PTS',
        'isDone': false,
      },
    ];

    return SkeuomorphicCard(
      title: 'SKILL RECOVERY TRACK • ADAPTIVE PATHING ENGINE',
      ledColor: OrganicColors.primaryMint,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Based on recent activity analytics, our adaptive AI engine mapped a recommended stepping-stone recovery track to strengthen key fundamentals:',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              height: 1.5,
              color: subtextColor,
            ),
          ),
          const SizedBox(height: 16),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: steps.length,
            itemBuilder: (context, index) {
              final step = steps[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: isDark
                      ? const Color(0xFF132219)
                      : const Color(0xFFF4F7F5),
                  border: Border.all(
                    color: isDark ? OrganicColors.glassBorder : OrganicColors.borderLightGrayGreen,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: OrganicColors.primaryMint,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step['title'] as String,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SkeuomorphicBadge(
                            label: step['status'] as String,
                            color: index == 0 ? OrganicColors.primaryMint : const Color(0xFFD97706),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      step['points'] as String,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        color: OrganicColors.primaryMint,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


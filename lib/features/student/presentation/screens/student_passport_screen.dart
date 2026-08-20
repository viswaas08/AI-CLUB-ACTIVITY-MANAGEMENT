import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/organic_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/student_providers.dart';

class StudentPassportScreen extends ConsumerWidget {
  const StudentPassportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).value;
    final activitiesAsync = ref.watch(userActivitiesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? OrganicColors.textIvoryWhite : OrganicColors.textDarkForest;
    final subtextColor = isDark ? OrganicColors.textSoftMoss : OrganicColors.textSubtleEmerald;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DIGITAL ACTIVITY PASSPORT',
                    style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold, fontSize: 22, color: textColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Official immutable transcript of university activity achievements.',
                    style: TextStyle(fontSize: 13, color: subtextColor),
                  ),
                ],
              ),
              SkeuomorphicButton(
                label: 'DOWNLOAD PASSPORT',
                variant: SkeuoButtonVariant.primary,
                icon: Icons.download_rounded,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Verified Activity Passport PDF requested.'),
                      backgroundColor: OrganicColors.accentEmeraldMedium,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Passport Booklet Header
          SkeuomorphicCard(
            title: 'VERIFIED CREDENTIAL BOOKLET',
            ledColor: OrganicColors.accentEmeraldMedium,
            child: Row(
              children: [
                const Icon(Icons.workspace_premium_rounded, size: 44, color: OrganicColors.accentTerracotta),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName?.toUpperCase() ?? 'STUDENT PASSPORT',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${user?.studentId ?? "2026-CS-8941"} • DEPT: ${user?.departmentId ?? "CS-AI"}',
                        style: TextStyle(fontSize: 12, color: subtextColor),
                      ),
                    ],
                  ),
                ),
                SkeuomorphicBadge(
                  label: '${user?.totalPoints ?? 480} TOTAL PTS',
                  color: OrganicColors.accentEmeraldMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Interactive Timeline Spine
          Text(
            'ACTIVITY TIMELINE LEDGER',
            style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 16),

          activitiesAsync.when(
            data: (activities) {
              if (activities.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Activity History',
                  ledColor: OrganicColors.accentTerracotta,
                  child: Text('Your activity passport timeline is currently empty. Attend events to earn verified entries!'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.white.withValues(alpha: 0.8),
                      border: Border.all(
                        color: isDark ? OrganicColors.glassBorder : OrganicColors.glassBorderLightGreen,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: OrganicColors.accentEmeraldMedium.withValues(alpha: 0.15),
                          ),
                          child: const Icon(Icons.check_circle_rounded, color: OrganicColors.accentEmeraldMedium),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activity.title,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                activity.description,
                                style: TextStyle(fontSize: 12, color: subtextColor),
                              ),
                            ],
                          ),
                        ),
                        SkeuomorphicBadge(
                          label: '+${activity.pointsAwarded} PTS',
                          color: OrganicColors.accentEmeraldMedium,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading activity ledger'),
          ),
        ],
      ),
    );
  }
}

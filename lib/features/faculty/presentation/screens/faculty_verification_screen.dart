import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/faculty_providers.dart';

class FacultyVerificationScreen extends ConsumerWidget {
  const FacultyVerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).value;
    final queueAsync = ref.watch(pendingVerificationQueueProvider);
    final actionState = ref.watch(facultyActionsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MANUAL ACTIVITY VERIFICATION QUEUE',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Review external student claims (hackathons, open source contributions) for departmental point sign-off.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          queueAsync.when(
            data: (items) {
              if (items.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'Verification Queue Empty',
                  ledColor: SkeuoColors.activeGreen,
                  child: Text('No pending external activity claims requiring verification.'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: isDark ? const Color(0xFF1E2430) : const Color(0xFFFFFFFF),
                      border: Border.all(color: SkeuoColors.accentAmber, width: 1.5),
                      boxShadow: SkeuoShadows.raisedLevel2(isDark: isDark),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SkeuomorphicBadge(
                              label: '+${item.pointsAwarded} PTS CLAIM',
                              color: SkeuoColors.accentAmber,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: SkeuomorphicButton(
                                label: 'VERIFY & AWARD PTS',
                                variant: SkeuoButtonVariant.primary,
                                icon: Icons.check_circle_rounded,
                                isLoading: actionState.isLoading,
                                onPressed: user == null
                                    ? null
                                    : () async {
                                        final success = await ref
                                            .read(facultyActionsControllerProvider.notifier)
                                            .verifyStudentActivity(item.id, user.id, true);

                                        if (success && context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Activity Verified & Points Awarded!'),
                                              backgroundColor: SkeuoColors.activeGreen,
                                            ),
                                          );
                                        }
                                      },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SkeuomorphicButton(
                                label: 'FLAG CLAIM',
                                variant: SkeuoButtonVariant.crimson,
                                icon: Icons.flag_rounded,
                                isLoading: actionState.isLoading,
                                onPressed: user == null
                                    ? null
                                    : () async {
                                        final success = await ref
                                            .read(facultyActionsControllerProvider.notifier)
                                            .verifyStudentActivity(item.id, user.id, false);

                                        if (success && context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Activity claim flagged for review.'),
                                              backgroundColor: SkeuoColors.alertRed,
                                            ),
                                          );
                                        }
                                      },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading verification queue'),
          ),
        ],
      ),
    );
  }
}

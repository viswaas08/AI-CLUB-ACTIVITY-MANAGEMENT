import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../gamification/presentation/trophy_unboxing_modal.dart';
import '../../application/student_providers.dart';

class StudentAchievementsScreen extends ConsumerWidget {
  const StudentAchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementsAsync = ref.watch(userAchievementsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '3D TROPHY ROOM & MILESTONES',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Gamification badges unlocked through activity participation and leadership roles.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          achievementsAsync.when(
            data: (achievements) {
              if (achievements.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'Trophy Room Empty',
                  ledColor: SkeuoColors.accentAmber,
                  child: Text('No trophies unlocked yet. Keep participating in campus events to earn badges!'),
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 800 ? 4 : (constraints.maxWidth > 500 ? 3 : 2);
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.0,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: achievements.length,
                    itemBuilder: (context, index) {
                      final item = achievements[index];
                      return GestureDetector(
                        onTap: () {
                          TrophyUnboxingModal.show(
                            context,
                            title: item.title,
                            description: item.description,
                            tier: 'Gold',
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: isDark ? const Color(0xFF1E2430) : const Color(0xFFFFFFFF),
                            border: Border.all(color: SkeuoColors.accentAmber, width: 1.5),
                            boxShadow: SkeuoShadows.raisedLevel2(isDark: isDark),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.emoji_events_rounded, size: 42, color: SkeuoColors.accentAmber),
                              const SizedBox(height: 8),
                              Text(
                                item.title,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              const SkeuomorphicBadge(label: 'UNLOCKED', color: SkeuoColors.activeGreen),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading trophy room'),
          ),
        ],
      ),
    );
  }
}

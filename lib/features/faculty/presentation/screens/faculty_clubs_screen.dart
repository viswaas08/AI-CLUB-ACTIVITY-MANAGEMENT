import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_dialog.dart';
import '../../application/faculty_providers.dart';

class FacultyClubsScreen extends ConsumerWidget {
  const FacultyClubsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubsAsync = ref.watch(facultyDepartmentClubsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ADVISED CLUB SOCIETIES & OVERSIGHT',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Monitor student leadership, review club rosters, and audit activity distributions.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          clubsAsync.when(
            data: (clubs) {
              if (clubs.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Advised Clubs',
                  ledColor: SkeuoColors.accentAmber,
                  child: Text('No student clubs linked to your faculty advisor profile.'),
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 700 ? 2 : 1;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: clubs.length,
                    itemBuilder: (context, index) {
                      final club = clubs[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: isDark ? const Color(0xFF1E2430) : const Color(0xFFFFFFFF),
                          border: Border.all(color: SkeuoColors.primaryBlue.withValues(alpha: 0.5), width: 1.5),
                          boxShadow: SkeuoShadows.raisedLevel2(isDark: isDark),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.groups_rounded, color: SkeuoColors.primaryBlue, size: 26),
                                    const SizedBox(width: 8),
                                    Text(
                                      club.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ],
                                ),
                                SkeuomorphicBadge(
                                  label: '${club.totalMembers} Members',
                                  color: SkeuoColors.primaryBlue,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              club.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Category: ${club.category.name.toUpperCase()}',
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                                SkeuomorphicButton(
                                  label: 'INSPECT ROSTER',
                                  variant: SkeuoButtonVariant.secondary,
                                  icon: Icons.search_rounded,
                                  onPressed: () {
                                    SkeuomorphicDialog.show(
                                      context,
                                      title: 'ROSTER AUDIT • ${club.name}',
                                      message: 'Faculty Advisor Inspection Mode.\nTotal Members: ${club.totalMembers}\nStatus: Active & Verified',
                                      confirmLabel: 'Close Audit',
                                      onConfirm: () {},
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading advised clubs'),
          ),
        ],
      ),
    );
  }
}

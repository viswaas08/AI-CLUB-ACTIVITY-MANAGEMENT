import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/organic_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_tabs.dart';
import '../../application/student_providers.dart';

class StudentLeaderboardScreen extends ConsumerStatefulWidget {
  const StudentLeaderboardScreen({super.key});

  @override
  ConsumerState<StudentLeaderboardScreen> createState() => _StudentLeaderboardScreenState();
}

class _StudentLeaderboardScreenState extends ConsumerState<StudentLeaderboardScreen> {
  int _selectedScopeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final leaderboardAsync = ref.watch(leaderboardStreamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? OrganicColors.textIvoryWhite : OrganicColors.textDarkForest;
    final subtextColor = isDark ? OrganicColors.textSoftMoss : OrganicColors.textSubtleEmerald;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CAMPUS RANKINGS & LEADERBOARD',
            style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold, fontSize: 22, color: textColor),
          ),
          const SizedBox(height: 4),
          Text(
            'Live overall campus and departmental student rankings by activity points.',
            style: TextStyle(fontSize: 13, color: subtextColor),
          ),
          const SizedBox(height: 20),

          SkeuomorphicTab(
            tabs: const ['Overall Campus', 'Departmental Track', 'Club Societies', 'Monthly Track'],
            selectedIndex: _selectedScopeIndex,
            onTabSelected: (idx) => setState(() => _selectedScopeIndex = idx),
          ),
          const SizedBox(height: 24),

          leaderboardAsync.when(
            data: (users) {
              if (users.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Rankings Data',
                  ledColor: OrganicColors.accentTerracotta,
                  child: Text('Leaderboard data is compiling.'),
                );
              }

              final top3 = users.take(3).toList();
              final remainder = users.skip(3).toList();

              return Column(
                children: [
                  // Gold / Silver / Bronze Organic Pedestals
                  if (top3.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.white.withValues(alpha: 0.8),
                        border: Border.all(
                          color: isDark ? OrganicColors.glassBorder : OrganicColors.glassBorderLightGreen,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // 2nd Place (Silver)
                          if (top3.length > 1)
                            _buildPedestal(
                              rank: 2,
                              name: top3[1].displayName ?? 'Student 2',
                              points: top3[1].totalPoints,
                              color: const Color(0xFF64748B),
                              height: 100,
                            ),
                          // 1st Place (Gold)
                          _buildPedestal(
                            rank: 1,
                            name: top3[0].displayName ?? 'Student 1',
                            points: top3[0].totalPoints,
                            color: OrganicColors.accentTerracotta,
                            height: 130,
                          ),
                          // 3rd Place (Bronze)
                          if (top3.length > 2)
                            _buildPedestal(
                              rank: 3,
                              name: top3[2].displayName ?? 'Student 3',
                              points: top3[2].totalPoints,
                              color: OrganicColors.accentClay,
                              height: 80,
                            ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),

                  // Remaining Rankings List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: remainder.length,
                    itemBuilder: (context, index) {
                      final item = remainder[index];
                      final rank = index + 4;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.75),
                          border: Border.all(
                            color: isDark ? OrganicColors.glassBorder : OrganicColors.glassBorderLightGreen,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '#$rank',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.displayName ?? 'Student',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor),
                                  ),
                                  Text(
                                    item.departmentId ?? 'CS-AI',
                                    style: TextStyle(fontSize: 12, color: subtextColor),
                                  ),
                                ],
                              ),
                            ),
                            SkeuomorphicBadge(
                              label: '${item.totalPoints} PTS',
                              color: OrganicColors.accentEmeraldMedium,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading leaderboard'),
          ),
        ],
      ),
    );
  }

  Widget _buildPedestal({
    required int rank,
    required String name,
    required int points,
    required Color color,
    required double height,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? OrganicColors.textIvoryWhite : OrganicColors.textDarkForest;

    return Column(
      children: [
        Icon(Icons.military_tech_rounded, color: color, size: 34),
        const SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          '$points Pts',
          style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: 76,
          height: height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            color: color.withValues(alpha: isDark ? 0.25 : 0.15),
            border: Border.all(color: color, width: 1.5),
          ),
          child: Center(
            child: Text(
              '#$rank',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/organic_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_stat_card.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../proposals/presentation/proposal_list_widget.dart';
import '../../application/student_providers.dart';
import '../widgets/adaptive_path_widget.dart';

class StudentDashboardScreen extends ConsumerWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).value;
    final joinedClubsAsync = ref.watch(userJoinedClubsProvider);
    final upcomingEventsAsync = ref.watch(upcomingEventsProvider);
    final activitiesAsync = ref.watch(userActivitiesProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headingColor = isDark ? OrganicColors.textIvoryWhite : OrganicColors.textForestCharcoal;
    final bodyColor = isDark ? OrganicColors.textSoftMoss : OrganicColors.textSlateGreen;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, ${user?.displayName ?? "Student"}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      color: headingColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      SkeuomorphicBadge(
                        label: user?.departmentId ?? 'CS-AI',
                        color: OrganicColors.primaryMint,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Roll No: ${user?.studentId ?? "2026-CS-8941"}',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          color: bodyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: isDark
                      ? const Color(0xFF1A2E22)
                      : OrganicColors.primaryMint.withValues(alpha: 0.10),
                  border: Border.all(
                    color: isDark ? OrganicColors.glassBorder : OrganicColors.primaryMint.withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department_rounded,
                      color: OrganicColors.primaryMint,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '3 DAY STREAK',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: 0.5,
                        color: isDark ? Colors.white : OrganicColors.primaryMint,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
              return GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                shrinkWrap: true,
                childAspectRatio: 2.1,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SkeuomorphicStatCard(
                    title: 'Total Activity Points',
                    value: (user?.totalPoints ?? 480).toDouble(),
                    suffix: ' PTS',
                    icon: Icons.workspace_premium_rounded,
                    accentColor: OrganicColors.primaryMint,
                  ),
                  const SkeuomorphicStatCard(
                    title: 'Campus Ranking',
                    value: 12,
                    suffix: ' #',
                    icon: Icons.leaderboard_rounded,
                    accentColor: OrganicColors.primaryMintSoft,
                  ),
                  SkeuomorphicStatCard(
                    title: 'Activities Attended',
                    value: (activitiesAsync.value?.length ?? 14).toDouble(),
                    suffix: ' EVENTS',
                    icon: Icons.event_available_rounded,
                    accentColor: OrganicColors.primaryMint,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 28),

          SkeuomorphicCard(
            title: 'ENROLLED CLUB SOCIETIES',
            ledColor: OrganicColors.primaryMint,
            actions: [
              SkeuomorphicButton(
                label: 'EXPLORE CLUBS',
                variant: SkeuoButtonVariant.secondary,
                height: 34.0,
                onPressed: () => context.go('/student/clubs'),
              ),
            ],
            child: joinedClubsAsync.when(
              data: (clubs) {
                if (clubs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'You have not joined any club societies yet.',
                          style: TextStyle(fontFamily: 'Inter', color: bodyColor),
                        ),
                        SkeuomorphicButton(
                          label: 'Join First Club',
                          variant: SkeuoButtonVariant.primary,
                          height: 34.0,
                          onPressed: () => context.go('/student/clubs'),
                        ),
                      ],
                    ),
                  );
                }

                return SizedBox(
                  height: 94,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: clubs.length,
                    itemBuilder: (context, index) {
                      final club = clubs[index];
                      return Container(
                        width: 230,
                        margin: const EdgeInsets.only(right: 14),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: isDark ? const Color(0xFF132219) : const Color(0xFFF4F7F5),
                          border: Border.all(
                            color: isDark ? OrganicColors.glassBorder : OrganicColors.borderLightGrayGreen,
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              club.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: headingColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${club.totalMembers} Members • ${club.category.label}',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                color: bodyColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (err, stack) => const Text('Error loading joined clubs'),
            ),
          ),
          const SizedBox(height: 28),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: SkeuomorphicCard(
                  title: 'UPCOMING CLUB EVENTS',
                  ledColor: OrganicColors.primaryMint,
                  actions: [
                    SkeuomorphicButton(
                      label: 'ALL EVENTS',
                      variant: SkeuoButtonVariant.secondary,
                      height: 34.0,
                      onPressed: () => context.go('/student/events'),
                    ),
                  ],
                  child: upcomingEventsAsync.when(
                    data: (events) {
                      if (events.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'No upcoming events scheduled right now.',
                            style: TextStyle(fontFamily: 'Inter', color: bodyColor),
                          ),
                        );
                      }

                      return Column(
                        children: events.take(3).map((event) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: isDark ? const Color(0xFF132219) : const Color(0xFFF4F7F5),
                              border: Border.all(
                                color: isDark ? OrganicColors.glassBorder : OrganicColors.borderLightGrayGreen,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: OrganicColors.primaryMint.withValues(alpha: 0.12),
                                  ),
                                  child: const Icon(
                                    Icons.event_note_rounded,
                                    color: OrganicColors.primaryMint,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.title,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: headingColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Yield: +${event.basePoints} Activity Pts • Mode: ${event.mode.name}',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          color: bodyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SkeuomorphicButton(
                                  label: 'DETAILS',
                                  variant: SkeuoButtonVariant.primary,
                                  height: 34.0,
                                  onPressed: () => context.go('/student/events/${event.id}'),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                    loading: () => const LinearProgressIndicator(),
                    error: (err, stack) => const Text('Error loading events'),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: SkeuomorphicCard(
                  title: 'AI RECOMMENDED FOR YOU',
                  ledColor: OrganicColors.primaryMint,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.psychology_rounded, color: OrganicColors.primaryMint, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            '94% MATCH SCORE',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: OrganicColors.primaryMint,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Generative AI & LLM Fine-Tuning Bootcamp',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: headingColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Based on your Computer Science & AI department track and interest in deep learning.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          height: 1.4,
                          color: bodyColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SkeuomorphicButton(
                        label: 'VIEW RECOMMENDATION',
                        variant: SkeuoButtonVariant.secondary,
                        height: 36.0,
                        width: double.infinity,
                        onPressed: () => context.go('/student/events'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          const AdaptivePathWidget(),
          const SizedBox(height: 28),

          const ProposalListWidget(),
        ],
      ),
    );
  }
}

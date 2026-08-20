import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_stat_card.dart';
import '../../application/club_providers.dart';

class ClubDashboardScreen extends ConsumerWidget {
  const ClubDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeClubAsync = ref.watch(activeAdminClubProvider);
    final eventsAsync = ref.watch(clubEventsProvider);
    final membersAsync = ref.watch(clubMembersProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          activeClubAsync.when(
            data: (club) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${club?.name.toUpperCase() ?? "CLUB"} OPERATIONS',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          SkeuomorphicBadge(
                            label: club?.category.label ?? 'TECHNICAL',
                            color: SkeuoColors.primaryBlue,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'DEPT: ${club?.departmentId ?? "CS-AI"} • ADVISOR: Dr. Turing',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SkeuomorphicButton(
                    label: '+ NEW EVENT',
                    variant: SkeuoButtonVariant.primary,
                    icon: Icons.add_rounded,
                    onPressed: () => context.go('/club/events'),
                  ),
                ],
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (err, stack) => const Text('Error loading active club context'),
          ),
          const SizedBox(height: 24),

          // Overview Panel Gauges Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 4 : (constraints.maxWidth > 500 ? 2 : 1);
              final totalMembers = membersAsync.value?.length ?? 48;
              final totalEvents = eventsAsync.value?.length ?? 6;

              return GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                childAspectRatio: 2.0,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SkeuomorphicStatCard(
                    title: 'TOTAL MEMBERS',
                    value: totalMembers.toDouble(),
                    suffix: 'MEMBERS',
                    icon: Icons.people_alt_rounded,
                    accentColor: SkeuoColors.primaryBlue,
                  ),
                  const SkeuomorphicStatCard(
                    title: 'ACTIVE REGISTRATIONS',
                    value: 124,
                    suffix: 'STUDENTS',
                    icon: Icons.how_to_reg_rounded,
                    accentColor: SkeuoColors.activeGreen,
                  ),
                  const SkeuomorphicStatCard(
                    title: 'EVENT SUCCESS RATE',
                    value: 96,
                    suffix: '%',
                    icon: Icons.task_alt_rounded,
                    accentColor: SkeuoColors.accentAmber,
                  ),
                  SkeuomorphicStatCard(
                    title: 'POINTS DISTRIBUTED',
                    value: (totalEvents * 150).toDouble(),
                    suffix: 'PTS',
                    icon: Icons.workspace_premium_rounded,
                    accentColor: SkeuoColors.activeGreen,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          // Active Event Monitor Quick Access Card
          SkeuomorphicCard(
            title: 'ACTIVE EVENT & LIVE ATTENDANCE MONITOR',
            ledColor: SkeuoColors.activeGreen,
            child: eventsAsync.when(
              data: (events) {
                if (events.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text('No events created yet. Tap "+ NEW EVENT" to schedule one!'),
                  );
                }

                final upcoming = events.first;
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: SkeuoColors.activeGreen.withValues(alpha: 0.15),
                        border: Border.all(color: SkeuoColors.activeGreen, width: 2),
                      ),
                      child: const Icon(Icons.sensors_rounded, color: SkeuoColors.activeGreen, size: 36),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            upcoming.title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Status: ${upcoming.status.name.toUpperCase()} • Registered: ${upcoming.registeredCount} / ${upcoming.maxSeats ?? 100}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SkeuomorphicButton(
                      label: 'LAUNCH ATTENDANCE TERMINAL',
                      variant: SkeuoButtonVariant.primary,
                      icon: Icons.qr_code_scanner_rounded,
                      onPressed: () => context.go('/club/attendance'),
                    ),
                  ],
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (err, stack) => const Text('Error loading events'),
            ),
          ),
        ],
      ),
    );
  }
}

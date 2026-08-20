import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../application/faculty_providers.dart';
import '../widgets/engagement_radar_widget.dart';

class FacultyDashboardScreen extends ConsumerWidget {
  const FacultyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingEvents = ref.watch(pendingEventApprovalsProvider).value ?? [];
    final pendingVerifications = ref.watch(pendingVerificationQueueProvider).value ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FACULTY ADVISOR CONTROL CENTER',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Departmental activity health overview, action items, and event approval pipeline.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Tactile Action Center
          SkeuomorphicCard(
            title: 'ACTION CENTER • PENDING DECISIONS',
            ledColor: SkeuoColors.accentAmber,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.pending_actions_rounded, color: SkeuoColors.accentAmber, size: 28),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${pendingEvents.length} Event Proposals Pending',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                'Awaiting departmental faculty review & point approval.',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SkeuomorphicButton(
                        label: 'OPEN EVENT PIPELINE',
                        variant: SkeuoButtonVariant.amber,
                        icon: Icons.approval_rounded,
                        onPressed: () => context.go('/faculty/events'),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified_user_rounded, color: SkeuoColors.primaryBlue, size: 28),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${pendingVerifications.length} External Claims Awaiting Sign-off',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                'Student off-campus hackathons and volunteer claims.',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SkeuomorphicButton(
                        label: 'REVIEW VERIFICATION QUEUE',
                        variant: SkeuoButtonVariant.primary,
                        icon: Icons.fact_check_rounded,
                        onPressed: () => context.go('/faculty/verification'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Early Warning Radar Panel (Phase 17)
          const EngagementRadarWidget(),
          const SizedBox(height: 24),

          // Department Health Gauges
          Row(
            children: [
              Expanded(
                flex: 3,
                child: SkeuomorphicCard(
                  title: 'DEPARTMENTAL PARTICIPATION HEALTH',
                  ledColor: SkeuoColors.activeGreen,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 4,
                            centerSpaceRadius: 30,
                            sections: [
                              PieChartSectionData(value: 65, color: SkeuoColors.activeGreen, radius: 25, title: '65%'),
                              PieChartSectionData(value: 25, color: SkeuoColors.primaryBlue, radius: 25, title: '25%'),
                              PieChartSectionData(value: 10, color: SkeuoColors.accentAmber, radius: 25, title: '10%'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CS & AI Active Students: 340', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            SizedBox(height: 6),
                            SkeuomorphicBadge(label: 'HEALTH: OPTIMAL (88%)', color: SkeuoColors.activeGreen),
                            SizedBox(height: 10),
                            Text(
                              '88% of registered departmental students attended at least 1 workshop this term.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                flex: 2,
                child: SkeuomorphicCard(
                  title: 'QUICK METRICS LEDGER',
                  ledColor: SkeuoColors.primaryBlue,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Active Societies:', style: TextStyle(fontSize: 12)),
                          Text('4 Clubs', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Certificates Issued:', style: TextStyle(fontSize: 12)),
                          Text('148 Valid', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Points Awarded:', style: TextStyle(fontSize: 12)),
                          Text('48,500 PTS', style: TextStyle(fontWeight: FontWeight.bold, color: SkeuoColors.activeGreen)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

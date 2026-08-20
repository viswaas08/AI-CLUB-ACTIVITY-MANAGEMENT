import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';

class ClubAnalyticsScreen extends ConsumerWidget {
  const ClubAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CLUB ANALYTICS & RETENTION METRICS',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Interactive participation metrics, member growth curves, and event turnout analytics.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Member Growth Line Chart Card
          SkeuomorphicCard(
            title: 'MEMBER GROWTH METRIC (PAST 6 MONTHS)',
            ledColor: SkeuoColors.activeGreen,
            child: SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true, drawVerticalLine: false),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                          final idx = value.toInt();
                          if (idx >= 0 && idx < months.length) {
                            return Text(months[idx], style: const TextStyle(fontSize: 10));
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 12),
                        FlSpot(1, 18),
                        FlSpot(2, 25),
                        FlSpot(3, 32),
                        FlSpot(4, 40),
                        FlSpot(5, 54),
                      ],
                      isCurved: true,
                      color: SkeuoColors.activeGreen,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: SkeuoColors.activeGreen.withValues(alpha: 0.15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              // Event Turnout vs Registrations Grouped Bar Chart
              Expanded(
                flex: 3,
                child: SkeuomorphicCard(
                  title: 'TURNOUT VS. REGISTRATIONS',
                  ledColor: SkeuoColors.primaryBlue,
                  child: SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: false),
                        barGroups: [
                          BarChartGroupData(
                            x: 0,
                            barRods: [
                              BarChartRodData(toY: 45, color: SkeuoColors.primaryBlue, width: 12),
                              BarChartRodData(toY: 40, color: SkeuoColors.activeGreen, width: 12),
                            ],
                          ),
                          BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(toY: 60, color: SkeuoColors.primaryBlue, width: 12),
                              BarChartRodData(toY: 58, color: SkeuoColors.activeGreen, width: 12),
                            ],
                          ),
                          BarChartGroupData(
                            x: 2,
                            barRods: [
                              BarChartRodData(toY: 80, color: SkeuoColors.primaryBlue, width: 12),
                              BarChartRodData(toY: 72, color: SkeuoColors.activeGreen, width: 12),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Category Distribution Donut Chart
              Expanded(
                flex: 2,
                child: SkeuomorphicCard(
                  title: 'EVENT CATEGORY SHARE',
                  ledColor: SkeuoColors.accentAmber,
                  child: SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 40,
                        sections: [
                          PieChartSectionData(
                            value: 45,
                            title: 'Workshops',
                            color: SkeuoColors.primaryBlue,
                            radius: 40,
                            titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          PieChartSectionData(
                            value: 35,
                            title: 'Hackathons',
                            color: SkeuoColors.activeGreen,
                            radius: 40,
                            titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          PieChartSectionData(
                            value: 20,
                            title: 'Contests',
                            color: SkeuoColors.accentAmber,
                            radius: 40,
                            titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
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

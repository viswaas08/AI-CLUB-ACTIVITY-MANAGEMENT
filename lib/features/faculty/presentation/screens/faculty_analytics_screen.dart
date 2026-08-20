import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';

class FacultyAnalyticsScreen extends ConsumerWidget {
  const FacultyAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DEPARTMENTAL ANALYTICS & OSCILLOSCOPE',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Oscilloscope-style attendance frequency curves and participation breakdowns across academic years.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Analog Oscilloscope Line Chart Card
          SkeuomorphicCard(
            title: 'ANALOG OSCILLOSCOPE • SEMESTER ATTENDANCE FREQUENCY',
            ledColor: SkeuoColors.activeGreen,
            child: SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true, drawVerticalLine: true),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const weeks = ['Wk 1', 'Wk 3', 'Wk 6', 'Wk 9', 'Wk 12', 'Wk 15'];
                          final idx = value.toInt();
                          if (idx >= 0 && idx < weeks.length) {
                            return Text(weeks[idx], style: const TextStyle(fontSize: 10));
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
                        FlSpot(0, 80),
                        FlSpot(1, 140),
                        FlSpot(2, 220),
                        FlSpot(3, 190),
                        FlSpot(4, 310),
                        FlSpot(5, 340),
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
              // Participation Bar Chart across Academic Years
              Expanded(
                flex: 3,
                child: SkeuomorphicCard(
                  title: 'PARTICIPATION BY ACADEMIC YEAR',
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
                            barRods: [BarChartRodData(toY: 65, color: SkeuoColors.primaryBlue, width: 14)],
                          ),
                          BarChartGroupData(
                            x: 1,
                            barRods: [BarChartRodData(toY: 88, color: SkeuoColors.primaryBlue, width: 14)],
                          ),
                          BarChartGroupData(
                            x: 2,
                            barRods: [BarChartRodData(toY: 110, color: SkeuoColors.primaryBlue, width: 14)],
                          ),
                          BarChartGroupData(
                            x: 3,
                            barRods: [BarChartRodData(toY: 77, color: SkeuoColors.primaryBlue, width: 14)],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Category Share Pie Chart
              Expanded(
                flex: 2,
                child: SkeuomorphicCard(
                  title: 'ACTIVITY SHARE',
                  ledColor: SkeuoColors.accentAmber,
                  child: SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 35,
                        sections: [
                          PieChartSectionData(value: 50, title: 'AI Workshops', color: SkeuoColors.primaryBlue, radius: 35, titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                          PieChartSectionData(value: 30, title: 'Hackathons', color: SkeuoColors.activeGreen, radius: 35, titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                          PieChartSectionData(value: 20, title: 'Symposiums', color: SkeuoColors.accentAmber, radius: 35, titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
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

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';

class SkeuomorphicStatCard extends StatelessWidget {
  final String title;
  final double value;
  final String suffix;
  final IconData icon;
  final Color accentColor;
  final List<FlSpot>? chartSpots;

  const SkeuomorphicStatCard({
    super.key,
    required this.title,
    required this.value,
    this.suffix = '',
    required this.icon,
    this.accentColor = OrganicColors.primaryMint,
    this.chartSpots,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? OrganicColors.textIvoryWhite : OrganicColors.textForestCharcoal;
    final subtextColor = isDark ? OrganicColors.textSoftMoss : OrganicColors.textSlateGreen;

    final defaultSpots = chartSpots ??
        const [
          FlSpot(0, 3),
          FlSpot(1, 4),
          FlSpot(2, 6),
          FlSpot(3, 5),
          FlSpot(4, 8),
          FlSpot(5, 7),
          FlSpot(6, 10),
        ];

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: isDark ? OrganicColors.glassSurfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isDark ? OrganicColors.glassBorder : OrganicColors.borderLightGrayGreen,
          width: 1.0,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: const Color(0xFF1A2E22).withValues(alpha: 0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: subtextColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: isDark ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, size: 16, color: accentColor),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${value.toInt()}$suffix',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: defaultSpots,
                    isCurved: true,
                    color: accentColor,
                    barWidth: 2.0,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: accentColor.withValues(alpha: 0.08),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


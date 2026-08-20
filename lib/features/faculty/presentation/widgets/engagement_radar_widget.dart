import 'package:flutter/material.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';

class EngagementRadarWidget extends StatefulWidget {
  const EngagementRadarWidget({super.key});

  @override
  State<EngagementRadarWidget> createState() => _EngagementRadarWidgetState();
}

class _EngagementRadarWidgetState extends State<EngagementRadarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _radarPulseController;

  @override
  void initState() {
    super.initState();
    _radarPulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _radarPulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SkeuomorphicCard(
      title: 'EARLY WARNING RADAR • ENGAGEMENT DROP-OFF MONITOR',
      ledColor: SkeuoColors.alertRed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Pulsing Radar Sweep Indicator
              AnimatedBuilder(
                animation: _radarPulseController,
                builder: (context, child) {
                  return Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: SkeuoColors.alertRed.withValues(alpha: 0.15 + (_radarPulseController.value * 0.25)),
                      border: Border.all(color: SkeuoColors.alertRed, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: SkeuoColors.alertRed.withValues(alpha: _radarPulseController.value),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.radar_rounded, color: SkeuoColors.alertRed, size: 22),
                  );
                },
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2 At-Risk Students Detected in CSE Department',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'High previous activity (>200 PTS), zero event check-ins in the last 30 days.',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // At-Risk Student Item
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDark ? const Color(0xFF1E2430) : const Color(0xFFFFFFFF),
              border: Border.all(color: SkeuoColors.accentAmber, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Student: Marcus Vance (2026-CS-4091)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text('Last Active: 34 Days Ago • Prev Points: 340 PTS', style: TextStyle(fontSize: 11)),
                  ],
                ),
                SkeuomorphicButton(
                  label: 'SEND PING',
                  variant: SkeuoButtonVariant.amber,
                  icon: Icons.send_rounded,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Mentorship ping sent to Marcus Vance!'),
                        backgroundColor: SkeuoColors.activeGreen,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/skeuo_theme.dart';
import '../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../shared/widgets/skeuo/skeuo_card.dart';

class AttendanceSuccessDialog extends StatefulWidget {
  final int pointsAwarded;
  final int newTotalPoints;
  final int streakDays;

  const AttendanceSuccessDialog({
    super.key,
    required this.pointsAwarded,
    required this.newTotalPoints,
    required this.streakDays,
  });

  static Future<void> show(
    BuildContext context, {
    required int pointsAwarded,
    required int newTotalPoints,
    required int streakDays,
  }) {
    return showDialog(
      context: context,
      builder: (_) => AttendanceSuccessDialog(
        pointsAwarded: pointsAwarded,
        newTotalPoints: newTotalPoints,
        streakDays: streakDays,
      ),
    );
  }

  @override
  State<AttendanceSuccessDialog> createState() => _AttendanceSuccessDialogState();
}

class _AttendanceSuccessDialogState extends State<AttendanceSuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: SkeuomorphicCard(
          title: 'ATTENDANCE VERIFIED',
          ledColor: SkeuoColors.activeGreen,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Metallic Embossed Seal
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SkeuoColors.activeGreen.withValues(alpha: 0.15),
                  border: Border.all(color: SkeuoColors.activeGreen, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: SkeuoColors.activeGreen,
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.verified_rounded, size: 54, color: SkeuoColors.activeGreen),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'CHECK-IN SUCCESSFUL!',
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Your attendance record has been cryptographically confirmed.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 20),

              // Rolling Points Counter Box
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: widget.pointsAwarded.toDouble()),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutCubic,
                builder: (context, val, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: SkeuoColors.activeGreen.withValues(alpha: 0.15),
                      border: Border.all(color: SkeuoColors.activeGreen),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.stars_rounded, color: SkeuoColors.accentAmber, size: 28),
                        const SizedBox(width: 10),
                        Text(
                          '+${val.toInt()} PTS EARNED',
                          style: const TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: SkeuoColors.activeGreen,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SkeuomorphicBadge(
                    label: '${widget.streakDays} DAY STREAK',
                    color: SkeuoColors.accentAmber,
                  ),
                  const SizedBox(width: 10),
                  SkeuomorphicBadge(
                    label: 'TOTAL: ${widget.newTotalPoints} PTS',
                    color: SkeuoColors.primaryBlue,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              SkeuomorphicButton(
                label: 'CONTINUE TO PASSPORT',
                variant: SkeuoButtonVariant.primary,
                width: double.infinity,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/skeuo_theme.dart';
import '../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../auth/application/auth_providers.dart';
import '../../gamification/data/gamification_service.dart';
import 'attendance_success_dialog.dart';

class QRAttendanceScannerModal extends ConsumerStatefulWidget {
  final String eventId;
  const QRAttendanceScannerModal({super.key, required this.eventId});

  static Future<void> show(BuildContext context, {required String eventId}) {
    return showDialog(
      context: context,
      builder: (_) => QRAttendanceScannerModal(eventId: eventId),
    );
  }

  @override
  ConsumerState<QRAttendanceScannerModal> createState() => _QRAttendanceScannerModalState();
}

class _QRAttendanceScannerModalState extends ConsumerState<QRAttendanceScannerModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _sweepController;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _sweepController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _sweepController.dispose();
    super.dispose();
  }

  Future<void> _handleScanToken(String token) async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;

    setState(() => _isScanning = true);

    final gamification = ref.read(gamificationServiceProvider);
    final result = await gamification.verifyAndRecordAttendance(
      sessionId: '${widget.eventId}_session',
      scannedToken: token,
      eventId: widget.eventId,
      userId: user.id,
    );

    if (mounted) {
      Navigator.of(context).pop(); // Close Scanner Modal

      // Trigger Tactile Success Feedback Overlay
      AttendanceSuccessDialog.show(
        context,
        pointsAwarded: result.pointsAwarded,
        newTotalPoints: result.newTotalPoints,
        streakDays: result.streakDays,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: SkeuomorphicCard(
        title: 'SCAN DYNAMIC ATTENDANCE QR',
        ledColor: SkeuoColors.activeGreen,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Align terminal screen QR token within the frame below:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Scanning Viewport with Laser Sweep Animation
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                border: Border.all(color: SkeuoColors.activeGreen, width: 2),
                boxShadow: SkeuoShadows.sunkenLevel1(isDark: isDark),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.qr_code_scanner_rounded,
                      size: 140,
                      color: SkeuoColors.activeGreen.withValues(alpha: 0.25),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _sweepController,
                    builder: (context, child) {
                      return Positioned(
                        top: _sweepController.value * 220,
                        left: 10,
                        right: 10,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: SkeuoColors.activeGreen,
                            boxShadow: [
                              BoxShadow(
                                color: SkeuoColors.activeGreen.withValues(alpha: 0.8),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            if (_isScanning)
              const CircularProgressIndicator()
            else
              SkeuomorphicButton(
                label: 'SIMULATE QR TOKEN SCAN',
                variant: SkeuoButtonVariant.primary,
                icon: Icons.qr_code_rounded,
                width: double.infinity,
                onPressed: () => _handleScanToken('TOKEN-104928'),
              ),
          ],
        ),
      ),
    );
  }
}

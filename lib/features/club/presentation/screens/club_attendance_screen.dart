import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/club_providers.dart';

class ClubAttendanceScreen extends ConsumerStatefulWidget {
  const ClubAttendanceScreen({super.key});

  @override
  ConsumerState<ClubAttendanceScreen> createState() => _ClubAttendanceScreenState();
}

class _ClubAttendanceScreenState extends ConsumerState<ClubAttendanceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _countdownController;
  Timer? _tokenRefreshTimer;
  int _currentTokenId = 104928;

  @override
  void initState() {
    super.initState();
    _countdownController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    _tokenRefreshTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      setState(() {
        _currentTokenId = 100000 + (DateTime.now().millisecondsSinceEpoch % 900000);
      });
    });
  }

  @override
  void dispose() {
    _countdownController.dispose();
    _tokenRefreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    final selectedClubId = ref.watch(selectedAdminClubIdProvider);
    final eventsAsync = ref.watch(clubEventsProvider);
    final activeSessionAsync = ref.watch(clubAttendanceSessionProvider);
    final actionState = ref.watch(clubAdminActionsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final isSessionActive = activeSessionAsync.value != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LIVE DYNAMIC QR ATTENDANCE TERMINAL',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Anti-spoofing rotating QR token generator refreshing every 15 seconds.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: SkeuomorphicCard(
                  title: isSessionActive ? 'SESSION ACTIVE • DYNAMIC QR TOKEN' : 'ATTENDANCE TERMINAL IDLE',
                  ledColor: isSessionActive ? SkeuoColors.activeGreen : SkeuoColors.alertRed,
                  child: Column(
                    children: [
                      if (isSessionActive) ...[
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: _countdownController,
                              builder: (context, child) {
                                return SizedBox(
                                  width: 220,
                                  height: 220,
                                  child: CircularProgressIndicator(
                                    value: 1.0 - _countdownController.value,
                                    strokeWidth: 6,
                                    color: SkeuoColors.activeGreen,
                                    backgroundColor: isDark ? const Color(0xFF262C3A) : const Color(0xFFCBD5E1),
                                  ),
                                );
                              },
                            ),
                            Container(
                              width: 190,
                              height: 190,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0xFFFFFFFF),
                                border: Border.all(color: SkeuoColors.activeGreen, width: 3),
                                boxShadow: SkeuoShadows.raisedLevel2(isDark: isDark),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.qr_code_2_rounded, size: 110, color: Color(0xFF0F172A)),
                                  const SizedBox(height: 4),
                                  Text(
                                    'TOKEN: $_currentTokenId',
                                    style: const TextStyle(
                                      fontFamily: 'Orbitron',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const SkeuomorphicBadge(
                          label: 'REFRESHING EVERY 15 SECONDS',
                          color: SkeuoColors.activeGreen,
                        ),
                      ] else ...[
                        const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              Icon(Icons.power_settings_new_rounded, size: 64, color: SkeuoColors.alertRed),
                              SizedBox(height: 12),
                              Text(
                                'Attendance Terminal Offline',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text('Select an event and activate the lever to start receiving check-ins.'),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SkeuomorphicCard(
                      title: 'SESSION CONTROL LEVER',
                      ledColor: SkeuoColors.accentAmber,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          eventsAsync.when(
                            data: (events) {
                              if (events.isEmpty) return const Text('No active events to start session.');
                              final upcoming = events.first;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Target Event: ${upcoming.title}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                  const SizedBox(height: 16),
                                  SkeuomorphicButton(
                                    label: isSessionActive ? 'TERMINATE SESSION' : 'START ATTENDANCE LEVER',
                                    variant: isSessionActive ? SkeuoButtonVariant.crimson : SkeuoButtonVariant.primary,
                                    icon: isSessionActive ? Icons.stop_rounded : Icons.play_arrow_rounded,
                                    isLoading: actionState.isLoading,
                                    width: double.infinity,
                                    onPressed: user == null || selectedClubId == null
                                        ? null
                                        : () {
                                            ref
                                                .read(clubAdminActionsControllerProvider.notifier)
                                                .startAttendanceSession(
                                                  eventId: upcoming.id,
                                                  clubId: selectedClubId,
                                                  createdBy: user.id,
                                                );
                                          },
                                  ),
                                ],
                              );
                            },
                            loading: () => const LinearProgressIndicator(),
                            error: (err, stack) => const Text('Error loading events'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    SkeuomorphicCard(
                      title: 'LIVE CHECK-IN TICKER STREAM',
                      ledColor: SkeuoColors.primaryBlue,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle_rounded, color: SkeuoColors.activeGreen, size: 18),
                              SizedBox(width: 8),
                              Text('Student #2026-CS-8941 verified (Just now)', style: TextStyle(fontSize: 11)),
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(Icons.check_circle_rounded, color: SkeuoColors.activeGreen, size: 18),
                              SizedBox(width: 8),
                              Text('Student #2026-AI-1042 verified (2m ago)', style: TextStyle(fontSize: 11)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

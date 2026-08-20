import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_progress.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../events/data/repositories/event_repository.dart';
import '../../../events/domain/models/event_model.dart';
import '../../../attendance/presentation/qr_attendance_scanner_modal.dart';
import '../../application/student_providers.dart';

class EventDetailScreen extends ConsumerWidget {
  final String eventId;
  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).value;
    final eventRepo = ref.watch(eventRepositoryProvider);
    final userRegistrationsAsync = ref.watch(userRegistrationsProvider);
    final actionState = ref.watch(studentActionsControllerProvider);

    final isRegistered = userRegistrationsAsync.value?.any((r) => r.eventId == eventId) ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('EVENT PROFILE & REGISTRATION'),
      ),
      body: FutureBuilder<EventModel?>(
        future: eventRepo.getEventById(eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final event = snapshot.data;
          if (event == null) {
            return const Center(child: Text('Event details not found.'));
          }

          final maxSeats = event.maxSeats ?? 100;
          final capacityRatio = (event.registeredCount / maxSeats).clamp(0.0, 1.0);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeuomorphicCard(
                  title: event.category.name.toUpperCase(),
                  ledColor: SkeuoColors.activeGreen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              event.title,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
                            ),
                          ),
                          SkeuomorphicBadge(
                            label: '+${event.basePoints} PTS',
                            color: SkeuoColors.accentAmber,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        event.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 20),

                      // Capacity Meter
                      Text(
                        'REGISTRATION CAPACITY METRIC',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 6),
                      SkeuomorphicProgress(
                        progress: capacityRatio,
                        label: '${event.registeredCount} / $maxSeats Seats Reserved',
                        barColor: capacityRatio > 0.8 ? SkeuoColors.alertRed : SkeuoColors.activeGreen,
                      ),
                      const SizedBox(height: 24),

                      // Registration Trigger
                      SkeuomorphicButton(
                        label: isRegistered ? 'REGISTRATION CONFIRMED' : 'REGISTER FOR EVENT',
                        variant: isRegistered ? SkeuoButtonVariant.secondary : SkeuoButtonVariant.primary,
                        icon: isRegistered ? Icons.verified_rounded : Icons.app_registration_rounded,
                        isLoading: actionState.isLoading,
                        width: double.infinity,
                        onPressed: isRegistered || user == null
                            ? null
                            : () async {
                                final success = await ref
                                    .read(studentActionsControllerProvider.notifier)
                                    .registerForEvent(
                                      eventId: event.id,
                                      userId: user.id,
                                      clubId: event.clubId,
                                    );

                                if (success && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Registered for event successfully!'),
                                      backgroundColor: SkeuoColors.activeGreen,
                                    ),
                                  );
                                }
                              },
                      ),
                      const SizedBox(height: 16),

                      // Live QR Scan Button
                      SkeuomorphicButton(
                        label: 'SCAN ATTENDANCE QR TOKEN',
                        variant: SkeuoButtonVariant.amber,
                        icon: Icons.qr_code_scanner_rounded,
                        width: double.infinity,
                        onPressed: () {
                          QRAttendanceScannerModal.show(context, eventId: event.id);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

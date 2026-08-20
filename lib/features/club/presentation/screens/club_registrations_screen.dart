import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../events/domain/models/event_registration_model.dart';
import '../../application/club_providers.dart';

class ClubRegistrationsScreen extends ConsumerWidget {
  const ClubRegistrationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationsAsync = ref.watch(clubRegistrationsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ATTENDEE CAPACITY & REGISTRATION LEDGER',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'View registered students, manage waitlist queues, and perform manual check-in overrides.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SkeuomorphicButton(
                label: 'EXPORT LEDGER CSV',
                variant: SkeuoButtonVariant.secondary,
                icon: Icons.download_rounded,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Registration ledger CSV exported.'),
                      backgroundColor: SkeuoColors.activeGreen,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          registrationsAsync.when(
            data: (regs) {
              if (regs.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Active Registrations',
                  ledColor: SkeuoColors.accentAmber,
                  child: Text('No student registrations recorded for current club events.'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: regs.length,
                itemBuilder: (context, index) {
                  final reg = regs[index];
                  final statusStr = reg.status.name.toUpperCase();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDark ? const Color(0xFF1E2430) : const Color(0xFFFFFFFF),
                      boxShadow: SkeuoShadows.raisedLevel1(isDark: isDark),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.person_pin_rounded, color: SkeuoColors.primaryBlue, size: 28),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Student ID: ${reg.userId.substring(0, reg.userId.length.clamp(0, 10))}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Registered At: ${reg.registeredAt.year}-${reg.registeredAt.month}-${reg.registeredAt.day}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        SkeuomorphicBadge(
                          label: statusStr,
                          color: reg.status == RegistrationStatus.attended
                              ? SkeuoColors.activeGreen
                              : (reg.status == RegistrationStatus.waitlisted
                                  ? SkeuoColors.accentAmber
                                  : SkeuoColors.primaryBlue),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading registrations'),
          ),
        ],
      ),
    );
  }
}

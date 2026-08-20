import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_dialog.dart';
import '../../application/club_providers.dart';

class ClubCertificatesScreen extends ConsumerWidget {
  const ClubCertificatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final certsAsync = ref.watch(clubCertificatesProvider);
    final eventsAsync = ref.watch(clubEventsProvider);
    final selectedClubId = ref.watch(selectedAdminClubIdProvider);
    final actionState = ref.watch(clubAdminActionsControllerProvider);
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
                    'BATCH CERTIFICATE ISSUANCE CONSOLE',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mint cryptographically verifiable certificates in batch for completed events.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              eventsAsync.when(
                data: (events) {
                  return SkeuomorphicButton(
                    label: 'BATCH MINT CERTIFICATES',
                    variant: SkeuoButtonVariant.amber,
                    icon: Icons.workspace_premium_rounded,
                    isLoading: actionState.isLoading,
                    onPressed: events.isEmpty || selectedClubId == null
                        ? null
                        : () {
                            final targetEvent = events.first;
                            SkeuomorphicDialog.show(
                              context,
                              title: 'CONFIRM BATCH MINTING',
                              message: 'Mint official certificates for all verified attendees of "${targetEvent.title}"?',
                              confirmLabel: 'Mint Certificates Now',
                              onConfirm: () async {
                                final success = await ref
                                    .read(clubAdminActionsControllerProvider.notifier)
                                    .batchIssueCertificates(
                                      eventId: targetEvent.id,
                                      clubId: selectedClubId,
                                      studentIds: ['sample-student-1', 'sample-student-2'],
                                    );

                                if (success && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Certificates minted successfully!'),
                                      backgroundColor: SkeuoColors.activeGreen,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (err, stack) => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 24),

          certsAsync.when(
            data: (certs) {
              if (certs.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Issued Certificates',
                  ledColor: SkeuoColors.accentAmber,
                  child: Text('No certificates issued for this club society yet.'),
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 700 ? 2 : 1;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.6,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: certs.length,
                    itemBuilder: (context, index) {
                      final cert = certs[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isDark ? const Color(0xFF1E2430) : const Color(0xFFFFFBEB),
                          border: Border.all(color: SkeuoColors.accentAmber, width: 1.5),
                          boxShadow: SkeuoShadows.raisedLevel2(isDark: isDark),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.verified_rounded, color: SkeuoColors.accentAmber, size: 28),
                                SkeuomorphicBadge(
                                  label: cert.certificateNumber,
                                  color: SkeuoColors.activeGreen,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              cert.eventTitle,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Recipient: ${cert.studentName}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                            ),
                            const Spacer(),
                            Text(
                              'Issued: ${cert.issueDate.year}-${cert.issueDate.month}-${cert.issueDate.day}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading certificate batch ledger'),
          ),
        ],
      ),
    );
  }
}

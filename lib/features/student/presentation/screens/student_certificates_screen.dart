import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_dialog.dart';
import '../../application/student_providers.dart';

class StudentCertificatesScreen extends ConsumerWidget {
  const StudentCertificatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final certsAsync = ref.watch(userCertificatesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'VERIFIED CERTIFICATE VAULT',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Issued digital certificates backed by cryptographic verification IDs.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          certsAsync.when(
            data: (certs) {
              if (certs.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Certificates Issued',
                  ledColor: SkeuoColors.accentAmber,
                  child: Text('You do not have any issued certificates yet. Complete workshops and hackathons to mint official certificates!'),
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
                      childAspectRatio: 1.5,
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
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Issued to: ${cert.studentName} • ${cert.clubName}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Expanded(
                                  child: SkeuomorphicButton(
                                    label: 'VERIFY & PREVIEW',
                                    variant: SkeuoButtonVariant.primary,
                                    height: 36.0,
                                    onPressed: () {
                                      SkeuomorphicDialog.show(
                                        context,
                                        title: 'CERTIFICATE VERIFICATION',
                                        message: 'ID: ${cert.id}\nVerification URL: ${cert.verificationUrl}',
                                        confirmLabel: 'Close',
                                        onConfirm: () {},
                                      );
                                    },
                                  ),
                                ),
                              ],
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
            error: (err, stack) => const Text('Error loading certificate vault'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/organic_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../notifications/data/repositories/notification_repository.dart';
import '../../application/student_providers.dart';

class StudentNotificationsScreen extends ConsumerWidget {
  const StudentNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(userNotificationsProvider);
    final notifRepo = ref.watch(notificationRepositoryProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? OrganicColors.textIvoryWhite : OrganicColors.textDarkForest;
    final subtextColor = isDark ? OrganicColors.textSoftMoss : OrganicColors.textSubtleEmerald;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NOTIFICATION CENTER',
            style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold, fontSize: 22, color: textColor),
          ),
          const SizedBox(height: 4),
          Text(
            'Real-time alerts for event reminders, certificate issuance, and club updates.',
            style: TextStyle(fontSize: 13, color: subtextColor),
          ),
          const SizedBox(height: 24),

          notificationsAsync.when(
            data: (notifications) {
              if (notifications.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Notifications',
                  ledColor: OrganicColors.accentEmeraldMedium,
                  child: Text('Your notification queue is clean.'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.white.withValues(alpha: 0.8),
                      border: Border.all(
                        color: isDark ? OrganicColors.glassBorder : OrganicColors.glassBorderLightGreen,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: item.isRead
                                ? (isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8))
                                : OrganicColors.accentTerracotta,
                            boxShadow: item.isRead
                                ? []
                                : [
                                    BoxShadow(
                                      color: OrganicColors.accentTerracotta.withValues(alpha: 0.6),
                                      blurRadius: 4,
                                    ),
                                  ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.body,
                                style: TextStyle(fontSize: 12, color: subtextColor),
                              ),
                            ],
                          ),
                        ),
                        if (!item.isRead)
                          IconButton(
                            icon: const Icon(Icons.mark_email_read_rounded, size: 20),
                            onPressed: () => notifRepo.markAsRead(item.id),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading notifications'),
          ),
        ],
      ),
    );
  }
}

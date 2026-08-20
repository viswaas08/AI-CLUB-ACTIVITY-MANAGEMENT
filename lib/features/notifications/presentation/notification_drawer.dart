import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/skeuo_theme.dart';
import '../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../student/application/student_providers.dart';

class NotificationBellIcon extends ConsumerWidget {
  const NotificationBellIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(userNotificationsProvider);
    final count = notificationsAsync.value?.where((n) => !n.isRead).length ?? 0;

    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_rounded, color: SkeuoColors.primaryBlue),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
        if (count > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: SkeuoColors.alertRed,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: SkeuoColors.alertRed,
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Text(
                '$count',
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}

class NotificationDrawer extends ConsumerWidget {
  const NotificationDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(userNotificationsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? const Color(0xFF161A22) : const Color(0xFFF1F5F9),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.notifications_active_rounded, color: SkeuoColors.primaryBlue),
                      SizedBox(width: 10),
                      Text(
                        'NOTIFICATION TRAY',
                        style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(),

            Expanded(
              child: notificationsAsync.when(
                data: (items) {
                  if (items.isEmpty) {
                    return const Center(
                      child: SkeuomorphicCard(
                        title: 'No Notifications',
                        ledColor: SkeuoColors.accentAmber,
                        child: Text('You are all caught up!'),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return Dismissible(
                        key: Key(item.id),
                        background: Container(
                          color: SkeuoColors.alertRed,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isDark ? const Color(0xFF1E2430) : const Color(0xFFFFFFFF),
                            boxShadow: SkeuoShadows.raisedLevel1(isDark: isDark),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  if (!item.isRead)
                                    const SkeuomorphicBadge(label: 'NEW', color: SkeuoColors.alertRed),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.body,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => const Text('Error loading notifications'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

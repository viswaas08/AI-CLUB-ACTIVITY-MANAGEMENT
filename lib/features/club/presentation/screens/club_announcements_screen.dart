import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_input.dart';
import '../../../../shared/widgets/skeuo/skeuo_tabs.dart';
import '../../../announcements/domain/models/announcement_model.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/club_providers.dart';

class ClubAnnouncementsScreen extends ConsumerStatefulWidget {
  const ClubAnnouncementsScreen({super.key});

  @override
  ConsumerState<ClubAnnouncementsScreen> createState() => _ClubAnnouncementsScreenState();
}

class _ClubAnnouncementsScreenState extends ConsumerState<ClubAnnouncementsScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  int _selectedPriorityIndex = 0; // 0: Normal, 1: High, 2: Urgent

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    final selectedClubId = ref.watch(selectedAdminClubIdProvider);
    final announcementsAsync = ref.watch(clubAnnouncementsProvider);
    final actionState = ref.watch(clubAdminActionsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final priorities = [
      AnnouncementPriority.normal,
      AnnouncementPriority.high,
      AnnouncementPriority.urgent,
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BROADCAST BULLETIN MANAGER',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Broadcast announcements and dispatch real-time push notifications to club members.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Composer Card
          SkeuomorphicCard(
            title: 'COMPOSE ANNOUNCEMENT BROADCAST',
            ledColor: SkeuoColors.accentAmber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeuomorphicInput(
                  controller: _titleController,
                  label: 'ANNOUNCEMENT TITLE',
                  prefixIcon: Icons.campaign_rounded,
                ),
                const SizedBox(height: 16),
                SkeuomorphicInput(
                  controller: _contentController,
                  label: 'BULLETIN CONTENT (MARKDOWN SUPPORTED)',
                  prefixIcon: Icons.notes_rounded,
                ),
                const SizedBox(height: 16),

                Text(
                  'PRIORITY BROADCAST SELECTOR',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 6),
                SkeuomorphicTab(
                  tabs: priorities.map((p) => p.name.toUpperCase()).toList(),
                  selectedIndex: _selectedPriorityIndex,
                  onTabSelected: (idx) => setState(() => _selectedPriorityIndex = idx),
                ),
                const SizedBox(height: 20),

                SkeuomorphicButton(
                  label: 'DISPATCH BROADCAST BULLETIN',
                  variant: _selectedPriorityIndex == 2 ? SkeuoButtonVariant.crimson : SkeuoButtonVariant.primary,
                  icon: Icons.send_rounded,
                  isLoading: actionState.isLoading,
                  onPressed: user == null || selectedClubId == null
                      ? null
                      : () async {
                          final success = await ref
                              .read(clubAdminActionsControllerProvider.notifier)
                              .broadcastAnnouncement(
                                clubId: selectedClubId,
                                title: _titleController.text,
                                content: _contentController.text,
                                priority: priorities[_selectedPriorityIndex],
                                authorId: user.id,
                              );

                          if (success && context.mounted) {
                            _titleController.clear();
                            _contentController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Broadcast announcement dispatched to all members!'),
                                backgroundColor: SkeuoColors.activeGreen,
                              ),
                            );
                          }
                        },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Announcements Feed
          announcementsAsync.when(
            data: (items) {
              if (items.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Announcements Posted',
                  ledColor: SkeuoColors.primaryBlue,
                  child: Text('No previous broadcast announcements.'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isUrgent = item.priority == AnnouncementPriority.urgent;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
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
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SkeuomorphicBadge(
                              label: item.priority.name.toUpperCase(),
                              color: isUrgent ? SkeuoColors.alertRed : SkeuoColors.primaryBlue,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.content,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading announcements'),
          ),
        ],
      ),
    );
  }
}

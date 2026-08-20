import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_tabs.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../clubs/data/repositories/club_repository.dart';
import '../../../clubs/domain/models/club_model.dart';
import '../../application/student_providers.dart';

class ClubDetailScreen extends ConsumerStatefulWidget {
  final String clubId;
  const ClubDetailScreen({super.key, required this.clubId});

  @override
  ConsumerState<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends ConsumerState<ClubDetailScreen> {
  int _selectedTab = 0; // 0: Overview & Announcements, 1: Events

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    final clubRepo = ref.watch(clubRepositoryProvider);
    final isJoined = user?.joinedClubIds.contains(widget.clubId) ?? false;
    final actionState = ref.watch(studentActionsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CLUB SOCIETY PROFILE'),
      ),
      body: FutureBuilder<ClubModel?>(
        future: clubRepo.getClubById(widget.clubId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final club = snapshot.data;
          if (club == null) {
            return const Center(child: Text('Club not found.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Embossed Club Crest Header
                SkeuomorphicCard(
                  title: 'OFFICIAL CLUB PROFILE',
                  ledColor: SkeuoColors.primaryBlue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: SkeuoColors.primaryBlue.withValues(alpha: 0.2),
                              border: Border.all(color: SkeuoColors.primaryBlue, width: 2),
                              boxShadow: SkeuoShadows.raisedLevel2(isDark: Theme.of(context).brightness == Brightness.dark),
                            ),
                            child: Center(
                              child: Text(
                                club.name.substring(0, 2).toUpperCase(),
                                style: const TextStyle(
                                  fontFamily: 'Orbitron',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: SkeuoColors.primaryBlue,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  club.name,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    SkeuomorphicBadge(
                                      label: club.category.label,
                                      color: SkeuoColors.activeGreen,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${club.totalMembers} Active Members',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SkeuomorphicButton(
                            label: isJoined ? 'MEMBERSHIP ACTIVE' : 'JOIN CLUB',
                            variant: isJoined ? SkeuoButtonVariant.secondary : SkeuoButtonVariant.primary,
                            icon: isJoined ? Icons.check_circle_rounded : Icons.group_add_rounded,
                            isLoading: actionState.isLoading,
                            onPressed: isJoined || user == null
                                ? null
                                : () async {
                                    final success = await ref
                                        .read(studentActionsControllerProvider.notifier)
                                        .joinClub(widget.clubId, user.id);
                                    if (success && context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Joined club society successfully!'),
                                          backgroundColor: SkeuoColors.activeGreen,
                                        ),
                                      );
                                    }
                                  },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        club.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                SkeuomorphicTab(
                  tabs: const ['Overview & Announcements', 'Club Events'],
                  selectedIndex: _selectedTab,
                  onTabSelected: (idx) => setState(() => _selectedTab = idx),
                ),
                const SizedBox(height: 16),

                if (_selectedTab == 0) ...[
                  SkeuomorphicCard(
                    title: 'FACULTY & LEADERSHIP',
                    ledColor: SkeuoColors.accentAmber,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Department ID: ${club.departmentId}'),
                        const SizedBox(height: 6),
                        Text('Faculty Advisor: ${club.facultyAdvisorId ?? "Dr. Alan Turing"}'),
                        const SizedBox(height: 6),
                        Text('Student Leads Count: ${club.leadStudentIds.length} Leaders'),
                      ],
                    ),
                  ),
                ] else ...[
                  const SkeuomorphicCard(
                    title: 'CLUB HOSTED EVENTS',
                    ledColor: SkeuoColors.primaryBlue,
                    child: Text('Viewing club event schedule.'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

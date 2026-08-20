import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../clubs/domain/models/club_member_model.dart';
import '../../application/club_providers.dart';

class ClubMembersScreen extends ConsumerWidget {
  const ClubMembersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersAsync = ref.watch(clubMembersProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MEMBER CONTROL DECK & ROSTER',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Assign member roles (Member, Coordinator, Lead) and manage university society access.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          membersAsync.when(
            data: (members) {
              if (members.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Members Listed',
                  ledColor: SkeuoColors.accentAmber,
                  child: Text('No members found in this club roster.'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isDark ? const Color(0xFF1E2430) : const Color(0xFFFFFFFF),
                      boxShadow: SkeuoShadows.raisedLevel1(isDark: isDark),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: SkeuoColors.primaryBlue.withValues(alpha: 0.2),
                          child: const Icon(Icons.person_rounded, color: SkeuoColors.primaryBlue),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Member ID: ${member.userId.substring(0, member.userId.length.clamp(0, 8))}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Joined: ${member.joinedAt.year}-${member.joinedAt.month}-${member.joinedAt.day}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),

                        // Role Selector Switch Dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isDark ? const Color(0xFF161A22) : const Color(0xFFF1F5F9),
                            border: Border.all(color: SkeuoColors.primaryBlue),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<MemberRole>(
                              value: member.role,
                              dropdownColor: isDark ? const Color(0xFF161A22) : const Color(0xFFFFFFFF),
                              onChanged: (newRole) {
                                if (newRole != null) {
                                  ref
                                      .read(clubAdminActionsControllerProvider.notifier)
                                      .updateMemberRole(member.id, newRole);
                                }
                              },
                              items: MemberRole.values.map((role) {
                                return DropdownMenuItem<MemberRole>(
                                  value: role,
                                  child: Text(
                                    role.name.toUpperCase(),
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        SkeuomorphicBadge(
                          label: member.role.name.toUpperCase(),
                          color: member.role == MemberRole.lead
                              ? SkeuoColors.accentAmber
                              : SkeuoColors.primaryBlue,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading club member roster'),
          ),
        ],
      ),
    );
  }
}

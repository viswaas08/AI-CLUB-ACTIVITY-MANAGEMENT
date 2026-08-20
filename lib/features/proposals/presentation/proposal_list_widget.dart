import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/organic_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_empty.dart';
import '../../../../shared/widgets/skeuo/skeuo_loading.dart';
import '../../auth/application/auth_providers.dart';
import '../data/repositories/proposal_repository.dart';
import '../domain/models/proposal_model.dart';
import 'proposal_submission_modal.dart';

class ProposalListWidget extends ConsumerWidget {
  const ProposalListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proposalsAsync = ref.watch(proposalsStreamProvider);
    final user = ref.watch(currentUserProvider).value;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headingColor = isDark ? OrganicColors.textIvoryWhite : OrganicColors.textForestCharcoal;
    final bodyColor = isDark ? OrganicColors.textSoftMoss : OrganicColors.textSlateGreen;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CIVIC TECH EVENT PITCHING PORTAL',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                    color: headingColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Upvote student proposals. 50+ votes auto-escalates proposal to Faculty & Admin.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    color: bodyColor,
                  ),
                ),
              ],
            ),
            SkeuomorphicButton(
              label: 'DEPOSIT PITCH',
              variant: SkeuoButtonVariant.primary,
              icon: Icons.add_rounded,
              onPressed: () => ProposalSubmissionModal.show(context),
            ),
          ],
        ),
        const SizedBox(height: 18),

        proposalsAsync.when(
          data: (proposals) {
            if (proposals.isEmpty) {
              return const SkeuomorphicEmptyState(
                title: 'No Active Pitches',
                message: 'Be the first student to deposit an event pitch into the suggestion box!',
                icon: Icons.markunread_mailbox_rounded,
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: proposals.length,
              itemBuilder: (context, index) {
                final proposal = proposals[index];
                final isUpvoted = user != null && proposal.upvotedUserIds.contains(user.id);
                final isEscalated = proposal.status == ProposalStatus.escalated || proposal.upvoteCount >= 50;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: isDark ? const Color(0xFF132219) : Colors.white,
                    border: Border.all(
                      color: isEscalated
                          ? const Color(0xFFD97706)
                          : (isDark ? OrganicColors.glassBorder : OrganicColors.borderLightGrayGreen),
                      width: 1.0,
                    ),
                    boxShadow: isDark
                        ? null
                        : [
                            BoxShadow(
                              color: const Color(0xFF1A2E22).withValues(alpha: 0.03),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Upvote Button
                      InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: user == null
                            ? null
                            : () {
                                ref.read(proposalRepositoryProvider).upvoteProposal(proposal.id, user.id);
                              },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: isUpvoted
                                ? OrganicColors.primaryMint
                                : (isDark ? const Color(0xFF1A2E22) : const Color(0xFFF4F7F5)),
                            border: Border.all(
                              color: isUpvoted
                                  ? OrganicColors.primaryMint
                                  : (isDark ? OrganicColors.glassBorder : OrganicColors.borderLightGrayGreen),
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_drop_up_rounded,
                                color: isUpvoted ? Colors.white : OrganicColors.primaryMint,
                                size: 24,
                              ),
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 0, end: proposal.upvoteCount.toDouble()),
                                duration: const Duration(milliseconds: 400),
                                builder: (context, val, child) {
                                  return Text(
                                    '${val.toInt()}',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: isUpvoted ? Colors.white : (isDark ? Colors.white : OrganicColors.textForestCharcoal),
                                    ),
                                  );
                                },
                              ),
                              Text(
                                'VOTES',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                  color: isUpvoted ? Colors.white70 : (isDark ? OrganicColors.textSoftMoss : OrganicColors.textSlateGreen),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    proposal.title,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: headingColor,
                                    ),
                                  ),
                                ),
                                if (isEscalated)
                                  const SkeuomorphicBadge(
                                    label: 'ESCALATED TO FACULTY',
                                    color: Color(0xFFD97706),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              proposal.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: bodyColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'By ${proposal.authorName} • ${proposal.category}',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: bodyColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => const SkeuomorphicLoadingState(label: 'CONNECTING TO CIVIC REAL-TIME STREAM...'),
          error: (err, stack) => const Text('Error loading civic proposals feed'),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/tactile_text_field.dart';
import '../../auth/application/auth_providers.dart';
import '../data/repositories/proposal_repository.dart';
import '../domain/models/proposal_model.dart';

class ProposalSubmissionModal extends ConsumerStatefulWidget {
  const ProposalSubmissionModal({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const ProposalSubmissionModal(),
    );
  }

  @override
  ConsumerState<ProposalSubmissionModal> createState() => _ProposalSubmissionModalState();
}

class _ProposalSubmissionModalState extends ConsumerState<ProposalSubmissionModal> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _category = 'Workshop Pitch';
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 460),
        child: SkeuomorphicCard(
          title: 'CIVIC SUGGESTION BOX • SUBMIT PITCH',
          ledColor: SkeuoColors.accentAmber,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Submit your club or event proposal for campus upvoting and faculty escalation.'),
              const SizedBox(height: 16),

              TactileTextField(
                controller: _titleController,
                label: 'Proposal Title',
                hintText: 'e.g. Campus Generative AI Hackathon',
              ),
              const SizedBox(height: 12),

              TactileTextField(
                controller: _descController,
                label: 'Detailed Pitch & Objectives',
                hintText: 'Describe target audience, venue requirements, and expected impact...',
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: InputDecoration(
                  labelText: 'Category',
                  filled: true,
                  fillColor: isDark ? const Color(0xFF161A22) : const Color(0xFFE2E8F0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                items: const [
                  DropdownMenuItem(value: 'Workshop Pitch', child: Text('Workshop Pitch')),
                  DropdownMenuItem(value: 'Hackathon Proposal', child: Text('Hackathon Proposal')),
                  DropdownMenuItem(value: 'Guest Symposium', child: Text('Guest Symposium')),
                  DropdownMenuItem(value: 'Equipment Request', child: Text('Equipment Request')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _category = val);
                },
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SkeuomorphicButton(
                    label: 'CANCEL',
                    variant: SkeuoButtonVariant.secondary,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 12),
                  SkeuomorphicButton(
                    label: 'DEPOSIT PITCH',
                    variant: SkeuoButtonVariant.amber,
                    isLoading: _isLoading,
                    onPressed: user == null
                        ? null
                        : () async {
                            if (_titleController.text.trim().isEmpty || _descController.text.trim().isEmpty) return;

                            final navigator = Navigator.of(context);
                            final messenger = ScaffoldMessenger.of(context);
                            setState(() => _isLoading = true);
                            final repo = ref.read(proposalRepositoryProvider);
                            await repo.submitProposal(
                              ProposalModel(
                                id: '',
                                title: _titleController.text.trim(),
                                description: _descController.text.trim(),
                                category: _category,
                                authorId: user.id,
                                authorName: user.displayName ?? 'Student Pitcher',
                                createdAt: DateTime.now(),
                              ),
                            );

                            if (mounted) {
                              navigator.pop();
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text('Proposal deposited into Civic Suggestion Box!'),
                                  backgroundColor: SkeuoColors.activeGreen,
                                ),
                              );
                            }
                          },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

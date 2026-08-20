import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_input.dart';
import '../../application/club_providers.dart';

class ClubProfileScreen extends ConsumerStatefulWidget {
  const ClubProfileScreen({super.key});

  @override
  ConsumerState<ClubProfileScreen> createState() => _ClubProfileScreenState();
}

class _ClubProfileScreenState extends ConsumerState<ClubProfileScreen> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _meetingScheduleController = TextEditingController();
  final _socialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final club = ref.read(activeAdminClubProvider).value;
    if (club != null) {
      _nameController.text = club.name;
      _bioController.text = club.description;
      _meetingScheduleController.text = 'Every Wednesday at 5:00 PM (Lab 402)';
      _socialController.text = 'https://github.com/ai-society-campus';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _meetingScheduleController.dispose();
    _socialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CLUB DETAILS & ASSET CONSOLE',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Manage university club metadata, meeting schedules, branding logos, and faculty details.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Recessed Form Console
          SkeuomorphicCard(
            title: 'METADATA & BRANDING CONSOLE',
            ledColor: SkeuoColors.primaryBlue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeuomorphicInput(
                  controller: _nameController,
                  label: 'CLUB SOCIETY NAME',
                  prefixIcon: Icons.groups_rounded,
                ),
                const SizedBox(height: 16),
                SkeuomorphicInput(
                  controller: _bioController,
                  label: 'DESCRIPTION & MISSION STATEMENT',
                  prefixIcon: Icons.notes_rounded,
                ),
                const SizedBox(height: 16),
                SkeuomorphicInput(
                  controller: _meetingScheduleController,
                  label: 'REGULAR MEETING SCHEDULE & VENUE',
                  prefixIcon: Icons.schedule_rounded,
                ),
                const SizedBox(height: 16),
                SkeuomorphicInput(
                  controller: _socialController,
                  label: 'GITHUB / PORTAL REPOSITORY URL',
                  prefixIcon: Icons.link_rounded,
                ),
                const SizedBox(height: 20),

                // Logo Upload Placeholder Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isDark ? const Color(0xFF161A22) : const Color(0xFFF1F5F9),
                    border: Border.all(color: SkeuoColors.primaryBlue.withValues(alpha: 0.5)),
                    boxShadow: SkeuoShadows.sunkenLevel1(isDark: isDark),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.cloud_upload_rounded, color: SkeuoColors.primaryBlue, size: 36),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BRANDING LOGO & ASSET CREST',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            SizedBox(height: 2),
                            Text('PNG/SVG • Max file size 5MB', style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                      SkeuomorphicButton(
                        label: 'UPLOAD CREST',
                        variant: SkeuoButtonVariant.secondary,
                        height: 36.0,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Firebase Storage logo asset upload simulated.'),
                              backgroundColor: SkeuoColors.activeGreen,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                SkeuomorphicButton(
                  label: 'SAVE CLUB METADATA',
                  variant: SkeuoButtonVariant.primary,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Club profile updated successfully.'),
                        backgroundColor: SkeuoColors.activeGreen,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_input.dart';
import '../../../../shared/widgets/skeuo/skeuo_switch.dart';
import '../../../auth/application/auth_providers.dart';

class StudentProfileScreen extends ConsumerStatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  ConsumerState<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends ConsumerState<StudentProfileScreen> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _skillsController = TextEditingController();

  bool _emailAlerts = true;
  bool _pushNotifs = true;
  bool _publicProfile = true;

  @override
  void initState() {
    super.initState();
    final user = ref.read(currentUserProvider).value;
    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _bioController.text = 'AI & Deep Learning Enthusiast';
      _skillsController.text = 'Python, Flutter, PyTorch, LLMs';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STUDENT PROFILE & PREFERENCES',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Configure your student profile information and skeuomorphic system controls.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Recessed Input Controls Card
          SkeuomorphicCard(
            title: 'PERSONAL INFORMATION CONSOLE',
            ledColor: SkeuoColors.primaryBlue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeuomorphicInput(
                  controller: _nameController,
                  label: 'DISPLAY NAME',
                  prefixIcon: Icons.person_rounded,
                ),
                const SizedBox(height: 16),
                SkeuomorphicInput(
                  controller: _bioController,
                  label: 'STUDENT BIO',
                  prefixIcon: Icons.notes_rounded,
                ),
                const SizedBox(height: 16),
                SkeuomorphicInput(
                  controller: _skillsController,
                  label: 'TECHNICAL SKILLS',
                  prefixIcon: Icons.code_rounded,
                ),
                const SizedBox(height: 20),
                SkeuomorphicButton(
                  label: 'SAVE PROFILE CHANGES',
                  variant: SkeuoButtonVariant.primary,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile preferences saved.'),
                        backgroundColor: SkeuoColors.activeGreen,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Skeuomorphic Sliding Toggle Switches Card
          SkeuomorphicCard(
            title: 'MECHANICAL PREFERENCE SWITCHES',
            ledColor: SkeuoColors.accentAmber,
            child: Column(
              children: [
                SkeuomorphicSwitch(
                  value: _emailAlerts,
                  label: 'EMAIL ACTIVITY NOTIFICATIONS',
                  onChanged: (val) => setState(() => _emailAlerts = val),
                ),
                const SizedBox(height: 16),
                SkeuomorphicSwitch(
                  value: _pushNotifs,
                  label: 'PUSH ALERT SYSTEM',
                  onChanged: (val) => setState(() => _pushNotifs = val),
                ),
                const SizedBox(height: 16),
                SkeuomorphicSwitch(
                  value: _publicProfile,
                  label: 'PUBLIC LEADERBOARD VISIBILITY',
                  onChanged: (val) => setState(() => _publicProfile = val),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_dropdown.dart';
import '../../../../shared/widgets/skeuo/skeuo_input.dart';
import '../../application/auth_providers.dart';
import '../../domain/user_role.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _selectedDept = 'CS-AI';

  @override
  void initState() {
    super.initState();
    final currentUser = ref.read(currentUserProvider).value;
    if (currentUser != null && currentUser.displayName != null) {
      _nameController.text = currentUser.displayName!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _handleCompleteProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final currentUser = ref.read(currentUserProvider).value;
    final isStudent = currentUser?.role == UserRole.student || currentUser?.role == UserRole.clubAdmin;

    final success = await ref.read(authControllerProvider.notifier).updateProfile(
          displayName: _nameController.text,
          departmentId: _selectedDept,
          studentId: isStudent ? _idController.text : null,
          facultyEmployeeId: !isStudent ? _idController.text : null,
        );

    if (!success && mounted) {
      final errorState = ref.read(authControllerProvider);
      final message = mapAuthErrorMessage(errorState.error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: SkeuoColors.alertRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final currentUser = ref.watch(currentUserProvider).value;
    final isLoading = authState.isLoading;

    final isStudent = currentUser?.role == UserRole.student || currentUser?.role == UserRole.clubAdmin;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SkeuomorphicCard(
              title: 'PROFILE CONFIGURATION',
              ledColor: SkeuoColors.activeGreen,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INITIALIZE PORTAL PROFILE',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Complete your profile to enable QR attendance, certificate issuance, and club memberships.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    SkeuomorphicInput(
                      controller: _nameController,
                      label: 'DISPLAY NAME',
                      hintText: 'John Doe',
                      prefixIcon: Icons.badge_rounded,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) return 'Enter display name';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SkeuomorphicDropdown<String>(
                      label: 'ACADEMIC DEPARTMENT',
                      value: _selectedDept,
                      items: const [
                        DropdownMenuItem(value: 'CS-AI', child: Text('School of Computer Science & AI')),
                        DropdownMenuItem(value: 'ROBOTICS', child: Text('Department of Robotics & Mechatronics')),
                        DropdownMenuItem(value: 'CYBER', child: Text('Cyber Security & Forensics')),
                        DropdownMenuItem(value: 'DATA-SCI', child: Text('Data Science & Computational Intelligence')),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedDept = val);
                      },
                    ),
                    const SizedBox(height: 16),
                    SkeuomorphicInput(
                      controller: _idController,
                      label: isStudent ? 'STUDENT ROLL / REGISTRATION NUMBER' : 'FACULTY EMPLOYEE ID',
                      hintText: isStudent ? 'e.g. 2026-CS-8941' : 'e.g. EMP-FAC-9921',
                      prefixIcon: Icons.card_membership_rounded,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) return 'Enter registration/employee ID';
                        return null;
                      },
                    ),
                    const SizedBox(height: 28),
                    SkeuomorphicButton(
                      label: 'COMPLETE PROFILE & ENTER PORTAL',
                      variant: SkeuoButtonVariant.primary,
                      icon: Icons.check_circle_rounded,
                      isLoading: isLoading,
                      width: double.infinity,
                      onPressed: _handleCompleteProfile,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

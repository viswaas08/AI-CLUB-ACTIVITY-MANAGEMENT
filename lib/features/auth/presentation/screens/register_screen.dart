import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/organic_theme.dart';
import '../../../../shared/widgets/organic/dewdrop_button.dart';
import '../../../../shared/widgets/organic/eco_glass_card.dart';
import '../../../../shared/widgets/organic/organic_glass_input.dart';
import '../../../../shared/widgets/skeuo/skeuo_tabs.dart';
import '../../application/auth_providers.dart';
import '../../domain/user_role.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _selectedRoleIndex = 0; // 0: Student, 1: Club Lead, 2: Faculty

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  int get _passwordStrength {
    final text = _passwordController.text;
    if (text.isEmpty) return 0;
    int strength = 0;
    if (text.length >= 6) strength++;
    if (text.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(text) && RegExp(r'[0-9]').hasMatch(text)) strength++;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(text)) strength++;
    return strength;
  }

  UserRole _getRole() {
    switch (_selectedRoleIndex) {
      case 0:
        return UserRole.student;
      case 1:
        return UserRole.clubAdmin;
      case 2:
        return UserRole.faculty;
      default:
        return UserRole.student;
    }
  }

  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(authControllerProvider.notifier).registerWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          displayName: _nameController.text.trim(),
          role: _getRole(),
        );

    if (success && mounted) {
      context.go('/profile-setup');
    } else if (mounted) {
      final errorState = ref.read(authControllerProvider);
      final message = mapAuthErrorMessage(errorState.error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: OrganicColors.accentTerracotta,
        ),
      );
    }
  }

  void _handleGoogleSignIn() async {
    final success = await ref.read(authControllerProvider.notifier).signInWithGoogle();
    if (success && mounted) {
      context.go('/student');
    }
  }

  void _handleGithubSignIn() async {
    final success = await ref.read(authControllerProvider.notifier).signInWithGithub();
    if (success && mounted) {
      context.go('/student');
    }
  }

  void _handleMicrosoftSignIn() async {
    final success = await ref.read(authControllerProvider.notifier).signInWithMicrosoft();
    if (success && mounted) {
      context.go('/student');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;
    final isLightGreen = ref.watch(isLightGreenThemeProvider);

    final textColor = isLightGreen ? OrganicColors.textDarkForest : OrganicColors.textIvoryWhite;
    final subtextColor = isLightGreen ? OrganicColors.textSubtleEmerald : OrganicColors.textSoftMoss;
    final accentGreen = isLightGreen ? OrganicColors.accentEmeraldMedium : OrganicColors.accentSage;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back to Sign In Navigation Button
              DewdropButton(
                label: 'BACK TO SIGN IN',
                icon: Icons.arrow_back_rounded,
                variant: DewdropButtonVariant.translucent,
                height: 38,
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/auth/login');
                  }
                },
              ),

              const SizedBox(height: 24),

              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: EcoGlassCard(
                    title: 'NEW USER REGISTRATION',
                    statusIndicatorColor: accentGreen,
                    isOrganicLeafShape: true,
                    padding: const EdgeInsets.all(28.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ACCOUNT PROVISIONING',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Select institutional role and configure your portal profile.',
                            style: TextStyle(fontSize: 12, color: subtextColor),
                          ),
                          const SizedBox(height: 20),

                          // Role Segmented Switch
                          Text(
                            'INSTITUTIONAL ROLE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.6,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SkeuomorphicTab(
                            tabs: const ['Student', 'Club Lead', 'Faculty'],
                            selectedIndex: _selectedRoleIndex,
                            onTabSelected: (index) => setState(() => _selectedRoleIndex = index),
                          ),
                          const SizedBox(height: 20),

                          OrganicGlassInput(
                            controller: _nameController,
                            label: 'FULL NAME',
                            hintText: 'Alex Morgan',
                            prefixIcon: Icons.person_outline_rounded,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) return 'Enter full name';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          OrganicGlassInput(
                            controller: _emailController,
                            label: 'INSTITUTIONAL EMAIL',
                            hintText: 'user@university.edu',
                            prefixIcon: Icons.alternate_email_rounded,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) return 'Enter email address';
                              if (!val.contains('@')) return 'Enter valid email address';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          OrganicGlassInput(
                            controller: _passwordController,
                            label: 'SECURE PASSWORD',
                            hintText: '••••••••••••',
                            obscureText: true,
                            prefixIcon: Icons.lock_outline_rounded,
                            onChanged: (_) => setState(() {}),
                            validator: (val) {
                              if (val == null || val.length < 6) return 'Password must be at least 6 characters';
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),

                          // Password Strength Bar
                          Row(
                            children: [
                              Text(
                                'PASSWORD SECURITY: ',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.6,
                                  color: subtextColor,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ...List.generate(4, (index) {
                                final active = index < _passwordStrength;
                                Color barColor = OrganicColors.accentTerracotta;
                                if (_passwordStrength >= 3) {
                                  barColor = OrganicColors.accentEmeraldMedium;
                                } else if (_passwordStrength == 2) {
                                  barColor = OrganicColors.accentClay;
                                }

                                return Container(
                                  width: 24,
                                  height: 6,
                                  margin: const EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: active
                                        ? barColor
                                        : (isLightGreen ? const Color(0xFFCBD5E1) : Colors.white.withValues(alpha: 0.15)),
                                  ),
                                );
                              }),
                            ],
                          ),
                          const SizedBox(height: 24),

                          DewdropButton(
                            label: 'CREATE ACCOUNT & PROVISION PROFILE',
                            variant: DewdropButtonVariant.terracotta,
                            icon: Icons.person_add_rounded,
                            isLoading: isLoading,
                            width: double.infinity,
                            height: 46,
                            onPressed: _handleRegister,
                          ),
                          const SizedBox(height: 18),

                          // Divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: isLightGreen ? const Color(0xFFCBD5E1) : Colors.white.withValues(alpha: 0.15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(
                                  'OR REGISTER WITH OAUTH',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                    color: subtextColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: isLightGreen ? const Color(0xFFCBD5E1) : Colors.white.withValues(alpha: 0.15),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // OAuth Providers Grid
                          Row(
                            children: [
                              Expanded(
                                child: DewdropButton(
                                  label: 'Google',
                                  variant: DewdropButtonVariant.translucent,
                                  icon: Icons.g_mobiledata_rounded,
                                  isLoading: isLoading,
                                  height: 42,
                                  onPressed: _handleGoogleSignIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: DewdropButton(
                                  label: 'GitHub',
                                  variant: DewdropButtonVariant.translucent,
                                  icon: Icons.code_rounded,
                                  isLoading: isLoading,
                                  height: 42,
                                  onPressed: _handleGithubSignIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: DewdropButton(
                                  label: 'MS 365',
                                  variant: DewdropButtonVariant.translucent,
                                  icon: Icons.window_rounded,
                                  isLoading: isLoading,
                                  height: 42,
                                  onPressed: _handleMicrosoftSignIn,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: TextStyle(fontSize: 13, color: subtextColor),
                              ),
                              GestureDetector(
                                onTap: () => context.go('/auth/login'),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: accentGreen,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

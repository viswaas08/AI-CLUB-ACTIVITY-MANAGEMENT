import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/organic_theme.dart';
import '../../../../shared/widgets/organic/dewdrop_button.dart';
import '../../../../shared/widgets/organic/eco_glass_card.dart';
import '../../../../shared/widgets/organic/organic_glass_input.dart';
import '../../application/auth_providers.dart';
import '../../domain/user_role.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(authControllerProvider.notifier).signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text,
        );

    if (!success && mounted) {
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

  void _handleDemoLogin(UserRole role, String email, String password) async {
    setState(() {
      _emailController.text = email;
      _passwordController.text = password;
    });

    final success = await ref.read(authControllerProvider.notifier).signInWithDemoRole(role);
    if (success && mounted) {
      switch (role) {
        case UserRole.student:
          context.go('/student');
          break;
        case UserRole.clubAdmin:
          context.go('/club');
          break;
        case UserRole.faculty:
          context.go('/faculty');
          break;
        case UserRole.superAdmin:
          context.go('/admin');
          break;
      }
    }
  }

  void _handleGoogleSignIn() async {
    final success = await ref.read(authControllerProvider.notifier).signInWithGoogle();
    if (!success && mounted) {
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

  void _handleGithubSignIn() async {
    final success = await ref.read(authControllerProvider.notifier).signInWithGithub();
    if (!success && mounted) {
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

  void _handleMicrosoftSignIn() async {
    final success = await ref.read(authControllerProvider.notifier).signInWithMicrosoft();
    if (!success && mounted) {
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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLightGreen = ref.watch(isLightGreenThemeProvider);
    final isLoading = authState.isLoading;

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
              // 1. Back to Home Navigation Button
              DewdropButton(
                label: 'BACK TO HOME',
                icon: Icons.arrow_back_rounded,
                variant: DewdropButtonVariant.translucent,
                height: 38,
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/');
                  }
                },
              ),

              const SizedBox(height: 24),

              // 2. Central Login Card Container
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: EcoGlassCard(
                    title: 'PORTAL AUTHENTICATION',
                    statusIndicatorColor: accentGreen,
                    isOrganicLeafShape: true,
                    padding: const EdgeInsets.all(28.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Brand Header
                          Row(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: accentGreen.withValues(alpha: isLightGreen ? 0.15 : 0.25),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: accentGreen.withValues(alpha: 0.4), width: 1.2),
                                ),
                                child: Icon(Icons.shield_outlined, color: accentGreen, size: 24),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'AI CLUBS CONTROL CONSOLE',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.5,
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      'Institutional Zero-Trust Sign In',
                                      style: TextStyle(fontSize: 12, color: subtextColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Form Inputs
                          OrganicGlassInput(
                            controller: _emailController,
                            label: 'INSTITUTIONAL EMAIL',
                            hintText: 'student@university.edu',
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
                            label: 'SECURITY PASSWORD',
                            hintText: '••••••••••••',
                            obscureText: true,
                            prefixIcon: Icons.lock_outline_rounded,
                            validator: (val) {
                              if (val == null || val.isEmpty) return 'Enter password';
                              return null;
                            },
                          ),

                          const SizedBox(height: 10),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => context.push('/forgot-password'),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: accentGreen,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Primary Sign In Button
                          DewdropButton(
                            label: 'SIGN IN TO PORTAL',
                            variant: DewdropButtonVariant.terracotta,
                            icon: Icons.login_rounded,
                            isLoading: isLoading,
                            width: double.infinity,
                            height: 46,
                            onPressed: _handleSignIn,
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
                                  'OR CONTINUE WITH OAUTH',
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

                          const SizedBox(height: 24),

                          // Quick Demo Credentials Fill (Helpful for Evaluation)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isLightGreen ? const Color(0xFFF0FDF4) : Colors.white.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isLightGreen ? OrganicColors.glassBorderLightGreen : OrganicColors.glassBorder,
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'DEMO PRE-CONFIGURED ROLES',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                    color: accentGreen,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _buildDemoChip(UserRole.student, 'Student', 'student@university.edu', 'password123'),
                                    _buildDemoChip(UserRole.clubAdmin, 'Club Leader', 'leader@university.edu', 'password123'),
                                    _buildDemoChip(UserRole.faculty, 'Faculty', 'faculty@university.edu', 'password123'),
                                    _buildDemoChip(UserRole.superAdmin, 'Admin', 'admin@university.edu', 'password123'),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Register Prompt Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an institutional account? ",
                                style: TextStyle(fontSize: 13, color: subtextColor),
                              ),
                              GestureDetector(
                                onTap: () => context.push('/register'),
                                child: Text(
                                  'Create Account',
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

  Widget _buildDemoChip(UserRole role, String roleLabel, String email, String password) {
    return InkWell(
      onTap: () => _handleDemoLogin(role, email, password),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: OrganicColors.primaryMint.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: OrganicColors.primaryMint.withValues(alpha: 0.35), width: 1.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.bolt_rounded, size: 14, color: OrganicColors.primaryMint),
            const SizedBox(width: 4),
            Text(
              roleLabel,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: OrganicColors.primaryMint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


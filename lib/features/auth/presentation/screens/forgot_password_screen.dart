import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/organic_theme.dart';
import '../../../../shared/widgets/organic/dewdrop_button.dart';
import '../../../../shared/widgets/organic/eco_glass_card.dart';
import '../../../../shared/widgets/organic/organic_glass_input.dart';
import '../../application/auth_providers.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleReset() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref
        .read(authControllerProvider.notifier)
        .sendPasswordResetEmail(_emailController.text.trim());

    if (success && mounted) {
      setState(() => _emailSent = true);
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
              // Back Button
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
                    title: 'PASSWORD RESET CONSOLE',
                    statusIndicatorColor: accentGreen,
                    isOrganicLeafShape: true,
                    padding: const EdgeInsets.all(28.0),
                    child: _emailSent
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: OrganicColors.accentEmeraldMedium.withValues(alpha: 0.15),
                                ),
                                child: const Icon(
                                  Icons.mark_email_read_rounded,
                                  size: 40,
                                  color: OrganicColors.accentEmeraldMedium,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'RESET LINK DISPATCHED',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Password reset instructions have been sent to ${_emailController.text}. Follow instructions in email to configure new password.',
                                style: TextStyle(fontSize: 13, height: 1.5, color: subtextColor),
                              ),
                              const SizedBox(height: 24),
                              DewdropButton(
                                label: 'RETURN TO LOGIN',
                                variant: DewdropButtonVariant.sage,
                                width: double.infinity,
                                height: 46,
                                onPressed: () => context.go('/auth/login'),
                              ),
                            ],
                          )
                        : Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RECOVER ACCESS',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Enter your registered email address to receive password reset link.',
                                  style: TextStyle(fontSize: 12, color: subtextColor),
                                ),
                                const SizedBox(height: 24),
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
                                const SizedBox(height: 24),
                                DewdropButton(
                                  label: 'SEND RESET LINK',
                                  variant: DewdropButtonVariant.terracotta,
                                  icon: Icons.send_rounded,
                                  isLoading: isLoading,
                                  width: double.infinity,
                                  height: 46,
                                  onPressed: _handleReset,
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

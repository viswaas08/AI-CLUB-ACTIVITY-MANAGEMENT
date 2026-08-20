import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../application/auth_providers.dart';
import '../../domain/user_role.dart';

class UnauthorizedScreen extends ConsumerWidget {
  const UnauthorizedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(currentUserProvider).value;

    String targetDashboard = '/student';
    if (appUser != null) {
      switch (appUser.role) {
        case UserRole.student:
          targetDashboard = '/student';
          break;
        case UserRole.clubAdmin:
          targetDashboard = '/club';
          break;
        case UserRole.faculty:
          targetDashboard = '/faculty';
          break;
        case UserRole.superAdmin:
          targetDashboard = '/admin';
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 440),
            child: SkeuomorphicCard(
              title: 'ACCESS RESTRICTED',
              ledColor: SkeuoColors.alertRed,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.gpp_maybe_rounded,
                    size: 64,
                    color: SkeuoColors.alertRed,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'UNAUTHORIZED ZONE',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Your institutional role (${appUser?.role.label ?? "Unverified"}) does not possess execution privileges for this zone.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 28),
                  SkeuomorphicButton(
                    label: 'RETURN TO AUTHORIZED CONSOLE',
                    variant: SkeuoButtonVariant.primary,
                    icon: Icons.dashboard_rounded,
                    width: double.infinity,
                    onPressed: () => context.go(targetDashboard),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

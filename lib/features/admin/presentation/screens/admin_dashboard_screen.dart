import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.shield_rounded, color: SkeuoColors.alertRed, size: 28),
              const SizedBox(width: 10),
              Text(
                'SUPER ADMIN COMMAND CENTER',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'System-wide RBAC provisioning, immutable audit log monitoring, and gamification tuning.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Overview Status Cards
          Row(
            children: [
              Expanded(
                child: SkeuomorphicCard(
                  title: 'SYSTEM USERS LEDGER',
                  ledColor: SkeuoColors.activeGreen,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('42 Registered Accounts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 6),
                      Text('1 Super Admin • 2 Faculty • 5 Club Admins • 34 Students', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SkeuomorphicCard(
                  title: 'SECURITY & RECAPTCHA CHECK',
                  ledColor: SkeuoColors.primaryBlue,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('App Check Status: ACTIVE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 6),
                      SkeuomorphicBadge(label: 'ENFORCED • PLAY INTEGRITY & RECAPTCHA', color: SkeuoColors.activeGreen),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Core Management Modules
          SkeuomorphicCard(
            title: 'ADMINISTRATIVE MODULES',
            ledColor: SkeuoColors.accentAmber,
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SkeuomorphicButton(
                  label: 'OPEN IMMUTABLE AUDIT LOGS',
                  variant: SkeuoButtonVariant.primary,
                  icon: Icons.terminal_rounded,
                  onPressed: () => context.go('/admin/audit-logs'),
                ),
                SkeuomorphicButton(
                  label: 'CONFIGURE GAMIFICATION WEIGHTS',
                  variant: SkeuoButtonVariant.amber,
                  icon: Icons.tune_rounded,
                  onPressed: () => context.go('/admin/point-rules'),
                ),
                SkeuomorphicButton(
                  label: 'REVOKE CHARTER SAFETY SWITCH',
                  variant: SkeuoButtonVariant.crimson,
                  icon: Icons.warning_amber_rounded,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Safety switch primed. Select target club charter to revoke.'),
                        backgroundColor: SkeuoColors.alertRed,
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

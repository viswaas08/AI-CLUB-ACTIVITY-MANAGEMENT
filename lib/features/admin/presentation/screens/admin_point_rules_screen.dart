import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/admin_providers.dart';

class AdminPointRulesScreen extends ConsumerStatefulWidget {
  const AdminPointRulesScreen({super.key});

  @override
  ConsumerState<AdminPointRulesScreen> createState() => _AdminPointRulesScreenState();
}

class _AdminPointRulesScreenState extends ConsumerState<AdminPointRulesScreen> {
  double _workshopWeight = 50;
  double _hackathonWeight = 100;
  double _contestWeight = 75;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    final actionState = ref.watch(adminActionsControllerProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.tune_rounded, color: SkeuoColors.accentAmber, size: 28),
              const SizedBox(width: 10),
              Text(
                'GAMIFICATION WEIGHTS & POINT RULES',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Adjust points awarded across event categories dynamically via tactile control sliders.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          SkeuomorphicCard(
            title: 'TACTILE SLIDER DIALS • EVENT CATEGORY REWARDS',
            ledColor: SkeuoColors.accentAmber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Workshop Weight Slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Technical Workshop Base Points:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    SkeuomorphicBadge(label: '${_workshopWeight.toInt()} PTS', color: SkeuoColors.primaryBlue),
                  ],
                ),
                Slider(
                  value: _workshopWeight,
                  min: 10,
                  max: 200,
                  divisions: 19,
                  activeColor: SkeuoColors.primaryBlue,
                  onChanged: (val) => setState(() => _workshopWeight = val),
                ),
                const SizedBox(height: 16),

                // Hackathon Weight Slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Hackathon / Buildathon Base Points:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    SkeuomorphicBadge(label: '${_hackathonWeight.toInt()} PTS', color: SkeuoColors.activeGreen),
                  ],
                ),
                Slider(
                  value: _hackathonWeight,
                  min: 50,
                  max: 500,
                  divisions: 45,
                  activeColor: SkeuoColors.activeGreen,
                  onChanged: (val) => setState(() => _hackathonWeight = val),
                ),
                const SizedBox(height: 16),

                // Contest Weight Slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Coding Contest & Quiz Base Points:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    SkeuomorphicBadge(label: '${_contestWeight.toInt()} PTS', color: SkeuoColors.accentAmber),
                  ],
                ),
                Slider(
                  value: _contestWeight,
                  min: 20,
                  max: 300,
                  divisions: 28,
                  activeColor: SkeuoColors.accentAmber,
                  onChanged: (val) => setState(() => _contestWeight = val),
                ),
                const SizedBox(height: 24),

                SkeuomorphicButton(
                  label: 'SAVE POINT WEIGHT CONFIGURATION',
                  variant: SkeuoButtonVariant.amber,
                  icon: Icons.save_rounded,
                  isLoading: actionState.isLoading,
                  width: double.infinity,
                  onPressed: user == null
                      ? null
                      : () async {
                          final success = await ref
                              .read(adminActionsControllerProvider.notifier)
                              .updatePointRuleWeight('RULE-WORKSHOP', _workshopWeight.toInt(), user.id);

                          if (success && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Gamification weights updated & logged to audit ledger!'),
                                backgroundColor: SkeuoColors.activeGreen,
                              ),
                            );
                          }
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

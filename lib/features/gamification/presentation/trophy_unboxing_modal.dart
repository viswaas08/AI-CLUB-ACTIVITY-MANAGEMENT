import 'package:flutter/material.dart';
import '../../../core/theme/skeuo_theme.dart';
import '../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../shared/widgets/skeuo/skeuo_card.dart';

class TrophyUnboxingModal extends StatefulWidget {
  final String title;
  final String description;
  final String tier;

  const TrophyUnboxingModal({
    super.key,
    required this.title,
    required this.description,
    required this.tier,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String description,
    required String tier,
  }) {
    return showDialog(
      context: context,
      builder: (_) => TrophyUnboxingModal(
        title: title,
        description: description,
        tier: tier,
      ),
    );
  }

  @override
  State<TrophyUnboxingModal> createState() => _TrophyUnboxingModalState();
}

class _TrophyUnboxingModalState extends State<TrophyUnboxingModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;
  late Animation<double> _rotationAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _scaleAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );

    _rotationAnim = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: RotationTransition(
        turns: _rotationAnim,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: SkeuomorphicCard(
            title: 'TROPHY UNBOXING REVEAL',
            ledColor: SkeuoColors.accentAmber,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 3D Unboxing Box & Glowing Emblem
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: SkeuoColors.accentAmber.withValues(alpha: 0.2),
                    border: Border.all(color: SkeuoColors.accentAmber, width: 3),
                    boxShadow: const [
                      BoxShadow(
                        color: SkeuoColors.accentAmber,
                        blurRadius: 20,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.emoji_events_rounded, size: 68, color: SkeuoColors.accentAmber),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  widget.title.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 16),

                SkeuomorphicBadge(
                  label: '${widget.tier.toUpperCase()} TIER UNLOCKED',
                  color: SkeuoColors.accentAmber,
                ),
                const SizedBox(height: 24),

                SkeuomorphicButton(
                  label: 'CLAIM TROPHY',
                  variant: SkeuoButtonVariant.amber,
                  width: double.infinity,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

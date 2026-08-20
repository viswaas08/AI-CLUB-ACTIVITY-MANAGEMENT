import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/skeuo_theme.dart';
import '../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../auth/application/auth_providers.dart';
import '../data/recommendation_service.dart';

class RecommendedEventsCard extends ConsumerStatefulWidget {
  const RecommendedEventsCard({super.key});

  @override
  ConsumerState<RecommendedEventsCard> createState() => _RecommendedEventsCardState();
}

class _RecommendedEventsCardState extends ConsumerState<RecommendedEventsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
    ));

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    if (user == null) return const SizedBox.shrink();

    final recsAsync = ref.watch(recommendedEventsProvider(user));

    return SlideTransition(
      position: _slideAnimation,
      child: SkeuomorphicCard(
        title: 'RECOMMENDED FOR YOU • AI DISCOVERY ENGINE',
        ledColor: SkeuoColors.accentAmber,
        child: recsAsync.when(
          data: (recs) {
            if (recs.isEmpty) {
              return const Text('No event recommendations available at this time.');
            }

            final topRec = recs.first;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      topRec.event.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SkeuomorphicBadge(
                      label: '${topRec.matchPercentage}% MATCH',
                      color: SkeuoColors.activeGreen,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  topRec.event.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    const Icon(Icons.auto_awesome_rounded, color: SkeuoColors.accentAmber, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        topRec.reasoning,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: SkeuoColors.accentAmber,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          loading: () => const LinearProgressIndicator(),
          error: (err, stack) => const Text('Error generating AI recommendations'),
        ),
      ),
    );
  }
}

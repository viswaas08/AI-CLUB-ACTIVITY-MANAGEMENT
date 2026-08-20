import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_tabs.dart';
import '../../../events/domain/models/event_model.dart';
import '../../application/student_providers.dart';

class StudentEventsScreen extends ConsumerStatefulWidget {
  const StudentEventsScreen({super.key});

  @override
  ConsumerState<StudentEventsScreen> createState() => _StudentEventsScreenState();
}

class _StudentEventsScreenState extends ConsumerState<StudentEventsScreen> {
  int _selectedFilterIndex = 0; // 0: All, 1: Workshop, 2: Hackathon, 3: Competition

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(upcomingEventsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CAMPUS EVENT EXPLORER',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Explore upcoming workshops, hackathons, and guest lectures to earn activity points.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          SkeuomorphicTab(
            tabs: const ['All Events', 'Workshops', 'Hackathons', 'Competitions'],
            selectedIndex: _selectedFilterIndex,
            onTabSelected: (idx) => setState(() => _selectedFilterIndex = idx),
          ),
          const SizedBox(height: 24),

          eventsAsync.when(
            data: (events) {
              final filtered = events.where((e) {
                if (_selectedFilterIndex == 0) return true;
                if (_selectedFilterIndex == 1) return e.category == EventCategory.workshop;
                if (_selectedFilterIndex == 2) return e.category == EventCategory.hackathon;
                if (_selectedFilterIndex == 3) return e.category == EventCategory.competition;
                return true;
              }).toList();

              if (filtered.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Events Found',
                  ledColor: SkeuoColors.accentAmber,
                  child: Text('No upcoming events currently match the selected filter.'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final event = filtered[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isDark ? const Color(0xFF1E2430) : const Color(0xFFFFFFFF),
                      boxShadow: SkeuoShadows.raisedLevel1(isDark: isDark),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: SkeuoColors.primaryBlue.withValues(alpha: 0.15),
                          ),
                          child: const Icon(
                            Icons.event_seat_rounded,
                            size: 32,
                            color: SkeuoColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SkeuomorphicBadge(
                                    label: event.category.name.toUpperCase(),
                                    color: SkeuoColors.activeGreen,
                                  ),
                                  const SizedBox(width: 8),
                                  SkeuomorphicBadge(
                                    label: event.mode.name.toUpperCase(),
                                    color: SkeuoColors.accentAmber,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                event.title,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${event.registeredCount} Registered • Yield: +${event.basePoints} Pts',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        SkeuomorphicButton(
                          label: 'VIEW & REGISTER',
                          variant: SkeuoButtonVariant.primary,
                          height: 36.0,
                          onPressed: () => context.push('/student/events/${event.id}'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading events'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_dialog.dart';
import '../../../../shared/widgets/skeuo/skeuo_input.dart';
import '../../../events/domain/models/event_model.dart';
import '../../application/club_providers.dart';

class ClubEventsScreen extends ConsumerStatefulWidget {
  const ClubEventsScreen({super.key});

  @override
  ConsumerState<ClubEventsScreen> createState() => _ClubEventsScreenState();
}

class _ClubEventsScreenState extends ConsumerState<ClubEventsScreen> {
  bool _showCreateForm = false;

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  final _pointsController = TextEditingController(text: '50');
  final _seatsController = TextEditingController(text: '100');

  final EventCategory _selectedCategory = EventCategory.workshop;
  final EventMode _selectedMode = EventMode.inPerson;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _locationController.dispose();
    _pointsController.dispose();
    _seatsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(clubEventsProvider);
    final selectedClubId = ref.watch(selectedAdminClubIdProvider);
    final actionState = ref.watch(clubAdminActionsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EVENT LIFECYCLE MANAGEMENT',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Create events, manage approval state, or invoke emergency event cancellations.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SkeuomorphicButton(
                label: _showCreateForm ? 'CANCEL FORM' : '+ CREATE EVENT',
                variant: _showCreateForm ? SkeuoButtonVariant.secondary : SkeuoButtonVariant.primary,
                onPressed: () => setState(() => _showCreateForm = !_showCreateForm),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Multi-Step Form Card
          if (_showCreateForm) ...[
            SkeuomorphicCard(
              title: 'EVENT CREATOR CONSOLE (PENDING FACULTY APPROVAL)',
              ledColor: SkeuoColors.accentAmber,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeuomorphicInput(
                    controller: _titleController,
                    label: 'EVENT TITLE',
                    prefixIcon: Icons.title_rounded,
                  ),
                  const SizedBox(height: 16),
                  SkeuomorphicInput(
                    controller: _descController,
                    label: 'EVENT DESCRIPTION',
                    prefixIcon: Icons.notes_rounded,
                  ),
                  const SizedBox(height: 16),
                  SkeuomorphicInput(
                    controller: _locationController,
                    label: 'LOCATION / MEETING LINK',
                    prefixIcon: Icons.location_on_rounded,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SkeuomorphicInput(
                          controller: _pointsController,
                          label: 'BASE POINTS YIELD',
                          prefixIcon: Icons.workspace_premium_rounded,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SkeuomorphicInput(
                          controller: _seatsController,
                          label: 'MAXIMUM SEATS CAPACITY',
                          prefixIcon: Icons.airline_seat_recline_normal_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SkeuomorphicButton(
                    label: 'SUBMIT EVENT FOR FACULTY APPROVAL',
                    variant: SkeuoButtonVariant.primary,
                    isLoading: actionState.isLoading,
                    onPressed: selectedClubId == null
                        ? null
                        : () async {
                            final success = await ref
                                .read(clubAdminActionsControllerProvider.notifier)
                                .createEvent(
                                  title: _titleController.text,
                                  description: _descController.text,
                                  clubId: selectedClubId,
                                  category: _selectedCategory,
                                  mode: _selectedMode,
                                  date: DateTime.now().add(const Duration(days: 7)),
                                  basePoints: int.tryParse(_pointsController.text) ?? 50,
                                  maxSeats: int.tryParse(_seatsController.text) ?? 100,
                                  location: _locationController.text,
                                );

                            if (success && context.mounted) {
                              setState(() => _showCreateForm = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Event submitted for Faculty Approval.'),
                                  backgroundColor: SkeuoColors.activeGreen,
                                ),
                              );
                            }
                          },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Hosted Events List
          eventsAsync.when(
            data: (events) {
              if (events.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Events Created',
                  ledColor: SkeuoColors.primaryBlue,
                  child: Text('No events have been created for this club society yet.'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  final isCancelled = event.status == EventStatus.cancelled;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isDark ? const Color(0xFF1E2430) : const Color(0xFFFFFFFF),
                      boxShadow: SkeuoShadows.raisedLevel1(isDark: isDark),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              event.title,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SkeuomorphicBadge(
                              label: event.status.name.toUpperCase(),
                              color: isCancelled
                                  ? SkeuoColors.alertRed
                                  : (event.status == EventStatus.approved
                                      ? SkeuoColors.activeGreen
                                      : SkeuoColors.accentAmber),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Category: ${event.category.name} • Yield: +${event.basePoints} Pts • Registered: ${event.registeredCount} / ${event.maxSeats ?? 100}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                        ),
                        const SizedBox(height: 12),

                        if (!isCancelled)
                          SkeuomorphicButton(
                            label: 'EMERGENCY ABORT / CANCEL EVENT',
                            variant: SkeuoButtonVariant.crimson,
                            height: 36.0,
                            icon: Icons.cancel_rounded,
                            onPressed: () {
                              SkeuomorphicDialog.show(
                                context,
                                title: 'EMERGENCY CANCEL CONFIRMATION',
                                message: 'Are you sure you want to cancel "${event.title}"? All registered students will be notified.',
                                confirmLabel: 'Confirm Cancellation',
                                onConfirm: () {
                                  ref
                                      .read(clubAdminActionsControllerProvider.notifier)
                                      .cancelEvent(event.id, 'Administrative Emergency Abort');
                                },
                              );
                            },
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

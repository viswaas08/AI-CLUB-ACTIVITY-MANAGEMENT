import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_tabs.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../events/domain/models/event_model.dart';
import '../../application/faculty_providers.dart';

class FacultyEventsScreen extends ConsumerStatefulWidget {
  const FacultyEventsScreen({super.key});

  @override
  ConsumerState<FacultyEventsScreen> createState() => _FacultyEventsScreenState();
}

class _FacultyEventsScreenState extends ConsumerState<FacultyEventsScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0; // 0: Pending, 1: Approved, 2: Rejected
  late AnimationController _stampController;
  late Animation<double> _stampScaleAnimation;
  String? _stampedEventId;

  @override
  void initState() {
    super.initState();
    _stampController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _stampScaleAnimation = CurvedAnimation(
      parent: _stampController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _stampController.dispose();
    super.dispose();
  }

  void _triggerApprovalStamp(String eventId) {
    setState(() => _stampedEventId = eventId);
    _stampController.reset();
    _stampController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    final eventsAsync = ref.watch(pendingEventApprovalsProvider);
    final actionState = ref.watch(facultyActionsControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final statuses = ['Pending Approval', 'Approved', 'Rejected'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EVENT APPROVAL PIPELINE & DOSSIERS',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Review club event proposals, verify safety/budget requirements, and stamp departmental approvals.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          SkeuomorphicTab(
            tabs: statuses,
            selectedIndex: _selectedTabIndex,
            onTabSelected: (idx) => setState(() => _selectedTabIndex = idx),
          ),
          const SizedBox(height: 24),

          eventsAsync.when(
            data: (events) {
              final filteredEvents = events.where((e) {
                if (_selectedTabIndex == 0) return e.status == EventStatus.pendingApproval;
                if (_selectedTabIndex == 1) return e.status == EventStatus.approved;
                return e.status == EventStatus.rejected;
              }).toList();

              if (filteredEvents.isEmpty) {
                return SkeuomorphicCard(
                  title: 'No Events in Pipeline',
                  ledColor: SkeuoColors.accentAmber,
                  child: Text('No events matching "${statuses[_selectedTabIndex]}".'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = filteredEvents[index];
                  final isStamped = _stampedEventId == event.id;

                  return Stack(
                    children: [
                      // Physical Paper/Cardboard Dossier Card
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: isDark ? const Color(0xFF1E2430) : const Color(0xFFFFFDF5),
                          border: Border.all(
                            color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                            width: 2,
                          ),
                          boxShadow: SkeuoShadows.raisedLevel2(isDark: isDark),
                        ),
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
                                      'PROPOSAL DOSSIER • #${event.id.substring(0, event.id.length.clamp(0, 8))}',
                                      style: const TextStyle(
                                        fontFamily: 'Orbitron',
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: SkeuoColors.accentAmber,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      event.title,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                  ],
                                ),
                                SkeuomorphicBadge(
                                  label: event.status.name.toUpperCase(),
                                  color: event.status == EventStatus.approved
                                      ? SkeuoColors.activeGreen
                                      : (event.status == EventStatus.pendingApproval
                                          ? SkeuoColors.accentAmber
                                          : SkeuoColors.alertRed),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              event.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),

                            Row(
                              children: [
                                const Icon(Icons.place_rounded, size: 16, color: SkeuoColors.primaryBlue),
                                const SizedBox(width: 6),
                                Text('Venue: ${event.venue ?? 'Main Campus Auditorium'}', style: const TextStyle(fontSize: 12)),
                                const SizedBox(width: 20),
                                const Icon(Icons.stars_rounded, size: 16, color: SkeuoColors.accentAmber),
                                const SizedBox(width: 6),
                                Text('Points Requested: ${event.basePoints} PTS', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 20),

                            if (event.status == EventStatus.pendingApproval) ...[
                              Row(
                                children: [
                                  Expanded(
                                    child: SkeuomorphicButton(
                                      label: 'STAMP APPROVAL',
                                      variant: SkeuoButtonVariant.primary,
                                      icon: Icons.check_circle_rounded,
                                      isLoading: actionState.isLoading,
                                      onPressed: user == null
                                          ? null
                                          : () async {
                                              _triggerApprovalStamp(event.id);
                                              final success = await ref
                                                  .read(facultyActionsControllerProvider.notifier)
                                                  .approveEvent(event.id, user.id);

                                              if (success && context.mounted) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Event Approved & Stamped Official!'),
                                                    backgroundColor: SkeuoColors.activeGreen,
                                                  ),
                                                );
                                              }
                                            },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: SkeuomorphicButton(
                                      label: 'REJECT PROPOSAL',
                                      variant: SkeuoButtonVariant.crimson,
                                      icon: Icons.cancel_rounded,
                                      isLoading: actionState.isLoading,
                                      onPressed: user == null
                                          ? null
                                          : () async {
                                              final success = await ref
                                                  .read(facultyActionsControllerProvider.notifier)
                                                  .rejectEvent(event.id, user.id, 'Budget details insufficient.');

                                              if (success && context.mounted) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Event Proposal Rejected.'),
                                                    backgroundColor: SkeuoColors.alertRed,
                                                  ),
                                                );
                                              }
                                            },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      // 3D "APPROVED" Imprint Stamp Animation Overlay
                      if (isStamped)
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: ScaleTransition(
                                scale: _stampScaleAnimation,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: SkeuoColors.activeGreen, width: 4),
                                    color: SkeuoColors.activeGreen.withValues(alpha: 0.2),
                                  ),
                                  child: const Text(
                                    'APPROVED',
                                    style: TextStyle(
                                      fontFamily: 'Orbitron',
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                      color: SkeuoColors.activeGreen,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading approval pipeline'),
          ),
        ],
      ),
    );
  }
}

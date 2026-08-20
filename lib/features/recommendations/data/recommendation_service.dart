import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/domain/app_user.dart';
import '../../events/data/repositories/event_repository.dart';
import '../../events/domain/models/event_model.dart';

class EventRecommendation {
  final EventModel event;
  final int matchPercentage;
  final String reasoning;

  EventRecommendation({
    required this.event,
    required this.matchPercentage,
    required this.reasoning,
  });
}

final recommendedEventsProvider = FutureProvider.family<List<EventRecommendation>, AppUser>((ref, user) async {
  final eventRepo = ref.watch(eventRepositoryProvider);
  final upcomingEvents = await eventRepo.streamUpcomingEvents().first;

  if (upcomingEvents.isEmpty) return [];

  // Deterministic Recommendation Engine
  final recommendations = upcomingEvents.map((event) {
    int score = 70; // Base score
    final reasons = <String>[];

    // High Reward Points Match (+15%)
    if (event.basePoints >= 80) {
      score += 15;
      reasons.add('High reward value (+${event.basePoints} PTS)');
    }

    // Category Alignment Match (+10%)
    if (event.category == EventCategory.workshop || event.category == EventCategory.hackathon) {
      score += 10;
      reasons.add('Recommended for ${event.category.name.toUpperCase()} skill building');
    }

    // Default Reasoning
    if (reasons.isEmpty) {
      reasons.add('Popular activity among ${user.departmentId ?? "Engineering"} peers');
    }

    return EventRecommendation(
      event: event,
      matchPercentage: score.clamp(0, 99),
      reasoning: reasons.join(' • '),
    );
  }).toList();

  recommendations.sort((a, b) => b.matchPercentage.compareTo(a.matchPercentage));
  return recommendations.take(3).toList();
});

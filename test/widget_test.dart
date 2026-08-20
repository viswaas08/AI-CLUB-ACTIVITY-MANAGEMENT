import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_club_activity_analysis/features/auth/application/auth_providers.dart';
import 'package:student_club_activity_analysis/main.dart';

void main() {
  testWidgets('App initialization smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authStateChangesProvider.overrideWith((ref) => Stream.value(null)),
          currentUserProvider.overrideWith((ref) => Stream.value(null)),
        ],
        child: const StudentClubApp(),
      ),
    );
    expect(find.byType(StudentClubApp), findsOneWidget);
  });
}

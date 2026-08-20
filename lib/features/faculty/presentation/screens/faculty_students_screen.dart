import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_dialog.dart';
import '../../application/faculty_providers.dart';

class FacultyStudentsScreen extends ConsumerWidget {
  const FacultyStudentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsAsync = ref.watch(facultyStudentsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DEPARTMENTAL STUDENT DIRECTORY',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Search students in your department and inspect their Digital Activity Passport in read-only mode.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          studentsAsync.when(
            data: (students) {
              if (students.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Students Found',
                  ledColor: SkeuoColors.accentAmber,
                  child: Text('No students registered under your department ID.'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      SkeuomorphicDialog.show(
                        context,
                        title: 'DIGITAL PASSPORT • ${student.displayName}',
                        message: 'Roll No: ${student.studentRollNo}\nTotal Points: ${student.totalPoints} PTS\nActive Streak: ${student.streakDays} Days\nDepartment: CS & AI',
                        confirmLabel: 'Close Passport',
                        onConfirm: () {},
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isDark ? const Color(0xFF1E2430) : const Color(0xFFFFFFFF),
                        boxShadow: SkeuoShadows.raisedLevel1(isDark: isDark),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: SkeuoColors.primaryBlue.withValues(alpha: 0.2),
                            child: Text(
                              student.displayName?.substring(0, 1) ?? 'S',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: SkeuoColors.primaryBlue),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student.displayName ?? 'Student Name',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Roll No: ${student.studentRollNo} • ${student.email}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          SkeuomorphicBadge(
                            label: '${student.streakDays} DAY STREAK',
                            color: SkeuoColors.accentAmber,
                          ),
                          const SizedBox(width: 10),
                          SkeuomorphicBadge(
                            label: '${student.totalPoints} PTS',
                            color: SkeuoColors.activeGreen,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error loading student directory'),
          ),
        ],
      ),
    );
  }
}

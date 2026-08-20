import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../../../shared/widgets/skeuo/skeuo_badge.dart';
import '../../../../shared/widgets/skeuo/skeuo_button.dart';
import '../../../../shared/widgets/skeuo/skeuo_card.dart';
import '../../../../shared/widgets/skeuo/skeuo_input.dart';
import '../../../../shared/widgets/skeuo/skeuo_tabs.dart';
import '../../../clubs/domain/models/club_model.dart';
import '../../application/student_providers.dart';

class StudentClubsScreen extends ConsumerStatefulWidget {
  const StudentClubsScreen({super.key});

  @override
  ConsumerState<StudentClubsScreen> createState() => _StudentClubsScreenState();
}

class _StudentClubsScreenState extends ConsumerState<StudentClubsScreen> {
  final _searchController = TextEditingController();
  int _selectedCategoryIndex = 0; // 0: All, 1: AI, 2: Robotics, 3: Coding, 4: Technical

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clubsAsync = ref.watch(allClubsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CLUB SOCIETIES DIRECTORY',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 4),
          Text(
            'Discover and join official university technical and AI activity clubs.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          // Search & Filter Bar
          Row(
            children: [
              Expanded(
                child: SkeuomorphicInput(
                  controller: _searchController,
                  label: 'SEARCH CLUBS',
                  hintText: 'Search clubs by name or keyword...',
                  prefixIcon: Icons.search_rounded,
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Category Toggle Switch Tabs
          SkeuomorphicTab(
            tabs: const ['All Clubs', 'AI', 'Robotics', 'Coding', 'Technical'],
            selectedIndex: _selectedCategoryIndex,
            onTabSelected: (idx) => setState(() => _selectedCategoryIndex = idx),
          ),
          const SizedBox(height: 24),

          // Clubs Grid
          clubsAsync.when(
            data: (clubs) {
              final query = _searchController.text.toLowerCase();
              final filtered = clubs.where((c) {
                final matchesSearch = c.name.toLowerCase().contains(query) ||
                    c.description.toLowerCase().contains(query);
                if (_selectedCategoryIndex == 0) return matchesSearch;
                if (_selectedCategoryIndex == 1) return matchesSearch && c.category == ClubCategory.ai;
                if (_selectedCategoryIndex == 2) return matchesSearch && c.category == ClubCategory.robotics;
                if (_selectedCategoryIndex == 3) return matchesSearch && c.category == ClubCategory.coding;
                if (_selectedCategoryIndex == 4) return matchesSearch && c.category == ClubCategory.technical;
                return matchesSearch;
              }).toList();

              if (filtered.isEmpty) {
                return const SkeuomorphicCard(
                  title: 'No Clubs Found',
                  ledColor: SkeuoColors.accentAmber,
                  child: Text('No active club societies matched your search criteria.'),
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 800 ? 3 : (constraints.maxWidth > 500 ? 2 : 1);
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.4,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final club = filtered[index];
                      return Container(
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
                                SkeuomorphicBadge(
                                  label: club.category.label,
                                  color: SkeuoColors.primaryBlue,
                                ),
                                Text(
                                  '${club.totalMembers} Members',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              club.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Expanded(
                              child: Text(
                                club.description,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SkeuomorphicButton(
                              label: 'VIEW CLUB DETAILS',
                              variant: SkeuoButtonVariant.primary,
                              height: 36.0,
                              width: double.infinity,
                              onPressed: () => context.push('/student/clubs/${club.id}'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Text('Error fetching club directory'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/responsive/responsive_layout.dart';
import '../../../core/theme/organic_theme.dart';
import '../../../shared/widgets/organic/dewdrop_button.dart';
import '../../../shared/widgets/organic/eco_glass_card.dart';
import '../../../shared/widgets/organic/magnetic_glass_card.dart';
import '../../auth/application/auth_providers.dart';
import 'widgets/fluid_custom_cursor.dart';
import 'widgets/interactive_background_painter.dart';

class MajorClubItem {
  final String name;
  final String category;
  final String description;
  final String memberCount;
  final IconData icon;
  final Color themeColor;

  const MajorClubItem({
    required this.name,
    required this.category,
    required this.description,
    required this.memberCount,
    required this.icon,
    required this.themeColor,
  });
}

const List<MajorClubItem> majorClubs = [
  MajorClubItem(
    name: 'AI & ML Society',
    category: 'ARTIFICIAL INTELLIGENCE',
    description: 'Pioneering generative models, deep learning research, and ethical AI deployment on campus.',
    memberCount: '142 Active Members',
    icon: Icons.psychology_rounded,
    themeColor: Color(0xFF15803D),
  ),
  MajorClubItem(
    name: 'Robotics & Autonomy Guild',
    category: 'HARDWARE & ROBOTICS',
    description: 'Building autonomous drones, rover hardware, and real-time ROS2 embedded systems.',
    memberCount: '98 Active Members',
    icon: Icons.precision_manufacturing_rounded,
    themeColor: Color(0xFFC2410C),
  ),
  MajorClubItem(
    name: 'CyberSecurity & Ethics',
    category: 'INFRASTRUCTURE & DEFENSE',
    description: 'Competing in international CTF events, vulnerability audits, and zero-trust security research.',
    memberCount: '115 Active Members',
    icon: Icons.security_rounded,
    themeColor: Color(0xFF9A3412),
  ),
  MajorClubItem(
    name: 'Data Science Association',
    category: 'ANALYTICS & BIG DATA',
    description: 'Analyzing high-dimensional datasets, predictive student drop-off radar, and visual storytelling.',
    memberCount: '160 Active Members',
    icon: Icons.analytics_rounded,
    themeColor: Color(0xFF166534),
  ),
  MajorClubItem(
    name: 'Quantum Computing Lab',
    category: 'QUANTUM & PHYSICS',
    description: 'Exploring Qiskit circuit optimization, quantum encryption algorithms, and hybrid simulations.',
    memberCount: '65 Active Members',
    icon: Icons.blur_circular_rounded,
    themeColor: Color(0xFF0D9488),
  ),
];

class OrganicLandingScreen extends ConsumerStatefulWidget {
  const OrganicLandingScreen({super.key});

  @override
  ConsumerState<OrganicLandingScreen> createState() => _OrganicLandingScreenState();
}

class _OrganicLandingScreenState extends ConsumerState<OrganicLandingScreen> {
  Offset _mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final appUser = ref.watch(currentUserProvider).value;
    final isLightGreen = ref.watch(isLightGreenThemeProvider);

    final textColor = isLightGreen ? OrganicColors.textDarkForest : OrganicColors.textIvoryWhite;
    final subtextColor = isLightGreen ? OrganicColors.textSubtleEmerald : OrganicColors.textSoftMoss;

    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onHover: (event) {
        setState(() {
          _mousePosition = event.position;
        });
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // 1. Interactive Nature Repulsion Background Canvas
            Positioned.fill(
              child: RepaintBoundary(
                child: InteractiveParticleCanvas(
                  mousePosition: _mousePosition,
                  child: const SizedBox.expand(),
                ),
              ),
            ),

            // 2. Trailing Firefly Ambient Glow
            FluidCustomCursor(
              mousePosition: _mousePosition,
            ),

            // 3. Main Scrollable Landing Content
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Top Navigation Header
                    _buildTopNav(context, ref, appUser, isLightGreen),

                    // Landing Body Container
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Hero Banner
                            _buildHeroSection(context, appUser, isLightGreen, textColor, subtextColor),

                            const SizedBox(height: 50),

                            // Major Featured Clubs Showcase
                            _buildMajorClubsSection(context, isLightGreen, textColor, subtextColor),

                            const SizedBox(height: 60),

                            // Core Platform Capabilities
                            _buildPlatformCapabilities(context, isLightGreen, textColor, subtextColor),

                            const SizedBox(height: 60),

                            // Role Portals Direct Navigation Matrix
                            _buildRoleAccessMatrix(context, isLightGreen, textColor, subtextColor),

                            const SizedBox(height: 60),

                            // Campus Real-time Impact Metrics Bar
                            _buildLiveStatsBar(context, isLightGreen, textColor, subtextColor),

                            const SizedBox(height: 80),

                            // Footer
                            _buildFooter(isLightGreen, textColor, subtextColor),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNav(BuildContext context, WidgetRef ref, dynamic appUser, bool isLightGreen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: isLightGreen
            ? Colors.white.withValues(alpha: 0.85)
            : const Color(0xFF0F2922).withValues(alpha: 0.85),
        border: Border(
          bottom: BorderSide(
            color: isLightGreen ? OrganicColors.glassBorderLightGreen : OrganicColors.glassBorder,
            width: 1.0,
          ),
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Brand Logo & Title
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isLightGreen ? OrganicColors.accentEmeraldMedium : OrganicColors.accentSage,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.eco_rounded, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CAMPUS ACTIVITY RADAR',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                          color: isLightGreen ? OrganicColors.textDarkForest : OrganicColors.textIvoryWhite,
                        ),
                      ),
                      Text(
                        'AI-Powered Student Organization Portal',
                        style: TextStyle(
                          fontSize: 11,
                          color: isLightGreen ? OrganicColors.textSubtleEmerald : OrganicColors.textSoftMoss,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Action Buttons & Theme Switcher
              Row(
                children: [
                  // Theme Mode Toggle Button
                  DewdropButton(
                    label: isLightGreen ? 'DARK FOREST' : 'LIGHT GREEN',
                    icon: isLightGreen ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    variant: DewdropButtonVariant.translucent,
                    height: 36,
                    onPressed: () {
                      ref.read(isLightGreenThemeProvider.notifier).state = !isLightGreen;
                    },
                  ),
                  const SizedBox(width: 12),

                  if (appUser == null) ...[
                    DewdropButton(
                      label: 'SIGN IN',
                      variant: DewdropButtonVariant.translucent,
                      height: 36,
                      icon: Icons.login_rounded,
                      onPressed: () => context.push('/auth/login'),
                    ),
                    const SizedBox(width: 10),
                    DewdropButton(
                      label: 'REGISTER',
                      variant: DewdropButtonVariant.terracotta,
                      height: 36,
                      icon: Icons.person_add_rounded,
                      onPressed: () => context.push('/register'),
                    ),
                  ] else ...[
                    DewdropButton(
                      label: 'ACCESS DASHBOARD',
                      variant: DewdropButtonVariant.sage,
                      height: 36,
                      icon: Icons.dashboard_rounded,
                      onPressed: () => context.go('/student'),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(
    BuildContext context,
    dynamic appUser,
    bool isLightGreen,
    Color textColor,
    Color subtextColor,
  ) {
    return ResponsiveLayout(
      mobile: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroText(context, appUser, isLightGreen, textColor, subtextColor),
          const SizedBox(height: 24),
          _buildHeroBadgeCard(context, isLightGreen, textColor, subtextColor),
        ],
      ),
      desktop: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: _buildHeroText(context, appUser, isLightGreen, textColor, subtextColor),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 4,
            child: _buildHeroBadgeCard(context, isLightGreen, textColor, subtextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroText(
    BuildContext context,
    dynamic appUser,
    bool isLightGreen,
    Color textColor,
    Color subtextColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: (isLightGreen ? OrganicColors.accentEmeraldMedium : OrganicColors.accentSage)
                .withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isLightGreen ? OrganicColors.accentEmeraldMedium : OrganicColors.accentSage,
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                size: 14,
                color: isLightGreen ? OrganicColors.accentEmeraldMedium : OrganicColors.accentSage,
              ),
              const SizedBox(width: 6),
              Text(
                'CAMPUS INTELLIGENCE & ENGAGEMENT',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: isLightGreen ? OrganicColors.textDarkForest : OrganicColors.textIvoryWhite,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'AI Clubs & Student Activities Portal',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 38,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            height: 1.15,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'The central hub for managing campus clubs, real-time QR attendance tracking, cryptographic certificate verification, and predictive engagement pathing.',
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: subtextColor,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            DewdropButton(
              label: appUser != null ? 'GO TO DASHBOARD' : 'LOGIN TO ACCESS PORTAL',
              variant: DewdropButtonVariant.sage,
              height: 46,
              icon: Icons.arrow_forward_rounded,
              onPressed: () {
                if (appUser != null) {
                  context.go('/student');
                } else {
                  context.push('/auth/login');
                }
              },
            ),
            if (appUser == null)
              DewdropButton(
                label: 'DEMO ACCESS',
                variant: DewdropButtonVariant.translucent,
                height: 46,
                icon: Icons.bolt_rounded,
                onPressed: () => context.push('/auth/login'),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroBadgeCard(
    BuildContext context,
    bool isLightGreen,
    Color textColor,
    Color subtextColor,
  ) {
    return MagneticGlassCard(
      title: 'INSTITUTIONAL ACCESS PORTAL',
      statusIndicatorColor: isLightGreen ? OrganicColors.accentEmeraldMedium : OrganicColors.accentSage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF16A34A),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'ZERO-TRUST AUTHENTICATION ACTIVE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Logging in automatically routes you to your authorized panel (Student, Club Admin, Faculty Advisor, or Super Admin).',
            style: TextStyle(fontSize: 13, height: 1.5, color: subtextColor),
          ),
          const SizedBox(height: 20),
          DewdropButton(
            label: 'GO TO LOGIN SCREEN',
            variant: DewdropButtonVariant.sage,
            width: double.infinity,
            height: 42,
            icon: Icons.login_rounded,
            onPressed: () => context.push('/auth/login'),
          ),
        ],
      ),
    );
  }

  Widget _buildMajorClubsSection(
    BuildContext context,
    bool isLightGreen,
    Color textColor,
    Color subtextColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FEATURED MAJOR CLUBS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: isLightGreen ? OrganicColors.accentEmeraldMedium : OrganicColors.accentSage,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Explore Campus Innovation Organizations',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                  ),
                ),
              ],
            ),
            DewdropButton(
              label: 'VIEW ALL CLUBS',
              variant: DewdropButtonVariant.translucent,
              height: 38,
              icon: Icons.arrow_forward_rounded,
              onPressed: () => context.push('/auth/login'),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Responsive Cards Wrap
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = constraints.maxWidth > 900
                ? (constraints.maxWidth - 40) / 3
                : (constraints.maxWidth > 600
                    ? (constraints.maxWidth - 20) / 2
                    : constraints.maxWidth);

            return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: majorClubs.map((club) {
                return SizedBox(
                  width: cardWidth,
                  child: MagneticGlassCard(
                    title: club.name,
                    statusIndicatorColor: club.themeColor,
                    isOrganicLeafShape: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: club.themeColor.withValues(alpha: isLightGreen ? 0.12 : 0.25),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: club.themeColor.withValues(alpha: 0.35),
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            club.category,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.6,
                              color: club.themeColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          club.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: subtextColor, height: 1.4),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              club.memberCount,
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: textColor),
                            ),
                            DewdropButton(
                              label: 'ACCESS',
                              variant: DewdropButtonVariant.sage,
                              height: 32,
                              onPressed: () => context.push('/auth/login'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPlatformCapabilities(
    BuildContext context,
    bool isLightGreen,
    Color textColor,
    Color subtextColor,
  ) {
    final capabilities = [
      {
        'title': 'Real-Time QR Attendance',
        'desc': 'Single-use cryptographic nonce dynamic QR codes that refresh every 15s to guarantee physical presence.',
        'icon': Icons.qr_code_scanner_rounded,
        'color': OrganicColors.accentEmeraldMedium,
      },
      {
        'title': 'Predictive Drop-Off Radar',
        'desc': 'AI analytics identifying low-engagement members before semester drop-offs to trigger recovery pathways.',
        'icon': Icons.radar_rounded,
        'color': OrganicColors.accentTerracotta,
      },
      {
        'title': 'Verifiable PDF Certificates',
        'desc': 'Instant tamper-proof certificate issuance with SHA-256 signatures and instant URL verification proofs.',
        'icon': Icons.verified_rounded,
        'color': OrganicColors.accentClay,
      },
      {
        'title': 'Civic Proposals & Voting',
        'desc': 'Campus innovation project pitching with quadratic upvoting, mentor milestone tracking, and budget grants.',
        'icon': Icons.how_to_vote_rounded,
        'color': OrganicColors.accentSage,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PLATFORM ARCHITECTURE',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: isLightGreen ? OrganicColors.accentEmeraldMedium : OrganicColors.accentSage,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Engineered for Academic Excellence',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth > 900
                ? (constraints.maxWidth - 30) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: capabilities.map((cap) {
                final capColor = cap['color'] as Color;
                return SizedBox(
                  width: itemWidth,
                  child: EcoGlassCard(
                    title: cap['title'] as String,
                    statusIndicatorColor: capColor,
                    isOrganicLeafShape: true,
                    child: Text(
                      cap['desc'] as String,
                      style: TextStyle(fontSize: 13, height: 1.5, color: subtextColor),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRoleAccessMatrix(
    BuildContext context,
    bool isLightGreen,
    Color textColor,
    Color subtextColor,
  ) {
    final roles = [
      {
        'title': 'STUDENT PORTAL',
        'desc': 'Activity passport, event registration, QR check-in, skill recommendations, and badge trophy showcases.',
        'role': 'Student',
        'icon': Icons.school_rounded,
        'color': OrganicColors.accentSage,
      },
      {
        'title': 'CLUB LEADERSHIP',
        'desc': 'Event creation, roster management, attendance scanning, executive budgets, and activity logs.',
        'role': 'Club Admin',
        'icon': Icons.groups_rounded,
        'color': OrganicColors.accentTerracotta,
      },
      {
        'title': 'FACULTY ADVISORY',
        'desc': 'Proposal approvals, club compliance audit logs, engagement radars, and institutional reports.',
        'role': 'Faculty',
        'icon': Icons.account_balance_rounded,
        'color': OrganicColors.accentClay,
      },
      {
        'title': 'SYSTEM COMMAND',
        'desc': 'Department configuration, zero-trust RBAC controls, global analytics, and security audits.',
        'role': 'Super Admin',
        'icon': Icons.admin_panel_settings_rounded,
        'color': OrganicColors.accentEmeraldMedium,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ROLE-BASED ACCESS CONTROL',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: isLightGreen ? OrganicColors.accentEmeraldMedium : OrganicColors.accentSage,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Tailored Consoles for Every Campus Stakeholder',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final colWidth = constraints.maxWidth > 900
                ? (constraints.maxWidth - 60) / 4
                : (constraints.maxWidth > 600
                    ? (constraints.maxWidth - 20) / 2
                    : constraints.maxWidth);

            return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: roles.map((role) {
                final roleColor = role['color'] as Color;
                return SizedBox(
                  width: colWidth,
                  child: EcoGlassCard(
                    title: role['title'] as String,
                    statusIndicatorColor: roleColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          role['desc'] as String,
                          style: TextStyle(fontSize: 12, height: 1.4, color: subtextColor),
                        ),
                        const SizedBox(height: 18),
                        DewdropButton(
                          label: 'LOGIN AS ${role['role']?.toString().toUpperCase()}',
                          variant: DewdropButtonVariant.translucent,
                          height: 34,
                          width: double.infinity,
                          onPressed: () => context.push('/auth/login'),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLiveStatsBar(
    BuildContext context,
    bool isLightGreen,
    Color textColor,
    Color subtextColor,
  ) {
    final stats = [
      {'val': '1,420+', 'label': 'Active Students', 'icon': Icons.groups_rounded},
      {'val': '48', 'label': 'Recognized Clubs', 'icon': Icons.apartment_rounded},
      {'val': '99.4%', 'label': 'Verified Attendance', 'icon': Icons.qr_code_2_rounded},
      {'val': '2,850', 'label': 'Issued Certificates', 'icon': Icons.workspace_premium_rounded},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: isLightGreen ? Colors.white.withValues(alpha: 0.85) : Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isLightGreen ? OrganicColors.glassBorderLightGreen : OrganicColors.glassBorder,
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: stats.map((stat) {
          return Column(
            children: [
              Icon(
                stat['icon'] as IconData,
                color: isLightGreen ? OrganicColors.accentEmeraldMedium : OrganicColors.accentSage,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                stat['val'] as String,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                stat['label'] as String,
                style: TextStyle(fontSize: 12, color: subtextColor),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFooter(bool isLightGreen, Color textColor, Color subtextColor) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.nature_people_rounded,
                size: 18,
                color: isLightGreen ? OrganicColors.accentEmeraldMedium : OrganicColors.accentSage,
              ),
              const SizedBox(width: 8),
              Text(
                'AI Clubs & Student Activities Tracking Portal • 2026',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: subtextColor),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Protected by Zero-Trust RBAC & Cryptographic Nonce QR Ledger',
            style: TextStyle(fontSize: 11, color: subtextColor.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }
}

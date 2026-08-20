import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/organic_theme.dart';

class OrganicParticle {
  Offset position;
  Offset velocity;
  double radius;
  double opacity;
  Color color;

  OrganicParticle({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.opacity,
    required this.color,
  });
}

class InteractiveParticleCanvas extends StatefulWidget {
  final Offset mousePosition;
  final Widget child;

  const InteractiveParticleCanvas({
    super.key,
    required this.mousePosition,
    required this.child,
  });

  @override
  State<InteractiveParticleCanvas> createState() => _InteractiveParticleCanvasState();
}

class _InteractiveParticleCanvasState extends State<InteractiveParticleCanvas>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<OrganicParticle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _initParticles();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _controller.addListener(_updateParticles);
  }

  void _initParticles() {
    final colors = [
      OrganicColors.accentSage,
      OrganicColors.accentMoss,
      OrganicColors.textSoftMoss,
      OrganicColors.accentTerracotta,
      OrganicColors.accentIvory,
    ];

    for (int i = 0; i < 45; i++) {
      _particles.add(
        OrganicParticle(
          position: Offset(
            _random.nextDouble() * 1400,
            _random.nextDouble() * 900,
          ),
          velocity: Offset(
            (_random.nextDouble() - 0.5) * 0.8,
            (_random.nextDouble() - 0.5) * 0.8,
          ),
          radius: _random.nextDouble() * 3.5 + 1.5,
          opacity: _random.nextDouble() * 0.45 + 0.25,
          color: colors[_random.nextInt(colors.length)],
        ),
      );
    }
  }

  void _updateParticles() {
    final screenSize = MediaQuery.of(context).size;
    final mouse = widget.mousePosition;

    for (var particle in _particles) {
      // Natural organic floating movement
      particle.position += particle.velocity;

      // Wrap boundaries
      if (particle.position.dx < 0) particle.position = Offset(screenSize.width, particle.position.dy);
      if (particle.position.dx > screenSize.width) particle.position = Offset(0, particle.position.dy);
      if (particle.position.dy < 0) particle.position = Offset(particle.position.dx, screenSize.height);
      if (particle.position.dy > screenSize.height) particle.position = Offset(particle.position.dx, 0);

      // Mouse Repulsion Physics Radius (130px)
      if (mouse != Offset.zero) {
        final dist = (particle.position - mouse).distance;
        const repulsionRadius = 130.0;

        if (dist < repulsionRadius && dist > 0) {
          final force = (repulsionRadius - dist) / repulsionRadius;
          final pushDirection = (particle.position - mouse) / dist;
          particle.position += pushDirection * force * 5.0;
        }
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size.infinite,
          painter: _ParticlePainter(
            particles: _particles,
            mousePosition: widget.mousePosition,
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<OrganicParticle> particles;
  final Offset mousePosition;

  _ParticlePainter({
    required this.particles,
    required this.mousePosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()
        ..color = particle.color.withValues(alpha: particle.opacity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, particle.radius * 1.5);

      canvas.drawCircle(particle.position, particle.radius, paint);

      // Draw faint connections between close particles
      for (var other in particles) {
        final distance = (particle.position - other.position).distance;
        if (distance < 90 && distance > 0) {
          final linePaint = Paint()
            ..color = OrganicColors.accentSage.withValues(alpha: (1 - distance / 90) * 0.12)
            ..strokeWidth = 0.8;
          canvas.drawLine(particle.position, other.position, linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}

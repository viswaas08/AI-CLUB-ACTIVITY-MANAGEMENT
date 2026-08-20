import 'package:flutter/material.dart';

class SkeuoAnimations {
  static const Duration micro = Duration(milliseconds: 150);
  static const Duration short = Duration(milliseconds: 250);
  static const Duration medium = Duration(milliseconds: 400);

  static const Curve physicsSpring = Curves.easeOutQuad;
  static const Curve easeOutCubic = Curves.easeOutCubic;
}

class SkeuoEffects {
  static Widget staggeredEntrance({
    required Widget child,
    required int index,
    Duration delayPerItem = const Duration(milliseconds: 50),
  }) {
    return TweenAnimationBuilder<double>(
      duration: SkeuoAnimations.medium + (delayPerItem * index),
      curve: SkeuoAnimations.easeOutCubic,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, childWidget) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 16),
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }

  static Widget cardEntrance({
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      duration: SkeuoAnimations.short,
      curve: Curves.easeOutQuad,
      tween: Tween<double>(begin: 0.96, end: 1.0),
      builder: (context, value, childWidget) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: ((value - 0.96) / 0.04).clamp(0.0, 1.0),
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }

  static Widget animatedCounter({
    required double targetValue,
    required TextStyle style,
    String prefix = '',
    String suffix = '',
    int fractionDigits = 0,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      tween: Tween<double>(begin: 0.0, end: targetValue),
      builder: (context, value, _) {
        final formatted = value.toStringAsFixed(fractionDigits);
        return Text(
          '$prefix$formatted$suffix',
          style: style,
        );
      },
    );
  }
}

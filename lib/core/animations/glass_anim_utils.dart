import 'package:flutter/material.dart';

class GlassAnimations {
  static Widget floatSlideFadeEntrance({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
    double beginOffsetY = 0.15,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Curves.easeOutCirc,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 30 * beginOffsetY),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

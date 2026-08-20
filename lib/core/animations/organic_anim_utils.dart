import 'package:flutter/material.dart';

class OrganicAnimations {
  static Widget waterBreezeDriftEntrance({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
    double beginOffsetY = 0.12,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Curves.easeInOutSine,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 24 * beginOffsetY),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

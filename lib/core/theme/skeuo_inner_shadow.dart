import 'package:flutter/material.dart';

class SkeuoInnerShadow extends StatelessWidget {
  final Widget child;
  final List<BoxShadow> shadows;
  final BorderRadius borderRadius;

  const SkeuoInnerShadow({
    super.key,
    required this.child,
    this.shadows = const [],
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

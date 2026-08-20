import 'package:flutter/material.dart';
import '../organic/dewdrop_button.dart';

enum SkeuoButtonVariant { primary, secondary, amber, crimson }

class SkeuomorphicButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final SkeuoButtonVariant variant;
  final bool isLoading;
  final double? width;
  final double height;
  final double borderRadius;

  const SkeuomorphicButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = SkeuoButtonVariant.primary,
    this.isLoading = false,
    this.width,
    this.height = 46.0,
    this.borderRadius = 24.0,
  });

  DewdropButtonVariant _mapVariant() {
    switch (variant) {
      case SkeuoButtonVariant.primary:
        return DewdropButtonVariant.sage;
      case SkeuoButtonVariant.secondary:
        return DewdropButtonVariant.translucent;
      case SkeuoButtonVariant.amber:
        return DewdropButtonVariant.terracotta;
      case SkeuoButtonVariant.crimson:
        return DewdropButtonVariant.clay;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DewdropButton(
      label: label,
      onPressed: onPressed,
      icon: icon,
      variant: _mapVariant(),
      isLoading: isLoading,
      width: width,
      height: height,
    );
  }
}

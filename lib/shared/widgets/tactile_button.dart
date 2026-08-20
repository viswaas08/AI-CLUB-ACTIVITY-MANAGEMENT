import 'package:flutter/material.dart';
import 'organic/dewdrop_button.dart';

enum TactileButtonType { primary, secondary, amber }

class TactileButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final TactileButtonType type;
  final bool isLoading;
  final double? width;
  final double height;
  final double borderRadius;

  const TactileButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.type = TactileButtonType.primary,
    this.isLoading = false,
    this.width,
    this.height = 46.0,
    this.borderRadius = 24.0,
  });

  DewdropButtonVariant _mapVariant() {
    switch (type) {
      case TactileButtonType.primary:
        return DewdropButtonVariant.sage;
      case TactileButtonType.secondary:
        return DewdropButtonVariant.translucent;
      case TactileButtonType.amber:
        return DewdropButtonVariant.terracotta;
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

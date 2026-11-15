import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

import '../theme/app_colors.dart';

/// Tarjeta con efecto vidrio esmerilado (glassmorphism).
/// BackdropFilter difumina lo que hay detrás (el fondo animado).
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radio;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radio = 20,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radio),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: AppColors.vidrio,
            borderRadius: BorderRadius.circular(radio),
            border: Border.all(color: AppColors.bordeVidrio),
          ),
          child: child,
        ),
      ),
    );
  }
}

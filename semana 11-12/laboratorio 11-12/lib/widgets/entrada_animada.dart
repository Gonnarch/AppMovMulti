import 'package:flutter/cupertino.dart';

/// Hace que un widget aparezca con fade + deslizamiento hacia arriba.
/// Cuanto mayor el índice, más tarda (efecto "cascada" en las listas).
class EntradaAnimada extends StatelessWidget {
  final int indice;
  final Widget child;

  const EntradaAnimada({super.key, required this.indice, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 450 + indice * 90),
      curve: Curves.easeOutCubic,
      builder: (context, valor, hijo) {
        return Opacity(
          opacity: valor,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - valor)),
            child: hijo,
          ),
        );
      },
      child: child,
    );
  }
}

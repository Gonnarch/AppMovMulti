import 'package:flutter/cupertino.dart';

import '../theme/app_colors.dart';
import 'glass_card.dart';

/// Tarjeta con un número que "cuenta" desde 0 hasta su valor.
class TarjetaEstadistica extends StatelessWidget {
  final String etiqueta;
  final double valor;
  final int decimales;
  final IconData icono;
  final Color color;

  const TarjetaEstadistica({
    super.key,
    required this.etiqueta,
    required this.valor,
    required this.icono,
    required this.color,
    this.decimales = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      radio: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, color: color, size: 22),
          const SizedBox(height: 10),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: valor),
            duration: const Duration(milliseconds: 1300),
            curve: Curves.easeOutCubic,
            builder: (context, v, _) => Text(
              v.toStringAsFixed(decimales),
              style: const TextStyle(
                color: AppColors.blanco,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            etiqueta,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.textoSecundario, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

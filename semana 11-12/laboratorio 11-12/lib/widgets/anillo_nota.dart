import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../theme/app_colors.dart';

/// Anillo que se llena según la nota (0 a 20) con animación.
class AnilloNota extends StatelessWidget {
  final double nota;
  final bool aprobado;

  const AnilloNota({super.key, required this.nota, required this.aprobado});

  @override
  Widget build(BuildContext context) {
    final colores = aprobado ? AppColors.coloresExito : AppColors.coloresPeligro;
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: nota / 20),
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        return SizedBox(
          width: 150,
          height: 150,
          child: CustomPaint(
            painter: _AnilloPainter(v, colores),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    (v * 20).toStringAsFixed(1),
                    style: const TextStyle(
                      color: AppColors.blanco,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    aprobado ? 'APROBADO' : 'DESAPROBADO',
                    style: TextStyle(
                      color: colores.last,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AnilloPainter extends CustomPainter {
  final double progreso;
  final List<Color> colores;

  _AnilloPainter(this.progreso, this.colores);

  @override
  void paint(Canvas canvas, Size size) {
    final centro = size.center(Offset.zero);
    final radio = size.shortestSide / 2 - 10;
    final rect = Rect.fromCircle(center: centro, radius: radio);

    canvas.drawCircle(
      centro,
      radio,
      Paint()
        ..color = AppColors.separador
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12,
    );

    canvas.drawArc(
      rect,
      -pi / 2,
      2 * pi * progreso,
      false,
      Paint()
        ..shader = LinearGradient(colors: colores).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _AnilloPainter oldDelegate) =>
      oldDelegate.progreso != progreso;
}

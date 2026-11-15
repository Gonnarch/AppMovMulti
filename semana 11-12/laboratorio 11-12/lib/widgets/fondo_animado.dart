import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../theme/app_colors.dart';

/// Fondo con movimiento continuo: burbujas de luz difuminadas que flotan,
/// partículas que suben y ondas en la parte inferior.
class FondoAnimado extends StatefulWidget {
  const FondoAnimado({super.key});

  @override
  State<FondoAnimado> createState() => _FondoAnimadoState();
}

class _FondoAnimadoState extends State<FondoAnimado>
    with SingleTickerProviderStateMixin {
  // Un ciclo completo dura 20 s y se repite infinitamente
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 20),
  )..repeat();

  // Partículas generadas una sola vez (semilla fija = siempre iguales)
  final List<_Particula> _particulas = List.generate(40, (i) {
    final r = Random(i * 7 + 3);
    return _Particula(
      x: r.nextDouble(),
      y: r.nextDouble(),
      tamano: 1 + r.nextDouble() * 2.5,
      velocidad: 1 + r.nextInt(3),
      opacidad: 0.15 + r.nextDouble() * 0.45,
    );
  });

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // RepaintBoundary: solo se repinta el fondo, no el resto de la pantalla
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            size: Size.infinite,
            painter: _AuroraPainter(_controller.value, _particulas),
          );
        },
      ),
    );
  }
}

class _Burbuja {
  final double x, y, radio, fase;
  final int velocidad;
  final Color color;
  const _Burbuja(this.x, this.y, this.radio, this.velocidad, this.fase, this.color);
}

class _Particula {
  final double x, y, tamano, opacidad;
  final int velocidad;
  const _Particula({
    required this.x,
    required this.y,
    required this.tamano,
    required this.velocidad,
    required this.opacidad,
  });
}

const List<_Burbuja> _burbujas = [
  _Burbuja(0.15, 0.15, 0.55, 1, 0.0, Color(0x998B5CF6)),
  _Burbuja(0.85, 0.30, 0.45, 2, 1.6, Color(0x80F472B6)),
  _Burbuja(0.25, 0.80, 0.60, 1, 3.1, Color(0x7022D3EE)),
  _Burbuja(0.90, 0.90, 0.40, 2, 4.4, Color(0x666366F1)),
];

class _AuroraPainter extends CustomPainter {
  final double progreso; // 0 → 1
  final List<_Particula> particulas;

  _AuroraPainter(this.progreso, this.particulas);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final t = progreso * 2 * pi;

    // 1) Degradado base
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.fondo1, AppColors.fondo2, AppColors.fondo1],
        ).createShader(rect),
    );

    // 2) Burbujas de luz que se mueven en órbitas (seno / coseno)
    for (final b in _burbujas) {
      final centro = Offset(
        size.width * (b.x + 0.22 * sin(t * b.velocidad + b.fase)),
        size.height * (b.y + 0.15 * cos(t * b.velocidad + b.fase)),
      );
      final radio = size.shortestSide * b.radio;
      canvas.drawCircle(
        centro,
        radio,
        Paint()
          ..color = b.color
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, radio * 0.5),
      );
    }

    // 3) Ondas en la parte inferior
    _dibujarOnda(canvas, size, t, altura: 0.86, amplitud: 16, frecuencia: 1.5, velocidad: 1, color: const Color(0x1A22D3EE));
    _dibujarOnda(canvas, size, t, altura: 0.90, amplitud: 12, frecuencia: 2.0, velocidad: 2, color: const Color(0x14F472B6));

    // 4) Partículas que suben y vuelven a aparecer abajo
    for (final p in particulas) {
      final y = ((p.y - progreso * p.velocidad) % 1.0) * size.height;
      final x = (p.x + 0.015 * sin(t * p.velocidad + p.y * 10)) * size.width;
      canvas.drawCircle(
        Offset(x, y),
        p.tamano,
        Paint()..color = Color.fromRGBO(255, 255, 255, p.opacidad),
      );
    }
  }

  void _dibujarOnda(
    Canvas canvas,
    Size size,
    double t, {
    required double altura,
    required double amplitud,
    required double frecuencia,
    required int velocidad,
    required Color color,
  }) {
    final path = Path()..moveTo(0, size.height);
    for (double x = 0; x <= size.width; x += 6) {
      final y = size.height * altura +
          amplitud * sin((x / size.width) * 2 * pi * frecuencia + t * velocidad);
      path.lineTo(x, y);
    }
    path
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _AuroraPainter oldDelegate) =>
      oldDelegate.progreso != progreso;
}

import 'dart:math' as math;
import 'package:flutter/material.dart';

class AcademicBackground extends StatefulWidget {
  const AcademicBackground({super.key, this.immersive = false});
  final bool immersive;
  @override
  State<AcademicBackground> createState() => _AcademicBackgroundState();
}

class _AcademicBackgroundState extends State<AcademicBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 18),
  )..repeat();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduced = MediaQuery.disableAnimationsOf(context);
    return IgnorePointer(
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) => CustomPaint(
            painter: AcademicPainter(
              reduced ? 0 : controller.value,
              widget.immersive,
            ),
          ),
        ),
      ),
    );
  }
}

class AcademicPainter extends CustomPainter {
  AcademicPainter(this.time, this.immersive);
  final double time;
  final bool immersive;
  @override
  void paint(Canvas canvas, Size size) {
    final phase = time * math.pi * 2;
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: immersive
              ? const [Color(0xFF120D2F), Color(0xFF29205D), Color(0xFF110F29)]
              : const [Color(0xFFF1EAFF), Color(0xFFF9F7FF), Color(0xFFE7E9FF)],
        ).createShader(Offset.zero & size),
    );
    // Las luces se desplazan continuamente; no es una imagen de fondo.
    for (var i = 0; i < 3; i++) {
      final center = Offset(
        size.width * (.5 + .48 * math.sin(phase + i * 2.1)),
        size.height * (.5 + .42 * math.cos(phase + i * 1.7)),
      );
      final radius = size.longestSide * .55;
      final color = [
        const Color(0xFF9560FF),
        const Color(0xFF44C9D2),
        const Color(0xFFF087D0),
      ][i];
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [
              color.withValues(alpha: immersive ? .34 : .16),
              color.withValues(alpha: 0),
            ],
          ).createShader(Rect.fromCircle(center: center, radius: radius)),
      );
    }
    final orbitCenter = Offset(size.width * .5, size.height * .31);
    for (var i = 0; i < 3; i++) {
      canvas.save();
      canvas.translate(orbitCenter.dx, orbitCenter.dy);
      canvas.rotate(phase * (i.isEven ? 1 : -1) + i);
      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: size.width * (.9 + i * .22),
        height: size.height * .30,
      );
      canvas.drawOval(
        rect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = const Color(
            0xFFBFA9FF,
          ).withValues(alpha: immersive ? .15 : .12),
      );
      canvas.drawCircle(
        Offset(rect.right, 0),
        5,
        Paint()
          ..color = const Color(
            0xFF9ADFDB,
          ).withValues(alpha: immersive ? .8 : .35),
      );
      canvas.restore();
    }
    for (var i = 0; i < 22; i++) {
      final x = size.width * ((i * .237) % 1) + math.cos(phase + i) * 24;
      final y = size.height * ((i * .173 + time) % 1);
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(math.sin(phase + i) * .35);
      final opacity = immersive ? .20 + .12 * math.sin(phase + i).abs() : .11;
      if (i % 4 == 0) {
        final pen = Paint()
          ..color = const Color(0xFFB9AAFF).withValues(alpha: opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        // Libro abierto flotante.
        canvas.drawPath(
          Path()
            ..moveTo(0, -12)
            ..quadraticBezierTo(-12, -20, -25, -12)
            ..lineTo(-25, 17)
            ..quadraticBezierTo(-12, 10, 0, 18)
            ..quadraticBezierTo(12, 10, 25, 17)
            ..lineTo(25, -12)
            ..quadraticBezierTo(12, -20, 0, -12)
            ..lineTo(0, 18),
          pen,
        );
      } else {
        final text = TextPainter(
          text: TextSpan(
            text: ['✦', 'π', '+', 'Aa', '∑', '○'][i % 6],
            style: TextStyle(
              color: const Color(0xFFB9AAFF).withValues(alpha: opacity),
              fontSize: 24 + (i % 3) * 10,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        text.paint(canvas, Offset.zero);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(AcademicPainter oldDelegate) =>
      oldDelegate.time != time || oldDelegate.immersive != immersive;
}

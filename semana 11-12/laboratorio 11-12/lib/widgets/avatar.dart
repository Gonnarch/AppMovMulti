import 'package:flutter/cupertino.dart';

import '../theme/app_colors.dart';

/// Círculo con degradado y las iniciales del alumno.
class AvatarIniciales extends StatelessWidget {
  final String texto;
  final double tamano;

  const AvatarIniciales({super.key, required this.texto, this.tamano = 54});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamano,
      height: tamano,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.gradienteSecundario,
        boxShadow: [BoxShadow(color: Color(0x5522D3EE), blurRadius: 16)],
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: AppColors.blanco,
          fontWeight: FontWeight.w800,
          fontSize: tamano * 0.36,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}

/// Avatar con un anillo de colores que gira sin parar.
class AvatarGiratorio extends StatefulWidget {
  final String texto;
  final double tamano;

  const AvatarGiratorio({super.key, required this.texto, this.tamano = 116});

  @override
  State<AvatarGiratorio> createState() => _AvatarGiratorioState();
}

class _AvatarGiratorioState extends State<AvatarGiratorio>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anillo = widget.tamano + 12;
    return SizedBox(
      width: anillo,
      height: anillo,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotationTransition(
            turns: _controller,
            child: Container(
              width: anillo,
              height: anillo,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [AppColors.cian, AppColors.violeta, AppColors.rosa, AppColors.cian],
                ),
              ),
            ),
          ),
          Container(
            width: widget.tamano + 4,
            height: widget.tamano + 4,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.fondo1),
          ),
          AvatarIniciales(texto: widget.texto, tamano: widget.tamano),
        ],
      ),
    );
  }
}

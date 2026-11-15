import 'package:flutter/cupertino.dart';

import '../theme/app_colors.dart';

/// Estructura común de todas las pantallas:
/// fondo transparente (se ve el fondo animado) + barra translúcida.
class PantallaBase extends StatelessWidget {
  final String? titulo;
  final Widget child;
  final Widget? trailing;
  final bool mostrarBarra;

  const PantallaBase({
    super.key,
    required this.child,
    this.titulo,
    this.trailing,
    this.mostrarBarra = true,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.transparente,
      navigationBar: mostrarBarra
          ? CupertinoNavigationBar(
              backgroundColor: AppColors.barra,
              border: const Border(
                bottom: BorderSide(color: AppColors.separador, width: 0.5),
              ),
              middle: Text(titulo ?? ''),
              trailing: trailing,
            )
          : null,
      // La barra es translúcida, por eso SafeArea evita que el contenido quede debajo
      child: SafeArea(child: child),
    );
  }
}

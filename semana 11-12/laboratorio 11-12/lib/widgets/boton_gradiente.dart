import 'package:flutter/cupertino.dart';

import '../theme/app_colors.dart';

class BotonGradiente extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final bool cargando;
  final IconData? icono;
  final Gradient gradiente;

  const BotonGradiente({
    super.key,
    required this.texto,
    required this.onPressed,
    this.cargando = false,
    this.icono,
    this.gradiente = AppColors.gradientePrincipal,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: cargando ? null : onPressed,
      child: Container(
        height: 54,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: gradiente,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x668B5CF6), blurRadius: 22, offset: Offset(0, 8)),
          ],
        ),
        child: cargando
            ? const CupertinoActivityIndicator(color: AppColors.blanco)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icono != null) ...[
                    Icon(icono, color: AppColors.blanco, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    texto,
                    style: const TextStyle(
                      color: AppColors.blanco,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

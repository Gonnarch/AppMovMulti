import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

/// CupertinoTextField con estilo vidrio e ícono a la izquierda.
class CampoVidrio extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final IconData icono;
  final bool oculto;
  final Widget? sufijo;
  final TextInputType? teclado;
  final TextInputAction? accion;
  final List<TextInputFormatter>? formatos;

  const CampoVidrio({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.icono,
    this.oculto = false,
    this.sufijo,
    this.teclado,
    this.accion,
    this.formatos,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      obscureText: oculto,
      keyboardType: teclado,
      textInputAction: accion,
      inputFormatters: formatos,
      cursorColor: AppColors.cian,
      style: const TextStyle(color: AppColors.blanco, fontSize: 16),
      placeholderStyle: const TextStyle(color: AppColors.textoTenue, fontSize: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Icon(icono, color: AppColors.cian, size: 20),
      ),
      suffix: sufijo == null
          ? null
          : Padding(padding: const EdgeInsets.only(right: 12), child: sufijo),
      decoration: BoxDecoration(
        color: AppColors.vidrio,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.bordeVidrio),
      ),
    );
  }
}

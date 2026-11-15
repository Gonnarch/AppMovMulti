import 'package:flutter/cupertino.dart';

/// Paleta "Aurora": fondo oscuro con acentos neón.
class AppColors {
  static const Color fondo1 = Color(0xFF0B0820);
  static const Color fondo2 = Color(0xFF1A0F3D);
  static const Color panel = Color(0xFF17112E);

  static const Color cian = Color(0xFF22D3EE);
  static const Color violeta = Color(0xFF8B5CF6);
  static const Color rosa = Color(0xFFF472B6);
  static const Color verde = Color(0xFF34D399);
  static const Color rojo = Color(0xFFF87171);
  static const Color ambar = Color(0xFFFBBF24);

  static const Color verdeSuave = Color(0x3334D399);
  static const Color rojoSuave = Color(0x33F87171);

  static const Color blanco = Color(0xFFFFFFFF);
  static const Color textoSecundario = Color(0xB3FFFFFF);
  static const Color textoTenue = Color(0x80FFFFFF);

  // Efecto vidrio (glassmorphism)
  static const Color vidrio = Color(0x1AFFFFFF);
  static const Color bordeVidrio = Color(0x33FFFFFF);
  static const Color separador = Color(0x1FFFFFFF);
  static const Color barra = Color(0x400B0820);
  static const Color transparente = Color(0x00000000);

  static const LinearGradient gradientePrincipal = LinearGradient(
    colors: [violeta, rosa],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradienteSecundario = LinearGradient(
    colors: [cian, violeta],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const List<Color> coloresExito = [cian, verde];
  static const List<Color> coloresPeligro = [ambar, rojo];
}

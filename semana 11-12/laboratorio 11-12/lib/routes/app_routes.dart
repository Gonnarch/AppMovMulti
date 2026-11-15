import 'package:flutter/cupertino.dart';

import '../pages/alumnos_page.dart';
import '../pages/detalle_alumno_page.dart';
import '../pages/login_page.dart';
import '../pages/menu_page.dart';
import '../pages/perfil_page.dart';
import '../pages/registrar_alumno_page.dart';

class AppRoutes {
  static const String login = '/';
  static const String menu = '/menu';
  static const String registrar = '/registrar';
  static const String alumnos = '/alumnos';
  static const String detalle = '/detalle';
  static const String perfil = '/perfil';

  // Mapa: nombre de la ruta -> pantalla
  static final Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginPage(),
    menu: (_) => const MenuPage(),
    registrar: (_) => const RegistrarAlumnoPage(),
    alumnos: (_) => const AlumnosPage(),
    detalle: (_) => const DetalleAlumnoPage(),
    perfil: (_) => const PerfilPage(),
  };

  /// Construye cada ruta con una transición propia:
  /// la pantalla nueva entra con fade + deslizamiento hacia arriba
  /// y la anterior se desvanece y se encoge un poco.
  static Route<dynamic> generarRuta(RouteSettings settings) {
    final builder = routes[settings.name] ?? routes[login]!;

    return PageRouteBuilder<dynamic>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final entrada = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        final salida = CurvedAnimation(
          parent: secondaryAnimation,
          curve: Curves.easeOutCubic,
        );

        return FadeTransition(
          opacity: Tween<double>(begin: 1, end: 0).animate(salida),
          child: ScaleTransition(
            scale: Tween<double>(begin: 1, end: 0.94).animate(salida),
            child: FadeTransition(
              opacity: entrada,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.08),
                  end: Offset.zero,
                ).animate(entrada),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

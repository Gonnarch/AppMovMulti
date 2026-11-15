import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'providers/alumno_provider.dart';
import 'routes/app_routes.dart';
import 'theme/app_colors.dart';
import 'widgets/fondo_animado.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlumnoProvider()),
      ],
      // CupertinoApp: toda la app usa el estilo iOS
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'Aurora · Gestión de Alumnos',

        // Tema global oscuro: lo heredan todas las pantallas
        theme: const CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: AppColors.cian,
          barBackgroundColor: AppColors.barra,
          scaffoldBackgroundColor: AppColors.fondo1,
          textTheme: CupertinoTextThemeData(
            primaryColor: AppColors.cian,
            navTitleTextStyle: TextStyle(
              color: AppColors.blanco,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),

        // El fondo animado se dibuja UNA sola vez detrás del Navigator,
        // así sigue moviéndose sin cortes al cambiar de pantalla.
        builder: (context, child) {
          return Stack(
            children: [
              const Positioned.fill(child: FondoAnimado()),
              if (child != null) child,
            ],
          );
        },

        // Rutas con nombre + transición personalizada
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.generarRuta,
      ),
    );
  }
}

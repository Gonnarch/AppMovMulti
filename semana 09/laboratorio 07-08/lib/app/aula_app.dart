import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../data/aula_store.dart';
import '../screens/aula_home.dart';
import 'app_routes.dart';

class AulaApp extends StatefulWidget {
  const AulaApp({super.key});
  @override
  State<AulaApp> createState() => _AulaAppState();
}

class _AulaAppState extends State<AulaApp> {
  final store = AulaStore();
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Aula violeta · Sección A',
    theme: AppTheme.light,
    initialRoute: AppRoutes.login,
    // Un Map relaciona cada ruta con la pantalla que debe construir.
    routes: <String, WidgetBuilder>{
      AppRoutes.login: (_) => AulaHome(store: store),
      for (var index = 0; index < AppRoutes.sections.length; index++)
        AppRoutes.sections[index]: (_) =>
            AulaHome(store: store, initialPage: index, authenticated: true),
    },
  );
}

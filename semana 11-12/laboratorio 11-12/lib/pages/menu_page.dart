import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/alumno_provider.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../utils/dialogos.dart';
import '../widgets/entrada_animada.dart';
import '../widgets/tarjeta_estadistica.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  Future<void> _cerrarSesion(BuildContext context) async {
    final confirmado = await confirmar(
      context,
      titulo: 'Cerrar sesión',
      mensaje: '¿Seguro que deseas salir de la aplicación?',
      textoAccion: 'Salir',
    );
    if (!confirmado || !context.mounted) return;
    // Abre el login y borra todo el historial de pantallas
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AlumnoProvider>();
    final primerNombre = (provider.perfil['nombre'] ?? '').split(' ').first;

    // Opciones del menú definidas como lista de mapas
    final opciones = <Map<String, dynamic>>[
      {
        'titulo': 'Registrar alumno',
        'subtitulo': 'Agrega un nuevo estudiante',
        'icono': CupertinoIcons.person_add_solid,
        'color': AppColors.violeta,
        'ruta': AppRoutes.registrar,
      },
      {
        'titulo': 'Listar alumnos',
        'subtitulo': 'Busca, filtra y gestiona',
        'icono': CupertinoIcons.list_bullet,
        'color': AppColors.cian,
        'ruta': AppRoutes.alumnos,
        'info': '${provider.total}',
      },
      {
        'titulo': 'Mi perfil',
        'subtitulo': 'Revisa y edita tus datos',
        'icono': CupertinoIcons.person_crop_circle_fill,
        'color': AppColors.rosa,
        'ruta': AppRoutes.perfil,
      },
    ];

    return CupertinoPageScaffold(
      backgroundColor: AppColors.transparente,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: AppColors.barra,
        border: Border(bottom: BorderSide(color: AppColors.separador, width: 0.5)),
        automaticallyImplyLeading: false,
        middle: Text('Menú'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 18, bottom: 32),
          children: [
            // Saludo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: EntradaAnimada(
                indice: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hola, $primerNombre 👋',
                      style: const TextStyle(color: AppColors.blanco, fontSize: 28, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Este es el resumen de tu salón',
                      style: TextStyle(color: AppColors.textoSecundario, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Estadísticas con contador animado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: EntradaAnimada(
                indice: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: TarjetaEstadistica(
                        etiqueta: 'Alumnos',
                        valor: provider.total.toDouble(),
                        icono: CupertinoIcons.person_2_fill,
                        color: AppColors.cian,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TarjetaEstadistica(
                        etiqueta: 'Aprobados',
                        valor: provider.aprobados.toDouble(),
                        icono: CupertinoIcons.checkmark_seal_fill,
                        color: AppColors.verde,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TarjetaEstadistica(
                        etiqueta: 'Promedio',
                        valor: provider.promedio,
                        decimales: 1,
                        icono: CupertinoIcons.chart_bar_fill,
                        color: AppColors.ambar,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Lista agrupada estilo Ajustes de iPhone
            EntradaAnimada(
              indice: 2,
              child: CupertinoListSection.insetGrouped(
                backgroundColor: AppColors.transparente,
                separatorColor: AppColors.separador,
                decoration: BoxDecoration(
                  color: AppColors.vidrio,
                  borderRadius: BorderRadius.circular(18),
                ),
                header: const Text(
                  'OPCIONES',
                  style: TextStyle(color: AppColors.textoSecundario, fontSize: 13, letterSpacing: 1.2),
                ),
                children: [
                  ...opciones.map((opcion) {
                    return CupertinoListTile(
                      leadingSize: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: _IconoCuadrado(
                        icono: opcion['icono'] as IconData,
                        color: opcion['color'] as Color,
                      ),
                      title: Text(
                        opcion['titulo'] as String,
                        style: const TextStyle(color: AppColors.blanco, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        opcion['subtitulo'] as String,
                        style: const TextStyle(color: AppColors.textoSecundario, fontSize: 13),
                      ),
                      additionalInfo: opcion['info'] == null
                          ? null
                          : Text(
                              opcion['info'] as String,
                              style: const TextStyle(color: AppColors.cian, fontWeight: FontWeight.w700),
                            ),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () => Navigator.pushNamed(context, opcion['ruta'] as String),
                    );
                  }),
                ],
              ),
            ),

            EntradaAnimada(
              indice: 3,
              child: CupertinoListSection.insetGrouped(
                backgroundColor: AppColors.transparente,
                decoration: BoxDecoration(
                  color: AppColors.rojoSuave,
                  borderRadius: BorderRadius.circular(18),
                ),
                children: [
                  CupertinoListTile(
                    leadingSize: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    leading: const _IconoCuadrado(
                      icono: CupertinoIcons.square_arrow_right,
                      color: AppColors.rojo,
                    ),
                    title: const Text(
                      'Cerrar sesión',
                      style: TextStyle(color: AppColors.rojo, fontWeight: FontWeight.w600),
                    ),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () => _cerrarSesion(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconoCuadrado extends StatelessWidget {
  final IconData icono;
  final Color color;

  const _IconoCuadrado({required this.icono, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [BoxShadow(color: color, blurRadius: 10, spreadRadius: -4)],
      ),
      child: Icon(icono, color: AppColors.blanco, size: 20),
    );
  }
}

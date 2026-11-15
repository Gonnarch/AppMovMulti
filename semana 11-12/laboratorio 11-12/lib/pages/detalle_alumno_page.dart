import 'package:flutter/cupertino.dart';

import '../models/alumno.dart';
import '../theme/app_colors.dart';
import '../widgets/anillo_nota.dart';
import '../widgets/avatar.dart';
import '../widgets/entrada_animada.dart';
import '../widgets/pantalla_base.dart';

class DetalleAlumnoPage extends StatelessWidget {
  const DetalleAlumnoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // El alumno llega como argumento de la ruta
    final alumno = ModalRoute.of(context)!.settings.arguments as Alumno;

    final filas = <Map<String, dynamic>>[
      {'icono': CupertinoIcons.person_fill, 'etiqueta': 'Nombres', 'valor': alumno.nombre},
      {'icono': CupertinoIcons.person_2_fill, 'etiqueta': 'Apellidos', 'valor': alumno.apellido},
      {'icono': CupertinoIcons.calendar, 'etiqueta': 'Edad', 'valor': '${alumno.edad} años'},
      {'icono': CupertinoIcons.briefcase_fill, 'etiqueta': 'Carrera', 'valor': alumno.carrera},
      {'icono': CupertinoIcons.star_fill, 'etiqueta': 'Nota final', 'valor': '${alumno.notaTexto} / 20'},
    ];

    return PantallaBase(
      titulo: 'Detalle',
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          Center(
            child: Hero(
              tag: 'avatar-${alumno.id}',
              child: AvatarIniciales(texto: alumno.iniciales, tamano: 110),
            ),
          ),
          const SizedBox(height: 16),
          EntradaAnimada(
            indice: 0,
            child: Column(
              children: [
                Text(
                  alumno.nombreCompleto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.blanco, fontSize: 24, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  alumno.carrera,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textoSecundario, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(child: AnilloNota(nota: alumno.nota, aprobado: alumno.aprobado)),
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
                'INFORMACIÓN',
                style: TextStyle(color: AppColors.textoSecundario, fontSize: 13, letterSpacing: 1.2),
              ),
              children: filas.map((fila) {
                return CupertinoListTile(
                  leading: Icon(fila['icono'] as IconData, color: AppColors.cian),
                  title: Text(
                    fila['valor'] as String,
                    style: const TextStyle(color: AppColors.blanco, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    fila['etiqueta'] as String,
                    style: const TextStyle(color: AppColors.textoSecundario, fontSize: 12),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

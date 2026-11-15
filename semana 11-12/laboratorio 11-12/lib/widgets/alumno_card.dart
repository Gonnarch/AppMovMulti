import 'package:flutter/cupertino.dart';

import '../models/alumno.dart';
import '../theme/app_colors.dart';
import 'avatar.dart';
import 'glass_card.dart';

/// Tarjeta reutilizable del alumno (Card hecha con GlassCard).
class AlumnoCard extends StatelessWidget {
  final Alumno alumno;
  final VoidCallback? onTap;
  final VoidCallback? onOpciones;
  final bool usarHero;

  const AlumnoCard({
    super.key,
    required this.alumno,
    this.onTap,
    this.onOpciones,
    this.usarHero = true,
  });

  @override
  Widget build(BuildContext context) {
    final aprobado = alumno.aprobado;
    final avatar = AvatarIniciales(texto: alumno.iniciales, tamano: 54);

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.fromLTRB(14, 14, 6, 14),
        child: Row(
          children: [
            // Hero: el avatar "vuela" a la pantalla de detalle
            usarHero ? Hero(tag: 'avatar-${alumno.id}', child: avatar) : avatar,
            const SizedBox(width: 14),

            // Datos del alumno
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alumno.nombreCompleto.isEmpty ? 'Nombre del alumno' : alumno.nombreCompleto,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.blanco,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${alumno.carrera} · ${alumno.edad} años',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textoSecundario, fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  _BarraNota(nota: alumno.nota, aprobado: aprobado),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Nota y estado
            Column(
              children: [
                Text(
                  alumno.notaTexto,
                  style: TextStyle(
                    color: aprobado ? AppColors.verde : AppColors.rojo,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: aprobado ? AppColors.verdeSuave : AppColors.rojoSuave,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    aprobado ? 'Aprobado' : 'Desaprob.',
                    style: TextStyle(
                      color: aprobado ? AppColors.verde : AppColors.rojo,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            // Botón de opciones
            if (onOpciones != null)
              GestureDetector(
                onTap: onOpciones,
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Icon(CupertinoIcons.ellipsis_vertical, color: AppColors.textoSecundario, size: 20),
                ),
              )
            else
              const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

/// Barra de progreso de la nota (0 a 20) que se llena con animación.
class _BarraNota extends StatelessWidget {
  final double nota;
  final bool aprobado;

  const _BarraNota({required this.nota, required this.aprobado});

  @override
  Widget build(BuildContext context) {
    final fraccion = (nota / 20).clamp(0.0, 1.0).toDouble();
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: fraccion),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 6,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: AppColors.separador),
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: v,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: aprobado ? AppColors.coloresExito : AppColors.coloresPeligro,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

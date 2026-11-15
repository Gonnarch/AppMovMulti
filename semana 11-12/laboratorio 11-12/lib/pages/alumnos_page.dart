import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/alumno.dart';
import '../providers/alumno_provider.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../utils/dialogos.dart';
import '../widgets/alumno_card.dart';
import '../widgets/entrada_animada.dart';
import '../widgets/pantalla_base.dart';

class AlumnosPage extends StatefulWidget {
  const AlumnosPage({super.key});

  @override
  State<AlumnosPage> createState() => _AlumnosPageState();
}

class _AlumnosPageState extends State<AlumnosPage> {
  String buscar = '';
  int filtro = 0; // 0 = Todos, 1 = Aprobados, 2 = Desaprobados

  Future<void> _eliminar(Alumno alumno) async {
    final confirmado = await confirmar(
      context,
      titulo: 'Eliminar alumno',
      mensaje: '¿Deseas eliminar a ${alumno.nombreCompleto}?',
      textoAccion: 'Eliminar',
    );
    if (!confirmado || !mounted) return;
    context.read<AlumnoProvider>().eliminar(alumno.id);
  }

  // Menú inferior de opciones (reemplaza al PopupMenu de Material)
  void _mostrarOpciones(Alumno alumno) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (popupContext) => CupertinoActionSheet(
        title: Text(alumno.nombreCompleto),
        message: Text('${alumno.carrera} · Nota ${alumno.notaTexto}'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(popupContext);
              Navigator.pushNamed(context, AppRoutes.detalle, arguments: alumno);
            },
            child: const Text('Ver detalle'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(popupContext);
              _eliminar(alumno);
            },
            child: const Text('Eliminar'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(popupContext),
          child: const Text('Cancelar'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AlumnoProvider>();
    final texto = buscar.toLowerCase();

    // Filtro con where: búsqueda + segmento seleccionado
    final lista = provider.alumnos.where((a) {
      final coincide = a.nombreCompleto.toLowerCase().contains(texto) ||
          a.carrera.toLowerCase().contains(texto);
      final pasaFiltro =
          filtro == 0 || (filtro == 1 && a.aprobado) || (filtro == 2 && !a.aprobado);
      return coincide && pasaFiltro;
    }).toList();

    return PantallaBase(
      titulo: 'Alumnos',
      trailing: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRoutes.registrar),
        child: const Icon(CupertinoIcons.add_circled_solid, color: AppColors.cian, size: 28),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: CupertinoSearchTextField(
              placeholder: 'Buscar por nombre o carrera...',
              backgroundColor: AppColors.vidrio,
              itemColor: AppColors.textoSecundario,
              style: const TextStyle(color: AppColors.blanco),
              placeholderStyle: const TextStyle(color: AppColors.textoTenue),
              onChanged: (valor) {
                setState(() {
                  buscar = valor;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: CupertinoSlidingSegmentedControl<int>(
                groupValue: filtro,
                backgroundColor: AppColors.vidrio,
                thumbColor: AppColors.violeta,
                children: const {
                  0: _Segmento('Todos'),
                  1: _Segmento('Aprobados'),
                  2: _Segmento('Desaprobados'),
                },
                onValueChanged: (valor) => setState(() => filtro = valor ?? 0),
              ),
            ),
          ),
          Expanded(
            child: lista.isEmpty
                ? const _ListaVacia()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      final alumno = lista[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: EntradaAnimada(
                          // La key cambia con el filtro → la animación se repite al filtrar
                          key: ValueKey('${alumno.id}-$filtro'),
                          indice: index,
                          // Deslizar a la izquierda para eliminar
                          child: Dismissible(
                            key: ValueKey(alumno.id),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (_) => confirmar(
                              context,
                              titulo: 'Eliminar alumno',
                              mensaje: '¿Deseas eliminar a ${alumno.nombreCompleto}?',
                              textoAccion: 'Eliminar',
                            ),
                            onDismissed: (_) =>
                                context.read<AlumnoProvider>().eliminar(alumno.id),
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 24),
                              decoration: BoxDecoration(
                                color: AppColors.rojoSuave,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(CupertinoIcons.trash, color: AppColors.rojo),
                            ),
                            child: AlumnoCard(
                              alumno: alumno,
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.detalle,
                                arguments: alumno,
                              ),
                              onOpciones: () => _mostrarOpciones(alumno),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _Segmento extends StatelessWidget {
  final String texto;
  const _Segmento(this.texto);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        texto,
        style: const TextStyle(color: AppColors.blanco, fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ListaVacia extends StatelessWidget {
  const _ListaVacia();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: EntradaAnimada(
        indice: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.search, color: AppColors.textoTenue, size: 54),
            SizedBox(height: 12),
            Text(
              'No se encontraron alumnos',
              style: TextStyle(color: AppColors.textoSecundario, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

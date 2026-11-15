import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/alumno.dart';
import '../providers/alumno_provider.dart';
import '../theme/app_colors.dart';
import '../utils/dialogos.dart';
import '../widgets/alumno_card.dart';
import '../widgets/boton_gradiente.dart';
import '../widgets/campo_vidrio.dart';
import '../widgets/entrada_animada.dart';
import '../widgets/glass_card.dart';
import '../widgets/pantalla_base.dart';

class RegistrarAlumnoPage extends StatefulWidget {
  const RegistrarAlumnoPage({super.key});

  @override
  State<RegistrarAlumnoPage> createState() => _RegistrarAlumnoPageState();
}

class _RegistrarAlumnoPageState extends State<RegistrarAlumnoPage> {
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final edadController = TextEditingController();
  final notaController = TextEditingController();
  int carreraIndice = 0;
  bool guardando = false;

  @override
  void initState() {
    super.initState();
    // Cada vez que se escribe, se redibuja la vista previa
    for (final c in [nombreController, apellidoController, edadController, notaController]) {
      c.addListener(_actualizarVista);
    }
  }

  void _actualizarVista() => setState(() {});

  double? get _notaIngresada =>
      double.tryParse(notaController.text.trim().replaceAll(',', '.'));

  // Ruedita de selección de carrera
  void _seleccionarCarrera() {
    int indice = carreraIndice;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (popupContext) => Container(
        height: 300,
        decoration: const BoxDecoration(
          color: AppColors.panel,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    onPressed: () => Navigator.pop(popupContext),
                    child: const Text('Cancelar', style: TextStyle(color: AppColors.textoSecundario)),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      setState(() => carreraIndice = indice);
                      Navigator.pop(popupContext);
                    },
                    child: const Text(
                      'Listo',
                      style: TextStyle(color: AppColors.cian, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(initialItem: indice),
                  onSelectedItemChanged: (nuevo) => indice = nuevo,
                  children: AlumnoProvider.carreras
                      .map((c) => Center(
                            child: Text(c, style: const TextStyle(color: AppColors.blanco, fontSize: 17)),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _guardar() async {
    final nombre = nombreController.text.trim();
    final apellido = apellidoController.text.trim();
    final edad = int.tryParse(edadController.text.trim());
    final nota = _notaIngresada;

    if (nombre.isEmpty || apellido.isEmpty) {
      await mostrarMensaje(context, titulo: 'Campos vacíos', mensaje: 'Ingresa el nombre y el apellido.');
      return;
    }
    if (edad == null || edad < 15 || edad > 80) {
      await mostrarMensaje(context, titulo: 'Edad inválida', mensaje: 'La edad debe estar entre 15 y 80 años.');
      return;
    }
    if (nota == null || nota < 0 || nota > 20) {
      await mostrarMensaje(context, titulo: 'Nota inválida', mensaje: 'La nota debe estar entre 0 y 20.');
      return;
    }

    setState(() => guardando = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    context.read<AlumnoProvider>().agregar(
          nombre: nombre,
          apellido: apellido,
          edad: edad,
          nota: nota,
          carrera: AlumnoProvider.carreras[carreraIndice],
        );
    setState(() => guardando = false);

    await mostrarMensaje(context, titulo: '¡Alumno registrado!', mensaje: '$nombre $apellido se agregó correctamente.');
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    edadController.dispose();
    notaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Alumno temporal para la vista previa en vivo
    final vistaPrevia = Alumno(
      id: -1,
      nombre: nombreController.text.trim(),
      apellido: apellidoController.text.trim(),
      edad: int.tryParse(edadController.text.trim()) ?? 0,
      nota: (_notaIngresada ?? 0).clamp(0, 20).toDouble(),
      carrera: AlumnoProvider.carreras[carreraIndice],
    );

    return PantallaBase(
      titulo: 'Registrar alumno',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          const EntradaAnimada(
            indice: 0,
            child: Text(
              'VISTA PREVIA',
              style: TextStyle(color: AppColors.textoSecundario, fontSize: 13, letterSpacing: 1.2),
            ),
          ),
          const SizedBox(height: 8),
          EntradaAnimada(
            indice: 0,
            child: AlumnoCard(alumno: vistaPrevia, usarHero: false),
          ),
          const SizedBox(height: 20),
          EntradaAnimada(
            indice: 1,
            child: GlassCard(
              radio: 24,
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  CampoVidrio(
                    controller: nombreController,
                    placeholder: 'Nombres',
                    icono: CupertinoIcons.person,
                    accion: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  CampoVidrio(
                    controller: apellidoController,
                    placeholder: 'Apellidos',
                    icono: CupertinoIcons.person_2,
                    accion: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  CampoVidrio(
                    controller: edadController,
                    placeholder: 'Edad',
                    icono: CupertinoIcons.calendar,
                    teclado: TextInputType.number,
                    accion: TextInputAction.next,
                    formatos: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 12),
                  CampoVidrio(
                    controller: notaController,
                    placeholder: 'Nota (0 - 20)',
                    icono: CupertinoIcons.rosette,
                    teclado: const TextInputType.numberWithOptions(decimal: true),
                    accion: TextInputAction.done,
                  ),
                  const SizedBox(height: 12),

                  // Selector de carrera (abre el CupertinoPicker)
                  GestureDetector(
                    onTap: _seleccionarCarrera,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.vidrio,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.bordeVidrio),
                      ),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.briefcase, color: AppColors.cian, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              AlumnoProvider.carreras[carreraIndice],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: AppColors.blanco, fontSize: 16),
                            ),
                          ),
                          const Icon(CupertinoIcons.chevron_down, color: AppColors.textoSecundario, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          EntradaAnimada(
            indice: 2,
            child: BotonGradiente(
              texto: 'GUARDAR ALUMNO',
              icono: CupertinoIcons.checkmark_alt_circle_fill,
              cargando: guardando,
              onPressed: _guardar,
            ),
          ),
        ],
      ),
    );
  }
}

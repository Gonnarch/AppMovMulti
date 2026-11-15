import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/alumno_provider.dart';
import '../theme/app_colors.dart';
import '../utils/dialogos.dart';
import '../widgets/avatar.dart';
import '../widgets/boton_gradiente.dart';
import '../widgets/campo_vidrio.dart';
import '../widgets/entrada_animada.dart';
import '../widgets/pantalla_base.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  bool notificaciones = true;
  bool recordatorios = false;

  String _iniciales(String nombre) {
    final partes = nombre.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (partes.isEmpty) return '?';
    final a = partes.first[0];
    final b = partes.length > 1 ? partes[1][0] : '';
    return (a + b).toUpperCase();
  }

  Future<void> _editarPerfil(Map<String, String> perfil) async {
    final guardado = await showCupertinoModalPopup<bool>(
      context: context,
      builder: (_) => _PanelEditarPerfil(perfil: perfil),
    );
    if (guardado == true && mounted) {
      await mostrarMensaje(context, titulo: 'Perfil actualizado', mensaje: 'Tus datos se guardaron correctamente.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final perfil = context.watch<AlumnoProvider>().perfil;

    // Filas del perfil definidas como lista de mapas
    final filas = <Map<String, dynamic>>[
      {'icono': CupertinoIcons.person_fill, 'etiqueta': 'Nombre', 'clave': 'nombre'},
      {'icono': CupertinoIcons.envelope_fill, 'etiqueta': 'Email', 'clave': 'email'},
      {'icono': CupertinoIcons.phone_fill, 'etiqueta': 'Teléfono', 'clave': 'telefono'},
      {'icono': CupertinoIcons.briefcase_fill, 'etiqueta': 'Rol', 'clave': 'rol'},
    ];

    return PantallaBase(
      titulo: 'Perfil',
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          // Avatar con anillo giratorio + botón de editar encima (Stack)
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AvatarGiratorio(texto: _iniciales(perfil['nombre'] ?? '')),
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: GestureDetector(
                    onTap: () => _editarPerfil(perfil),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.gradientePrincipal,
                        border: Border.all(color: AppColors.fondo1, width: 3),
                      ),
                      child: const Icon(CupertinoIcons.pencil, color: AppColors.blanco, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EntradaAnimada(
            indice: 0,
            child: Column(
              children: [
                Text(
                  perfil['nombre'] ?? '',
                  style: const TextStyle(color: AppColors.blanco, fontSize: 24, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  perfil['email'] ?? '',
                  style: const TextStyle(color: AppColors.textoSecundario, fontSize: 14),
                ),
              ],
            ),
          ),
          EntradaAnimada(
            indice: 1,
            child: CupertinoListSection.insetGrouped(
              backgroundColor: AppColors.transparente,
              separatorColor: AppColors.separador,
              decoration: BoxDecoration(
                color: AppColors.vidrio,
                borderRadius: BorderRadius.circular(18),
              ),
              header: const Text(
                'DATOS PERSONALES',
                style: TextStyle(color: AppColors.textoSecundario, fontSize: 13, letterSpacing: 1.2),
              ),
              children: filas.map((fila) {
                return CupertinoListTile(
                  leading: Icon(fila['icono'] as IconData, color: AppColors.cian),
                  title: Text(
                    perfil[fila['clave']] ?? '',
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
                'PREFERENCIAS',
                style: TextStyle(color: AppColors.textoSecundario, fontSize: 13, letterSpacing: 1.2),
              ),
              children: [
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.bell_fill, color: AppColors.ambar),
                  title: const Text('Notificaciones', style: TextStyle(color: AppColors.blanco)),
                  trailing: CupertinoSwitch(
                    value: notificaciones,
                    onChanged: (v) => setState(() => notificaciones = v),
                  ),
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.alarm_fill, color: AppColors.rosa),
                  title: const Text('Recordatorios', style: TextStyle(color: AppColors.blanco)),
                  trailing: CupertinoSwitch(
                    value: recordatorios,
                    onChanged: (v) => setState(() => recordatorios = v),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: EntradaAnimada(
              indice: 3,
              child: BotonGradiente(
                texto: 'EDITAR PERFIL',
                icono: CupertinoIcons.pencil,
                gradiente: AppColors.gradienteSecundario,
                onPressed: () => _editarPerfil(perfil),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Panel inferior para editar el perfil.
class _PanelEditarPerfil extends StatefulWidget {
  final Map<String, String> perfil;
  const _PanelEditarPerfil({required this.perfil});

  @override
  State<_PanelEditarPerfil> createState() => _PanelEditarPerfilState();
}

class _PanelEditarPerfilState extends State<_PanelEditarPerfil> {
  late final nombreController = TextEditingController(text: widget.perfil['nombre']);
  late final emailController = TextEditingController(text: widget.perfil['email']);
  late final telefonoController = TextEditingController(text: widget.perfil['telefono']);

  Future<void> _guardar() async {
    final nombre = nombreController.text.trim();
    final email = emailController.text.trim();
    final telefono = telefonoController.text.trim();

    if (nombre.isEmpty || !email.contains('@') || telefono.length < 9) {
      await mostrarMensaje(context,
          titulo: 'Datos inválidos',
          mensaje: 'Revisa el nombre, el email y que el teléfono tenga 9 dígitos.');
      return;
    }
    if (!mounted) return;
    context.read<AlumnoProvider>().actualizarPerfil({
      'nombre': nombre,
      'email': email,
      'telefono': telefono,
    });
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    nombreController.dispose();
    emailController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Sube el panel junto con el teclado
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: const BoxDecoration(
          color: AppColors.panel,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.bordeVidrio,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Editar perfil',
                style: TextStyle(color: AppColors.blanco, fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 18),
              CampoVidrio(controller: nombreController, placeholder: 'Nombre', icono: CupertinoIcons.person),
              const SizedBox(height: 12),
              CampoVidrio(
                controller: emailController,
                placeholder: 'Email',
                icono: CupertinoIcons.mail,
                teclado: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              CampoVidrio(
                controller: telefonoController,
                placeholder: 'Teléfono',
                icono: CupertinoIcons.phone,
                teclado: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              BotonGradiente(texto: 'GUARDAR CAMBIOS', onPressed: _guardar),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/photo_picker.dart';
import '../core/utils/validators.dart';
import '../models/student.dart';
import '../widgets/common_widgets.dart';
import '../data/aula_store.dart';
import '../app/app_routes.dart';
import '../widgets/academic_background.dart';
import 'student_form.dart';
import 'student_list_screen.dart';

class AulaHome extends StatefulWidget {
  const AulaHome({
    super.key,
    required this.store,
    this.initialPage = 0,
    this.authenticated = false,
  });
  final AulaStore store;
  final int initialPage;
  final bool authenticated;
  @override
  State<AulaHome> createState() => _AulaHomeState();
}

class _AulaHomeState extends State<AulaHome> {
  bool logged = false, obscure = true;
  int page = 0;

  String get teacher => widget.store.teacher;
  set teacher(String value) => widget.store.teacher = value;
  String get email => widget.store.email;
  set email(String value) => widget.store.email = value;
  String get phone => widget.store.phone;
  set phone(String value) => widget.store.phone = value;
  Uint8List? get teacherPhoto => widget.store.teacherPhoto;
  set teacherPhoto(Uint8List? value) => widget.store.teacherPhoto = value;

  final loginKey = GlobalKey<FormState>();
  final loginEmail = TextEditingController(),
      password = TextEditingController();
  List<Student> get students => widget.store.students;
  @override
  void initState() {
    super.initState();
    page = widget.initialPage;
    logged = widget.authenticated;
  }

  @override
  void dispose() {
    loginEmail.dispose();
    password.dispose();
    super.dispose();
  }

  void go(int value) =>
      Navigator.pushReplacementNamed(context, AppRoutes.sections[value]);
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        Positioned.fill(child: AcademicBackground(immersive: !logged)),
        SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040),
              child: logged ? workspace() : login(),
            ),
          ),
        ),
      ],
    ),
    bottomNavigationBar: logged
        ? NavigationBar(
            selectedIndex: page,
            onDestinationSelected: go,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Inicio',
              ),
              NavigationDestination(
                icon: Icon(Icons.people_outline),
                label: 'Alumnos',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_add_alt),
                label: 'Registrar',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                label: 'Perfil',
              ),
            ],
          )
        : null,
  );

  Widget login() => SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFAB8CFF), Color(0xFF6748DE)],
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [
              BoxShadow(
                color: Color(0x666748DE),
                blurRadius: 50,
                spreadRadius: 8,
              ),
            ],
          ),
          child: const Icon(
            Icons.school_rounded,
            color: Colors.white,
            size: 48,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'El futuro empieza\nen tu aula.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 38,
            height: 1.1,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.5,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'AULA VIOLETA  /  APRENDER SIN LÍMITES',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 2,
            color: Color(0xFFCDC0FF),
          ),
        ),
        const SizedBox(height: 36),
        Container(
          constraints: const BoxConstraints(maxWidth: 430),
          padding: const EdgeInsets.all(28),
          decoration: panelDecoration(),
          child: Form(
            key: loginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tag('PORTAL DOCENTE · SECCIÓN A'),
                const SizedBox(height: 20),
                const Text(
                  '¡Qué bueno verte!',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ingresa y acompaña el progreso de tu aula.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 28),
                TextFormField(
                  controller: loginEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                  validator: (v) =>
                      v != null &&
                          RegExp(
                            r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                          ).hasMatch(v.trim())
                      ? null
                      : 'Ingresa un correo válido',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: password,
                  obscureText: obscure,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => obscure = !obscure),
                      icon: Icon(
                        obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  validator: (v) => (v?.length ?? 0) >= 4
                      ? null
                      : 'Usa al menos 4 caracteres',
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    if (loginKey.currentState!.validate())
                      Navigator.pushReplacementNamed(context, AppRoutes.menu);
                  },
                  child: const Text('Ingresar a mi aula  →'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Modo demostración: utiliza cualquier correo válido y una contraseña de 4 caracteres.',
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Un espacio para quienes inspiran el mañana.',
          style: TextStyle(color: Color(0xFFC6BCE5), fontSize: 12),
        ),
      ],
    ),
  );

  Widget workspace() => Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 16, 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: purple,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.school, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aula violeta',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                  Text(
                    'SECCIÓN A · PORTAL DOCENTE',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.2,
                      color: purple,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Cerrar sesión',
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              ),
              icon: const Icon(Icons.logout_rounded),
            ),
          ],
        ),
      ),
      Expanded(
        child: page == 1
            ? StudentListScreen(students: students, onRegister: () => go(2))
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: switch (page) {
                  0 => dashboard(),
                  2 => StudentForm(
                    onSave: (s) {
                      widget.store.addStudent(s);
                      go(1);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Alumno registrado correctamente'),
                        ),
                      );
                    },
                  ),
                  _ => profile(),
                },
              ),
      ),
    ],
  );

  Widget dashboard() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4731AC), Color(0xFF8C6AEF)],
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'TU ESPACIO PARA ENSEÑAR',
              style: TextStyle(
                color: Color(0xFFDCD2FF),
                letterSpacing: 1.5,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Hola, ${teacher.split(' ').first} ✨',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Grandes logros comienzan\ncon pequeños aprendizajes.',
              style: TextStyle(color: Colors.white, fontSize: 17, height: 1.5),
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () => go(2),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white54),
              ),
              child: const Text('+  Registrar alumno'),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      Row(
        children: [
          Expanded(
            child: stat('${students.length}', 'Alumnos', Icons.groups_outlined),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: stat(
              '${students.where((s) => s.grade >= 11).length}',
              'Aprobados',
              Icons.verified_outlined,
            ),
          ),
        ],
      ),
      const SizedBox(height: 28),
      const Text(
        'Tu aula, a un toque',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      menuTile(
        Icons.person_add_alt_1,
        'Registrar alumno',
        'Agrega sus datos, nota y fotografía',
        2,
      ),
      menuTile(
        Icons.format_list_bulleted,
        'Listar alumnos',
        'Consulta el progreso de tu sección',
        1,
      ),
      menuTile(
        Icons.badge_outlined,
        'Mi perfil',
        'Personaliza tu información docente',
        3,
      ),
    ],
  );

  Widget stat(String value, String label, IconData icon) => Container(
    padding: const EdgeInsets.all(20),
    decoration: panelDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: purple),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        Text(label, style: const TextStyle(color: Colors.black54)),
      ],
    ),
  );
  Widget menuTile(
    IconData icon,
    String title,
    String subtitle,
    int index,
  ) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Icon(icon, color: purple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right, color: purple),
        onTap: () => go(index),
      ),
    ),
  );
  Widget profile() => Column(
    children: [
      title('Mi perfil', 'La persona detrás de cada aprendizaje.'),
      const SizedBox(height: 24),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: panelDecoration(),
        child: Column(
          children: [
            avatar(teacher, teacherPhoto, radius: 48),
            const SizedBox(height: 16),
            Text(
              teacher,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            tag('DOCENTE · SECCIÓN A'),
            const SizedBox(height: 28),
            info(Icons.person_outline, 'Nombre', teacher),
            info(Icons.mail_outline, 'Correo', email),
            info(Icons.phone_outlined, 'Teléfono', phone),
            info(Icons.school_outlined, 'Rol', 'Docente'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: editProfile,
              child: const Text('Editar perfil'),
            ),
          ],
        ),
      ),
    ],
  );
  Widget info(IconData icon, String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Icon(icon, color: purple, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.black45, fontSize: 11),
              ),
              Text(value),
            ],
          ),
        ),
      ],
    ),
  );
  Future<void> editProfile() async {
    final n = TextEditingController(text: teacher),
        e = TextEditingController(text: email),
        p = TextEditingController(text: phone);
    Uint8List? photo = teacherPhoto;
    final key = GlobalKey<FormState>();
    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, update) => AlertDialog(
          title: const Text('Editar perfil'),
          content: SizedBox(
            width: 400,
            child: Form(
              key: key,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        final bytes = await pickPhoto(ctx);
                        if (bytes != null) update(() => photo = bytes);
                      },
                      icon: const Icon(Icons.add_a_photo_outlined),
                      label: Text(
                        photo == null ? 'Colocar foto' : 'Foto seleccionada ✓',
                      ),
                    ),
                    TextFormField(
                      controller: n,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      validator: requiredText,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: e,
                      decoration: const InputDecoration(labelText: 'Correo'),
                      validator: (v) =>
                          v != null &&
                              RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v)
                          ? null
                          : 'Correo inválido',
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: p,
                      decoration: const InputDecoration(labelText: 'Teléfono'),
                      validator: requiredText,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (key.currentState!.validate()) {
                  setState(() {
                    teacher = n.text.trim();
                    email = e.text.trim();
                    phone = p.text.trim();
                    teacherPhoto = photo;
                  });
                  Navigator.pop(ctx);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
    n.dispose();
    e.dispose();
    p.dispose();
  }
}

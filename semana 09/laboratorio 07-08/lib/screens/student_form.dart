import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/photo_picker.dart';
import '../core/utils/validators.dart';
import '../models/student.dart';
import '../widgets/common_widgets.dart';

class StudentForm extends StatefulWidget {
  const StudentForm({super.key, required this.onSave});
  final ValueChanged<Student> onSave;
  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final keyForm = GlobalKey<FormState>();
  final name = TextEditingController(),
      last = TextEditingController(),
      grade = TextEditingController();
  Uint8List? photo;
  @override
  void dispose() {
    name.dispose();
    last.dispose();
    grade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: keyForm,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title('Un nuevo comienzo', 'Registra a un alumno en tu sección.'),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: panelDecoration(),
          child: Column(
            children: [
              Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(60),
                  onTap: () async {
                    final bytes = await pickPhoto(context);
                    if (mounted && bytes != null) setState(() => photo = bytes);
                  },
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: const Color(0xFFEEE9FF),
                    backgroundImage: photo == null ? null : MemoryImage(photo!),
                    child: photo == null
                        ? const Icon(
                            Icons.add_a_photo_outlined,
                            color: purple,
                            size: 32,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Toca para colocar una foto',
                style: TextStyle(color: purple, fontSize: 12),
              ),
              const SizedBox(height: 28),
              TextFormField(
                controller: name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nombre del alumno',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: requiredText,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: last,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: requiredText,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: grade,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Nota (0 a 20)',
                  prefixIcon: Icon(Icons.school_outlined),
                ),
                validator: (v) {
                  final g = double.tryParse((v ?? '').replaceAll(',', '.'));
                  return g != null && g.isFinite && g >= 0 && g <= 20
                      ? null
                      : 'Ingresa una nota entre 0 y 20';
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Se considera aprobado desde 11. La fotografía es opcional.',
                style: TextStyle(fontSize: 12, color: Colors.black45),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  if (keyForm.currentState!.validate()) {
                    widget.onSave(
                      Student(
                        name.text.trim(),
                        last.text.trim(),
                        double.parse(grade.text.replaceAll(',', '.')),
                        photo,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Guardar alumno'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

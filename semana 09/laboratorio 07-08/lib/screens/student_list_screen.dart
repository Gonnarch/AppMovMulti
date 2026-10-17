import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../models/student.dart';
import '../widgets/common_widgets.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({
    super.key,
    required this.students,
    required this.onRegister,
  });
  final List<Student> students;
  final VoidCallback onRegister;
  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final filtered = widget.students
        .where(
          (student) => student.fullName.toLowerCase().contains(
            query.trim().toLowerCase(),
          ),
        )
        .toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            children: [
              title('Mi alumnado', 'Cada historia cuenta. Sigue su progreso.'),
              const SizedBox(height: 22),
              TextField(
                onChanged: (value) => setState(() => query = value),
                decoration: const InputDecoration(
                  hintText: 'Buscar por nombre o apellido',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('${filtered.length} alumnos · Sección A'),
                  ),
                  IconButton(
                    onPressed: widget.onRegister,
                    tooltip: 'Registrar alumno',
                    icon: const Icon(Icons.person_add_alt, color: purple),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? const Center(child: Text('No se encontraron alumnos.'))
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  itemCount: filtered.length,
                  separatorBuilder: (_, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      StudentCard(student: filtered[index]),
                ),
        ),
      ],
    );
  }
}

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.student});
  final Student student;
  @override
  Widget build(BuildContext context) {
    final approved = student.grade >= 11;
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: avatar(student.fullName, student.photo),
        title: Text(
          student.fullName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Wrap(
            spacing: 12,
            runSpacing: 6,
            children: [
              Text('Nota: ${student.grade.toStringAsFixed(1)} / 20'),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: approved
                      ? const Color(0xFFE5F6EF)
                      : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  approved ? 'Aprobado' : 'Desaprobado',
                  style: TextStyle(
                    fontSize: 11,
                    color: approved
                        ? const Color(0xFF22865F)
                        : const Color(0xFFC14B60),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

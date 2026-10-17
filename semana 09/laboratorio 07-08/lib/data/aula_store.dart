import 'dart:typed_data';
import '../models/student.dart';

/// Estado compartido entre rutas. Se puede sustituir por un repositorio remoto.
class AulaStore {
  String teacher = 'María González';
  String email = 'maria.gonzalez@colegio.edu';
  String phone = '912 345 678';
  Uint8List? teacherPhoto;

  static const List<Map<String, Object?>> _seed = [
    {'name': 'Ana', 'lastName': 'Torres', 'grade': 18},
    {'name': 'Luis', 'lastName': 'García', 'grade': 12},
    {'name': 'María', 'lastName': 'López', 'grade': 9},
    {'name': 'Carlos', 'lastName': 'Ruiz', 'grade': 15},
  ];
  final List<Student> _students = _seed.map(Student.fromMap).toList();

  List<Student> get students => List.unmodifiable(_students);
  void addStudent(Student student) => _students.add(student);
}

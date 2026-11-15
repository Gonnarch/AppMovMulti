import 'package:flutter/foundation.dart';

import '../models/alumno.dart';

class AlumnoProvider extends ChangeNotifier {
  // Lista de carreras disponibles para el CupertinoPicker
  static const List<String> carreras = [
    'Diseño y Desarrollo de Software',
    'Big Data y Ciencia de Datos',
    'Ciberseguridad',
    'Redes y Comunicaciones',
    'Mecatrónica Industrial',
    'Administración de Empresas',
  ];

  int _siguienteId = 6;

  final List<Alumno> _alumnos = [
    const Alumno(id: 1, nombre: 'Valeria', apellido: 'Quispe', edad: 20, nota: 18, carrera: 'Diseño y Desarrollo de Software'),
    const Alumno(id: 2, nombre: 'Diego', apellido: 'Huamán', edad: 22, nota: 9.5, carrera: 'Ciberseguridad'),
    const Alumno(id: 3, nombre: 'Camila', apellido: 'Rojas', edad: 19, nota: 15.5, carrera: 'Big Data y Ciencia de Datos'),
    const Alumno(id: 4, nombre: 'Mateo', apellido: 'Flores', edad: 21, nota: 12, carrera: 'Redes y Comunicaciones'),
    const Alumno(id: 5, nombre: 'Lucía', apellido: 'Mendoza', edad: 23, nota: 8, carrera: 'Mecatrónica Industrial'),
  ];

  // Datos del perfil guardados en un Map
  final Map<String, String> _perfil = {
    'nombre': 'Sebastian Salas',
    'email': 'sebastian.salas@correo.com',
    'telefono': '992080001',
    'rol': 'Docente',
  };

  List<Alumno> get alumnos => List.unmodifiable(_alumnos);
  Map<String, String> get perfil => Map.unmodifiable(_perfil);

  int get total => _alumnos.length;
  int get aprobados => _alumnos.where((a) => a.aprobado).length;
  double get promedio => _alumnos.isEmpty
      ? 0
      : _alumnos.map((a) => a.nota).reduce((a, b) => a + b) / _alumnos.length;

  void agregar({
    required String nombre,
    required String apellido,
    required int edad,
    required double nota,
    required String carrera,
  }) {
    _alumnos.add(Alumno(
      id: _siguienteId++,
      nombre: nombre,
      apellido: apellido,
      edad: edad,
      nota: nota,
      carrera: carrera,
    ));
    notifyListeners();
  }

  void eliminar(int id) {
    _alumnos.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  void actualizarPerfil(Map<String, String> datos) {
    _perfil.addAll(datos);
    notifyListeners();
  }
}

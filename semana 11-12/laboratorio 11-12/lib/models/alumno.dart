class Alumno {
  final int id;
  final String nombre;
  final String apellido;
  final int edad;
  final double nota;
  final String carrera;

  const Alumno({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.edad,
    required this.nota,
    required this.carrera,
  });

  static const double notaMinima = 10.5;

  String get nombreCompleto => '$nombre $apellido'.trim();

  bool get aprobado => nota >= notaMinima;

  String get iniciales {
    final a = nombre.isNotEmpty ? nombre[0] : '';
    final b = apellido.isNotEmpty ? apellido[0] : '';
    final r = (a + b).toUpperCase();
    return r.isEmpty ? '?' : r;
  }

  /// Muestra "18" en vez de "18.0", pero "15.5" se mantiene.
  String get notaTexto =>
      nota == nota.roundToDouble() ? nota.toInt().toString() : nota.toStringAsFixed(1);
}

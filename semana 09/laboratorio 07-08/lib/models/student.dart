import 'dart:typed_data';

class Student {
  Student(this.name, this.lastName, this.grade, [this.photo]);
  String name, lastName;
  double grade;
  Uint8List? photo;
  String get fullName => '$name $lastName';

  // Un mapa representa los campos de un alumno, útil para una futura API.
  Map<String, Object?> toMap() => {
    'name': name,
    'lastName': lastName,
    'grade': grade,
  };

  factory Student.fromMap(Map<String, Object?> map) => Student(
    map['name'] as String,
    map['lastName'] as String,
    (map['grade'] as num).toDouble(),
  );
}

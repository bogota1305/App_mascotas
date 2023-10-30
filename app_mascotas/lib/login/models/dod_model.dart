import 'package:app_mascotas/login/models/user_model.dart';

class Dog {
  int? id;
  String nombre;
  DateTime fechaNacimiento;
  String raza;
  String personalidad;
  String cuidadosEspeciales;
  String sexo;
  String idUser;
  List<String> photos;

  Dog({
    this.id,
    required this.nombre,
    required this.fechaNacimiento,
    required this.raza,
    required this.personalidad,
    required this.cuidadosEspeciales,
    required this.sexo,
    required this.idUser,
    required this.photos,
  });

  // Método para crear una instancia de Dog a partir de un mapa JSON
  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      fechaNacimiento: DateTime.parse(json['fechaNacimiento'] ?? []),
      raza: json['raza'] ?? '',
      personalidad: json['personalidad'] ?? '',
      cuidadosEspeciales: json['cuidadosEspeciales'] ?? '',
      sexo: json['sexo'] ?? '',
      idUser: json['idUser'] ?? '',
      photos: List<String>.from(json['photos'] ?? []),
    );
  }

  // Método para convertir una instancia de Dog a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'fechaNacimiento': fechaNacimiento.toIso8601String(),
      'raza': raza,
      'personalidad': personalidad,
      'cuidadosEspeciales': cuidadosEspeciales,
      'sexo': sexo,
      'idUser': idUser,
      'photos': photos,
    };
  }

  // Método para crear una copia del objeto Dog con algunos campos actualizados
  Dog copyWith({
    int? id,
    String? nombre,
    DateTime? fechaNacimiento,
    String? raza,
    String? personalidad,
    String? cuidadosEspeciales,
    String? sexo,
    String? idUser,
    List<String>? photos,
  }) {
    return Dog(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      raza: raza ?? this.raza,
      personalidad: personalidad ?? this.personalidad,
      cuidadosEspeciales: cuidadosEspeciales ?? this.cuidadosEspeciales,
      sexo: sexo ?? this.sexo,
      idUser: idUser ?? this.idUser,
      photos: photos ?? this.photos,
    );
  }
}

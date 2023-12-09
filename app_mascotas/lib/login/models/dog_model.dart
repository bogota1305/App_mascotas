class Dog {
  String? id;
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

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'] ?? '',
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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

  Dog copyWith({
    String? id,
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

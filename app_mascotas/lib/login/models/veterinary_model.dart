import 'package:app_mascotas/login/models/localization_model.dart';

class Veterinary {
  String? id;
  String nombre;
  String numeroTelefono;
  Localization ubicacion;

  Veterinary({
    this.id,
    required this.nombre,
    required this.numeroTelefono,
    required this.ubicacion,
  });

  factory Veterinary.fromJson(Map<String, dynamic> json) {
    return Veterinary(
      id: json['id'].toString(),
      nombre: json['nombre'] ?? '',
      numeroTelefono: json['numeroTelefono'] ?? '',
      ubicacion: json['ubicacion'] != null ? Localization.fromJson(json['ubicacion']) : Localization(ciudad: 'ciudad', direccion: 'direccion', indicacionesEspeciales: 'indicacionesEspeciales', latitud: 0, longitud: 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'numeroTelefono': numeroTelefono,
      'ubicacion': ubicacion.toJson(),
    };
  }

  Veterinary copyWith({
    String? id,
    String? nombre,
    String? numeroTelefono,
    Localization? ubicacion,
  }) {
    return Veterinary(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      numeroTelefono: numeroTelefono ?? this.numeroTelefono,
      ubicacion: ubicacion ?? this.ubicacion,
    );
  }
}

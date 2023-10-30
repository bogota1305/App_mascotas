import 'package:app_mascotas/login/models/localization_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';

class Accommodation {
  String? id;
  List<String> photos;
  Localization ubicacion;
  String descripcionEspacio;
  double precioPorNoche;
  double precioPorHora;
  String idUser;

  Accommodation({
    this.id,
    required this.photos,
    required this.ubicacion,
    required this.descripcionEspacio,
    required this.precioPorNoche,
    required this.precioPorHora,
    required this.idUser,
  });

  factory Accommodation.fromJson(Map<String, dynamic> json) {
    return Accommodation(
      id: json['id'] ?? '',
      photos: List<String>.from(json['photos'] ?? []),
      ubicacion: json['ubicacion'] != null ? Localization.fromJson(json['ubicacion']) : Localization(ciudad: 'ciudad', direccion: 'direccion', indicacionesEspeciales: 'indicacionesEspeciales'), // TODO
      descripcionEspacio: json['descripcionEspacio'] ?? '',
      precioPorNoche: json['precioPorNoche'].toDouble() ?? '',
      precioPorHora: json['precioPorHora'].toDouble() ?? '',
      idUser: json['idUser'] ?? '', // TODO
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photos': photos,
      'ubicacion': ubicacion.toJson(),
      'descripcionEspacio': descripcionEspacio,
      'precioPorNoche': precioPorNoche,
      'precioPorHora': precioPorHora,
      'user': idUser,
    };
  }

  Accommodation copyWith({
    String? id,
    List<String>? photos,
    Localization? ubicacion,
    String? descripcionEspacio,
    double? precioPorNoche,
    double? precioPorHora,
    String? idUser,
  }) {
    return Accommodation(
      id: id ?? this.id,
      photos: photos ?? this.photos,
      ubicacion: ubicacion ?? this.ubicacion,
      descripcionEspacio: descripcionEspacio ?? this.descripcionEspacio,
      precioPorNoche: precioPorNoche ?? this.precioPorNoche,
      precioPorHora: precioPorHora ?? this.precioPorHora,
      idUser: idUser ?? this.idUser,
    );
  }
}

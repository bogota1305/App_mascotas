import 'package:app_mascotas/login/models/localization_model.dart';

class Accommodation {
  String? id;
  List<String> photos;
  Localization ubicacion;
  String descripcionEspacio;
  double precioPorNoche;
  double precioPorHora;
  String idUser;
  String tipoDeServicio;
  DateTime diaInicioDisponibilidad;
  DateTime diaFinDisponibilidad;
  int horaInicioDisponibilidad;
  int horaFinDisponibilidad;

  Accommodation({
    this.id,
    required this.photos,
    required this.ubicacion,
    required this.descripcionEspacio,
    required this.precioPorNoche,
    required this.precioPorHora,
    required this.idUser,
    required this.tipoDeServicio,
    required this.diaInicioDisponibilidad,
    required this.diaFinDisponibilidad,
    required this.horaInicioDisponibilidad,
    required this.horaFinDisponibilidad,
  });

  factory Accommodation.fromJson(Map<String, dynamic> json) {
    return Accommodation(
      id: json['id'] ?? '',
      photos: List<String>.from(json['photos'] ?? []),
      ubicacion: json['ubicacion'] != null ? Localization.fromJson(json['ubicacion']) : Localization(ciudad: 'ciudad', direccion: 'direccion', indicacionesEspeciales: 'indicacionesEspeciales', latitud: 0, longitud: 0), // TODO
      descripcionEspacio: json['descripcionEspacio'] ?? '',
      precioPorNoche: json['precioPorNoche'].toDouble() ?? '',
      precioPorHora: json['precioPorHora'].toDouble() ?? '',
      idUser: json['idUser'] ?? '',
      tipoDeServicio: json['tipoDeServicio'] ?? '',
      diaInicioDisponibilidad: DateTime.parse(json['diaInicioDisponibilidad'] ?? ''),
      diaFinDisponibilidad: DateTime.parse(json['diaFinDisponibilidad'] ?? ''),
      horaInicioDisponibilidad: json['horaInicioDisponibilidad'] ?? 0,
      horaFinDisponibilidad: json['horaFinDisponibilidad'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photos': photos,
      'ubicacion': ubicacion.toJson(),
      'descripcionEspacio': descripcionEspacio,
      'precioPorNoche': precioPorNoche,
      'precioPorHora': precioPorHora,
      'idUser': idUser,
      'tipoDeServicio': tipoDeServicio,
      'diaInicioDisponibilidad': diaInicioDisponibilidad.toIso8601String(),
      'diaFinDisponibilidad': diaFinDisponibilidad.toIso8601String(),
      'horaInicioDisponibilidad': horaInicioDisponibilidad,
      'horaFinDisponibilidad': horaFinDisponibilidad,
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
    String? tipoDeServicio,
    DateTime? diaInicioDisponibilidad,
    DateTime? diaFinDisponibilidad,
    int? horaInicioDisponibilidad,
    int? horaFinDisponibilidad,
  }) {
    return Accommodation(
      id: id ?? this.id,
      photos: photos ?? this.photos,
      ubicacion: ubicacion ?? this.ubicacion,
      descripcionEspacio: descripcionEspacio ?? this.descripcionEspacio,
      precioPorNoche: precioPorNoche ?? this.precioPorNoche,
      precioPorHora: precioPorHora ?? this.precioPorHora,
      idUser: idUser ?? this.idUser,
      tipoDeServicio: tipoDeServicio ?? this.tipoDeServicio,
      diaInicioDisponibilidad: diaInicioDisponibilidad ?? this.diaInicioDisponibilidad,
      diaFinDisponibilidad: diaFinDisponibilidad ?? this.diaFinDisponibilidad,
      horaInicioDisponibilidad: horaInicioDisponibilidad ?? this.horaInicioDisponibilidad,
      horaFinDisponibilidad: horaFinDisponibilidad ?? this.horaFinDisponibilidad,
    );
  }
}

class Localization {
  String? id;
  String ciudad;
  String direccion;
  String indicacionesEspeciales;
  double latitud;
  double longitud;

  Localization({
    this.id,
    required this.ciudad,
    required this.direccion,
    required this.indicacionesEspeciales,
    required this.latitud,
    required this.longitud,
  });

  factory Localization.fromJson(Map<String, dynamic> json) {
    return Localization(
      id: json['id'] ?? '',
      ciudad: json['ciudad'] ?? '',
      direccion: json['direccion'] ?? '',
      indicacionesEspeciales: json['indicacionesEspeciales'] ?? '',
      latitud: json['latitud'] ?? 0.0, // Cambiar el valor predeterminado según sea necesario
      longitud: json['longitud'] ?? 0.0, // Cambiar el valor predeterminado según sea necesario
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ciudad': ciudad,
      'direccion': direccion,
      'indicacionesEspeciales': indicacionesEspeciales,
      'latitud': latitud,
      'longitud': longitud,
    };
  }

  Localization copyWith({
    String? id,
    String? ciudad,
    String? direccion,
    String? indicacionesEspeciales,
    double? latitud,
    double? longitud,
  }) {
    return Localization(
      id: id ?? this.id,
      ciudad: ciudad ?? this.ciudad,
      direccion: direccion ?? this.direccion,
      indicacionesEspeciales: indicacionesEspeciales ?? this.indicacionesEspeciales,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
    );
  }
}

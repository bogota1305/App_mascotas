class Localization {
  String? id;
  String ciudad;
  String direccion;
  String indicacionesEspeciales;

  Localization({
    this.id,
    required this.ciudad,
    required this.direccion,
    required this.indicacionesEspeciales,
  });

  factory Localization.fromJson(Map<String, dynamic> json) {
    return Localization(
      id: json['id'] ?? '',
      ciudad: json['ciudad'] ?? '',
      direccion: json['direccion'] ?? '',
      indicacionesEspeciales: json['indicacionesEspeciales'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ciudad': ciudad,
      'direccion': direccion,
      'indicacionesEspeciales': indicacionesEspeciales,
    };
  }

  Localization copyWith({
    String? id,
    String? ciudad,
    String? direccion,
    String? indicacionesEspeciales,
  }) {
    return Localization(
      id: id ?? this.id,
      ciudad: ciudad ?? this.ciudad,
      direccion: direccion ?? this.direccion,
      indicacionesEspeciales: indicacionesEspeciales ?? this.indicacionesEspeciales,
    );
  }
}

class Search {
  int? id;
  String tipoDeServicio;
  DateTime fechaDeInicio;
  DateTime fechaDeFin;
  int horaDeInicio;
  int horaDeFin;
  String ordenamiento;

  Search({
    this.id,
    required this.tipoDeServicio,
    required this.fechaDeInicio,
    required this.fechaDeFin,
    required this.horaDeInicio,
    required this.horaDeFin,
    required this.ordenamiento,
  });

  Map<String, dynamic> toJson() {
    return {
      'tipoDeServicio': tipoDeServicio,
      'fechaDeInicio': fechaDeInicio.toIso8601String(),
      'fechaDeFin': fechaDeFin.toIso8601String(),
      'horaDeInicio': horaDeInicio,
      'horaDeFin': horaDeFin,
      'ordenamiento': ordenamiento,
    };
  }

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      id: json['id'] ?? 0,
      tipoDeServicio: json['tipoDeServicio'] ?? '',
      fechaDeInicio: DateTime.parse(json['fechaDeInicio'] ?? ''),
      fechaDeFin: DateTime.parse(json['fechaDeFin'] ?? ''),
      horaDeInicio: json['horaDeInicio'] ?? 0,
      horaDeFin: json['horaDeFin'] ?? 0,
      ordenamiento: json['ordenamiento'],
    );
  }
}

class RequestModel {
  int? id;
  String estado;
  String idUsuarioSolicitante;
  String idUsuarioSolicitado;
  String tipoDeServicio;
  DateTime fechaDeInicio;
  DateTime fechaDeFin;
  int horaDeInicio;
  int horaDeFin;
  List<String> idPerros;
  String idAlojamiento;
  int precio;

  RequestModel({
    this.id,
    required this.estado,
    required this.idUsuarioSolicitante,
    required this.idUsuarioSolicitado,
    required this.tipoDeServicio,
    required this.fechaDeInicio,
    required this.fechaDeFin,
    required this.horaDeInicio,
    required this.horaDeFin,
    required this.idPerros,
    required this.idAlojamiento,
    required this.precio,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      estado: json['estado'] ?? '',
      idUsuarioSolicitante: json['idUsuarioSolicitante'] ?? '',
      idUsuarioSolicitado: json['idUsuarioSolicitado'] ?? '',
      tipoDeServicio: json['tipoDeServicio'] ?? '',
      fechaDeInicio: DateTime.parse(json['fechaDeInicio'] ?? ''),
      fechaDeFin: DateTime.parse(json['fechaDeFin'] ?? ''),
      horaDeInicio: json['horaDeInicio'] ?? 0,
      horaDeFin: json['horaDeFin'] ?? 0,
      idPerros: List<String>.from(json['idPerros'] ?? []),
      idAlojamiento: json['idAlojamiento'] ?? '',
      precio: json['precio'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estado': estado,
      'idUsuarioSolicitante': idUsuarioSolicitante,
      'idUsuarioSolicitado': idUsuarioSolicitado,
      'tipoDeServicio': tipoDeServicio,
      'fechaDeInicio': fechaDeInicio.toIso8601String(),
      'fechaDeFin': fechaDeFin.toIso8601String(),
      'horaDeInicio': horaDeInicio,
      'horaDeFin': horaDeFin,
      'idPerro': idPerros,
      'idAlojamiento': idAlojamiento,
      'precio': precio,
    };
  }

  RequestModel copyWith({
    int? id,
    String? estado,
    String? idUsuarioSolicitante,
    String? idUsuarioSolicitado,
    String? tipoDeServicio,
    DateTime? fechaDeInicio,
    DateTime? fechaDeFin,
    int? horaDeInicio,
    int? horaDeFin,
    List<String>? idPerros,
    String? idAlojamiento,
    int? precio,
  }) {
    return RequestModel(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      idUsuarioSolicitante: idUsuarioSolicitante ?? this.idUsuarioSolicitante,
      idUsuarioSolicitado: idUsuarioSolicitado ?? this.idUsuarioSolicitado,
      tipoDeServicio: tipoDeServicio ?? this.tipoDeServicio,
      fechaDeInicio: fechaDeInicio ?? this.fechaDeInicio,
      fechaDeFin: fechaDeFin ?? this.fechaDeFin,
      horaDeInicio: horaDeInicio ?? this.horaDeInicio,
      horaDeFin: horaDeFin ?? this.horaDeFin,
      idPerros: idPerros ?? this.idPerros,
      idAlojamiento: idAlojamiento ?? this.idAlojamiento,
      precio: precio ?? this.precio,
    );
  }
}

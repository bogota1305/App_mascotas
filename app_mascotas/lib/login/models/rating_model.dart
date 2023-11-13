class Rating {
  int? id;
  double puntuacion;
  String comentario;
  String idUsuarioCreador;
  String idUsuarioReceptor;

  Rating({
    this.id,
    required this.puntuacion,
    required this.comentario,
    required this.idUsuarioCreador,
    required this.idUsuarioReceptor,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] ?? 0,
      puntuacion: json['puntuacion'].toDouble(),
      comentario: json['comentario'] ?? '',
      idUsuarioCreador: json['idUsuarioCreador'],
      idUsuarioReceptor: json['idUsuarioReceptor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'puntuacion': puntuacion,
      'comentario': comentario,
      'idUsuarioCreador': idUsuarioCreador,
      'idUsuarioReceptor': idUsuarioReceptor,
    };
  }
}
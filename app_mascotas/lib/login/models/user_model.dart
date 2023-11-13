import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/dog_model.dart';
import 'package:app_mascotas/login/models/rating_model.dart';
import 'package:app_mascotas/reservation/models/request_controller.dart';

class User {
  String? id;
  String nombre;
  String apellidos;
  List<String> fotos;
  String descripcion;
  String contrasena;
  DateTime fechaNacimiento;
  String correo;
  String tipo;
  String sexo;
  String prefijoTelefono;
  String telefono;
  String tipoDocumento;
  String documento;
  List<Dog>? perros;
  String pais;
  List<String> fotosDocumento;
  Accommodation? alojamiento;
  List<Rating> calificaciones; // Lista de calificaciones
  double calificacionPromedio; // Calificación promedio
  String? distancia;
  //List<PaymentMethod> metodosDePago;
  //BankAccount cuentaBancaraia;
  List<RequestModel>solicitudesCreadas;
  List<RequestModel>solicitudesRecibidas;
  //Veterinary clinicaVeterinaria;
  //Insurance seguro;
  // List<preferenciasDeRazasAlojar: [];
  // List<perrosNoAlojados: [];

  User({
    this.id,
    required this.nombre,
    required this.apellidos,
    required this.fotos,
    required this.descripcion,
    required this.contrasena,
    required this.fechaNacimiento,
    required this.correo,
    required this.tipo,
    required this.sexo,
    required this.prefijoTelefono,
    required this.telefono,
    required this.tipoDocumento,
    required this.documento,
    this.perros,
    required this.pais,
    required this.fotosDocumento,
    this.alojamiento,
    required this.calificaciones, // Inicializa la lista de calificaciones
    required this.calificacionPromedio, // Inicializa la calificación promedio como null
    this.distancia,
    // required this.metodosDePago,
    // required this.cuentaBancaraia,
    // required this.clinicaVeterinaria,
    // required this.seguro,
    required this.solicitudesCreadas,
    required this.solicitudesRecibidas,
    // this.preferenciasDeRazasAlojar,
    // this.perrosNoAlojados,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellidos': apellidos,
      'fotos': fotos,
      'descripcion': descripcion,
      'contrasena': contrasena,
      'fechaNacimiento': fechaNacimiento.toIso8601String(),
      'correo': correo,
      'tipo': tipo,
      'sexo': sexo,
      'prefijoTelefono': prefijoTelefono,
      'telefono': telefono,
      'tipoDocumento': tipoDocumento,
      'documento': documento,
      'perros': perros?.map((dog) => dog.toJson()).toList(),
      'pais': pais,
      'fotosDocumento': fotosDocumento,
      'alojamiento': alojamiento?.toJson(),
      'calificaciones': calificaciones.map((rating) => rating.toJson()).toList(),
      'solicitudesCreadas': solicitudesCreadas.map((request) => request.toJson()).toList(),
      'solicitudesRecibidas': solicitudesRecibidas.map((request) => request.toJson()).toList(),
      // 'metodosDePago': metodosDePago.map((payment) => payment.toJson()).toList(),
      // 'cuentaBancaria': cuentaBancaria.toJson(),
      // 'clinicaVeterinaria': clinicaVeterinaria.toJson(),
      // 'seguro': seguro.toJson(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {

    final List<dynamic> perrosData = json['perros'] ?? [];
    final List<Dog> perros = perrosData.isNotEmpty ? perrosData.map((perroJson) => Dog.fromJson(perroJson)).toList() : [];

    final List<dynamic> calificacionesData = json['calificaciones'] ?? [];
    final List<Rating> calificaciones = calificacionesData.isNotEmpty ? calificacionesData.map((ratingJson) => Rating.fromJson(ratingJson)).toList() : [];

    final List<dynamic> solicitudesCreadasData = json['solicitudesCreadas'] ?? [];
    final List<RequestModel> solicitudesCreadas = solicitudesCreadasData.isNotEmpty ? solicitudesCreadasData.map((solicitudCreadaJson) => RequestModel.fromJson(solicitudCreadaJson)).toList() : [];

    final List<dynamic> solicitudesRecibidasData = json['solicitudesRecibidas'] ?? [];
    final List<RequestModel> solicitudesRecibidas = solicitudesRecibidasData.isNotEmpty ? solicitudesRecibidasData.map((solicitudRecibidaJson) => RequestModel.fromJson(solicitudRecibidaJson)).toList() : [];

    double promedio = json['calificacionPromedio'] ?? 0.0;
    if (calificaciones.isNotEmpty && promedio == 0) {
      for (var calificacion in calificaciones) {
        promedio += calificacion.puntuacion;
      }
      promedio /= calificaciones.length;
    }

    return User(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      apellidos: json['apellidos'] ?? '',
      fotos: List<String>.from(json['fotos'] ?? []),
      descripcion: json['descripcion'] ?? '',
      contrasena: json['contrasena'] ?? '',
      fechaNacimiento: DateTime.parse(json['fechaNacimiento'] ?? []),
      correo: json['correo'] ?? '',
      tipo: json['tipo'] ?? '',
      sexo: json['sexo'] ?? '',
      prefijoTelefono: json['prefijoTelefono'].toString(),
      telefono: json['telefono'].toString(),
      tipoDocumento: json['tipoDocumento'] ?? '',
      documento: json['documento'].toString(),
      pais: json['pais'] ?? '',
      fotosDocumento: List<String>.from(json['fotosDocumento'] ?? []), 
      perros: perros,
      alojamiento: json['alojamiento'] != null ? Accommodation.fromJson(json['alojamiento']) : null,
      calificaciones: calificaciones,
      calificacionPromedio: promedio, 
      solicitudesCreadas: solicitudesCreadas, 
      solicitudesRecibidas: solicitudesRecibidas, 
    );
  }

  User copyWith({
    String? id,
    String? nombre,
    String? apellidos,
    List<String>? fotos,
    String? descripcion,
    String? contrasena,
    DateTime? fechaNacimiento,
    String? correo,
    String? tipo,
    String? sexo,
    String? prefijoTelefono,
    String? telefono,
    String? tipoDocumento,
    String? documento,
    List<Dog>? perros,
    String? pais,
    List<String>? fotosDocumento,
    Accommodation? alojamiento,
    List<Rating>? calificaciones,
    double? calificacionPromedio, 
    String? distancia,
    List<RequestModel>? solicitudesCreadas,
    List<RequestModel>? solicitudesRecibidas,
    // List<PaymentMethod>? metodosDePago,
    // BankAccount? cuentaBancaraia,
    // Veterinary? clinicaVeterinaria,
    // Insurance? seguro,
  }) {
    return User(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      fotos: fotos ?? this.fotos,
      descripcion: descripcion ?? this.descripcion,
      contrasena: contrasena ?? this.contrasena,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      correo: correo ?? this.correo,
      tipo: tipo ?? this.tipo,
      sexo: sexo ?? this.sexo,
      prefijoTelefono: prefijoTelefono ?? this.prefijoTelefono,
      telefono: telefono ?? this.telefono,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      documento: documento ?? this.documento,
      perros: perros ?? this.perros,
      pais: pais ?? this.pais,
      fotosDocumento: fotosDocumento ?? this.fotosDocumento,
      alojamiento: alojamiento ?? this.alojamiento,
      calificaciones: calificaciones ?? this.calificaciones, // Actualiza la lista de calificaciones
      calificacionPromedio: calificacionPromedio ?? this.calificacionPromedio, // Actualiza la calificación promedio
      distancia: distancia ?? this.distancia, 
      solicitudesCreadas: solicitudesCreadas ?? this.solicitudesCreadas, 
      solicitudesRecibidas: solicitudesRecibidas ?? this.solicitudesRecibidas,
      // metodosDePago: metodosDePago ?? this.metodosDePago,
      // cuentaBancaraia: cuentaBancaraia ?? this.cuentaBancaraia,
      // clinicaVeterinaria: clinicaVeterinaria ?? this.clinicaVeterinaria,
      // seguro: seguro ?? this.seguro,
    );
  }
}

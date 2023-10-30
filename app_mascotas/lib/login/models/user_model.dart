import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/dod_model.dart';

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
  List<String> fotosId;
  Accommodation? alojamiento;
  //List<PaymentMethod> metodosDePago;
  //BankAccount cuentaBancaraia;
  //List<Rating> calificaciones;
  // List<solicitudesCreadas: [];
  // List<solicitudesRecividas: [];
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
    required this.fotosId,
    this.alojamiento,
    // required this.metodosDePago,
    // required this.cuentaBancaraia,
    // required this.calificaciones,
    // required this.clinicaVeterinaria,
    // required this.seguro,
    // this.solicitudesCreadas,
    // this.solicitudesRecividas,
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
      'fotosId': fotosId,
      'alojamiento': alojamiento?.toJson(),
      // 'metodosDePago': metodosDePago.map((payment) => payment.toJson()).toList(),
      // 'cuentaBancaria': cuentaBancaria.toJson(),
      // 'calificaciones': calificaciones.map((rating) => rating.toJson()).toList(),
      // 'clinicaVeterinaria': clinicaVeterinaria.toJson(),
      // 'seguro': seguro.toJson(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {

    final List<dynamic> perrosData = json['perros'] ?? [];
    final List<Dog> perros = perrosData.isNotEmpty ? perrosData.map((perroJson) => Dog.fromJson(perroJson)).toList() : [];

    return User(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      apellidos: json['apellidos'] ?? '',
      fotos: List<String>.from(json['fotos'] ?? []),
      descripcion: json['descripcion'] ?? '',
      contrasena: json['contrasena'] ?? '',
      fechaNacimiento: DateTime.parse("2011-10-02T00:00:00.000"), //DateTime.parse(json['fechaNacimiento'] ?? []) , TODO
      correo: json['correo'] ?? '',
      tipo: json['tipo'] ?? '',
      sexo: json['sexo'] ?? '',
      prefijoTelefono: json['prefijoTelefono'].toString(),
      telefono: json['telefono'].toString(),
      tipoDocumento: json['tipoDocumento'] ?? '',
      documento: json['documento'].toString(),
      pais: json['pais'] ?? '',
      fotosId: List<String>.from(json['fotosId'] ?? []), 
      perros: perros,
      alojamiento: json['alojamiento'] != null ? Accommodation.fromJson(json['alojamiento']) : null,
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
    List<String>? fotosId,
    Accommodation? alojamiento,
    // List<PaymentMethod>? metodosDePago,
    // BankAccount? cuentaBancaraia,
    // List<Rating>? calificaciones,
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
      fotosId: fotosId ?? this.fotosId,
      alojamiento: alojamiento ?? this.alojamiento,
      // metodosDePago: metodosDePago ?? this.metodosDePago,
      // cuentaBancaraia: cuentaBancaraia ?? this.cuentaBancaraia,
      // calificaciones: calificaciones ?? this.calificaciones,
      // clinicaVeterinaria: clinicaVeterinaria ?? this.clinicaVeterinaria,
      // seguro: seguro ?? this.seguro,
    );
  }
}

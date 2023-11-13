import 'package:app_mascotas/login/models/user_model.dart';

class LogedUserController {
  late User _user;

  LogedUserController() {
    _user = createDefaultUser();
  }

  User get user => _user;

  set user(User newUser) {
    _user = newUser;
  }

  User createDefaultUser() {
    return User(
      id: 'Guest',
      nombre: 'Guest',
      apellidos: '',
      fotos: [],
      descripcion: '',
      contrasena: '',
      fechaNacimiento: DateTime.now(),
      correo: '',
      tipo: '',
      sexo: '',
      prefijoTelefono: '',
      telefono: '',
      tipoDocumento: '',
      documento: '',
      pais: '',
      fotosDocumento: [],
      calificaciones: [],
      calificacionPromedio: 0,
      solicitudesCreadas: [],
      solicitudesRecibidas: [],
    );
  }
}

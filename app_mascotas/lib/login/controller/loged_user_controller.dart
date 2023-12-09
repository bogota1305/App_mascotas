import 'package:app_mascotas/login/models/user_model.dart';

class LogedUserController {
  late User _user;
  late String _token;
  late List<User> _favoritos;

  LogedUserController() {
    _user = createDefaultUser();
    _token = '';
    _favoritos = [];
  }

  User get user => _user;
  String get token => _token;
  List<User> get favoritos => _favoritos;

  set user(User newUser) {
    _user = newUser;
  }

  set token(String newToken) {
    _token = newToken;
  }

  set favoritos(List<User> newFavoritos){
    _favoritos = newFavoritos;
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
      cuidadoresFavoritos: [],
    );
  }
}

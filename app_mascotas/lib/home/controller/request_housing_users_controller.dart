import 'package:app_mascotas/login/models/user_model.dart';

class RequestsHousingUsersController {
  late List<User> _users;

  RequestsHousingUsersController() {
    _users = [];
  }

  List<User> get users => _users;

  set users(List<User> newUsers) {
    _users = newUsers;
  }
}

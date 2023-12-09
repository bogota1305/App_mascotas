import 'dart:convert';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserHomeRepository {
  final String url = 'http://157.253.45.208:3000';  // URL de tu API

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$url/users'));

    if (response.statusCode == 200) {
      final List<dynamic> userData = jsonDecode(response.body);
      return userData.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los usuarios.');
    }
  }

  Future<User> findUserById(String id) async {
    final response = await http.get(Uri.parse('$url/users/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = jsonDecode(response.body);
      return User.fromJson(userData);
    } else if (response.statusCode == 404) {
      throw Exception('Usuario no encontrado.');
    } else {
      throw Exception('Error al obtener el usuario por ID.');
    }
  }
}

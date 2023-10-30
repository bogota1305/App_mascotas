import 'dart:convert';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserHomeRepository {
  final String url = 'http://192.168.10.21:3000';  // URL de tu API

  Future<List<User>> getCuidadores() async {
    final response = await http.get(Uri.parse('$url/users'));

    if (response.statusCode == 200) {
      final List<dynamic> userData = jsonDecode(response.body);
      return userData.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los usuarios.');
    }
  }
}

import 'dart:convert';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = 'http://157.253.45.208:3000/auth';

  Future<bool> registerUser(BuildContext context, User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      // Manejar errores y mostrar diálogo en caso de fallo
      return false;
    }
  }

  Future<String> loginUser(BuildContext context, String mail, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'mail': mail, 'password': password}),
    );

    if (response.statusCode == 201) {
      final token = response.body;
      return token;
    } else {
      // Manejar errores y mostrar diálogo en caso de fallo
      return '';
    }
  }

  Future<bool> logoutUser(BuildContext context, String token) async {
    try {
      // Llamada al endpoint de logout en el servidor
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {'Authorization': token},
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        // Manejar errores y mostrar diálogo en caso de fallo
        return false;
      }
    } catch (e) {
      // Manejar errores y mostrar diálogo en caso de fallo
      return false;
    }
  }

  Future<User?> getUserFromToken(BuildContext context, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final user = User.fromJson(responseData);
      return user;
    } else {
      // Manejar errores y mostrar diálogo en caso de fallo
      return null;
    }
  }
}

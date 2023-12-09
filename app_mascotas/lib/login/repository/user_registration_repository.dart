import 'dart:convert';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserRegistrationRepository  {
  
  final String url = 'http://157.253.45.208:3000/users'; 


  Future<bool> registerUser(BuildContext context, User user) async{  

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(user.toJson()), // Convierte el objeto a JSON
  );

    if (response.statusCode == 201) {
      return true;
    } else {
      String errorMessage = 'Hubo un problema al registrarse. Por favor, inténtalo de nuevo.';
      final dynamic responseData = jsonDecode(response.body);
      if (responseData is Map<String, dynamic> && responseData.containsKey("message")) {
        errorMessage = responseData["message"];
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        ),
      );

      return false;
    }
  }

  Future<void> updateUser(BuildContext context, String userId, User updatedUser) async {
    final response = await http.put(
      Uri.parse('$url/$userId'), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedUser.toJson()),
    );

    if (response.statusCode != 200){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Hubo un problema al actualizar el usuario. Por favor, inténtalo de nuevo.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }

}
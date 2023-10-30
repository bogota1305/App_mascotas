import 'dart:convert';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserRegistrationRepository  {
  
  final String url = 'http://192.168.10.21:3000/users'; 


  Future<void> registerUser(BuildContext context, User user) async{  

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(user.toJson()), // Convierte el objeto a JSON
  );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
     
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Hubo un problema al registrarse. Por favor, inténtalo de nuevo.'),
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
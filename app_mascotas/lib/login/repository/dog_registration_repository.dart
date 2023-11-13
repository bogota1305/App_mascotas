import 'dart:convert';
import 'package:app_mascotas/login/models/dog_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DogRegistrationRepository  {
  
  final String url = 'http://192.168.10.15:3000/dogs'; 


  Future<void> registerDog(BuildContext context, Dog dog) async{  

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(dog.toJson()),
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

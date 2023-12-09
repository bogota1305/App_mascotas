import 'dart:convert';
import 'package:app_mascotas/login/models/dog_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DogRegistrationRepository  {
  
  final String url = 'http://157.253.45.208:3000/dogs'; 


  Future<void> registerDog(BuildContext context, Dog dog) async{  

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(dog.toJson()),
  );

    if (response.statusCode != 201) {
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

  Future<Dog> getDogById(String id) async {
    final response = await http.get(
      Uri.parse('$url/$id'), 
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Dog.fromJson(responseData);
    } else {
      throw Exception('Error al obtener el perro por ID');
    }
  }

}

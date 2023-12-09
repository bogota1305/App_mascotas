import 'dart:convert';
import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccommodationsRegistrationRepository  {
  
  final String url = 'http://157.253.45.208:3000/accommodations'; 


  Future<void> registerAccommodations(BuildContext context, Accommodation accommodation) async{  

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(accommodation.toJson()), // Convierte el objeto a JSON
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

  Future<Accommodation> getAccommodationById(String id) async {
    final response = await http.get(
      Uri.parse('$url/$id'), 
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return Accommodation.fromJson(responseData);
    } else {
      throw Exception('Error al obtener el alojamiento por ID');
    }
  }
}


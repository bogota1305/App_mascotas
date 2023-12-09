import 'dart:convert';
import 'package:app_mascotas/login/models/veterinary_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VeterinaryRegistrationRepository {
  final String url = 'http://157.253.45.208:3000/veterinaries';

  Future<List<Veterinary>> getAllVeterinaries() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((data) => Veterinary.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load veterinaries');
    }
  }

  Future<Veterinary> getVeterinaryById(String id) async {
    final response = await http.get(Uri.parse('$url/$id'));

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      return Veterinary.fromJson(responseData);
    } else {
      throw Exception('Failed to load veterinary');
    }
  }

  Future<bool> createVeterinary(BuildContext context, Veterinary veterinary) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(veterinary.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      String errorMessage = 'Hubo un problema al crear la veterinaria. Por favor, inténtalo de nuevo.';
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

  Future<void> updateVeterinary(BuildContext context, String veterinaryId, Veterinary updatedVeterinary) async {
    final response = await http.put(
      Uri.parse('$url/$veterinaryId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedVeterinary.toJson()),
    );

    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Hubo un problema al actualizar la veterinaria. Por favor, inténtalo de nuevo.'),
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

  Future<void> deleteVeterinary(BuildContext context, String veterinaryId) async {
    final response = await http.delete(Uri.parse('$url/$veterinaryId'));

    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Hubo un problema al eliminar la veterinaria. Por favor, inténtalo de nuevo.'),
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

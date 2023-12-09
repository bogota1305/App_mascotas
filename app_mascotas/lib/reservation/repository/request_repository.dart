import 'dart:convert';
import 'package:app_mascotas/reservation/models/request_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestRepository {
  final String url = 'http://157.253.45.208:3000/requests';

  Future<bool> createRequest(BuildContext context, RequestModel request) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      String errorMessage = 'Hubo un problema al crear la solicitud. Por favor, inténtalo de nuevo.';
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

  Future<List<RequestModel>> getAllRequests() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<RequestModel> requests = responseData.map((data) => RequestModel.fromJson(data)).toList();
      return requests;
    } else {
      return [];
    }
  }

  Future<RequestModel?> getRequestById(String requestId) async {
    final response = await http.get(Uri.parse('$url/$requestId'));

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      final RequestModel request = RequestModel.fromJson(responseData);
      return request;
    } else {
      return null;
    }
  }

  Future<void> updateRequest(BuildContext context, String requestId, RequestModel updatedRequest) async {
    final response = await http.put(
      Uri.parse('$url/$requestId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedRequest.toJson()),
    );

    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Hubo un problema al actualizar la solicitud. Por favor, inténtalo de nuevo.'),
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

  Future<void> deleteRequest(BuildContext context, int requestId) async {
    final response = await http.delete(Uri.parse('$url/$requestId'));

    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Hubo un problema al eliminar la solicitud. Por favor, inténtalo de nuevo.'),
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

  Future<void> removeAllRequests(BuildContext context) async {
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Hubo un problema al eliminar las solicitudes. Por favor, inténtalo de nuevo.'),
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

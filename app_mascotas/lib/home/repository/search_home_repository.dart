import 'dart:convert';
import 'package:app_mascotas/home/model/search_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchHomeRepository {
  final String url = 'http://192.168.10.15:3000/searches'; 

  Future<bool> createSearch(BuildContext context, Search search) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(search.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      String errorMessage = 'Hubo un problema al crear la búsqueda. Por favor, inténtalo de nuevo.';
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

  Future<List<Search>> getAllSearches() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<Search> searches = responseData.map((data) => Search.fromJson(data)).toList();
      return searches;
    } else {
      return [];
    }
  }

  Future<void> updateSearch(BuildContext context, int searchId, Search updatedSearch) async {
    final response = await http.put(
      Uri.parse('$url/$searchId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedSearch.toJson()),
    );

    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Hubo un problema al actualizar la búsqueda. Por favor, inténtalo de nuevo.'),
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

  Future<void> deleteSearch(BuildContext context, int searchId) async {
    final response = await http.delete(Uri.parse('$url/$searchId'));

    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Hubo un problema al eliminar la búsqueda. Por favor, inténtalo de nuevo.'),
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

  Future<void> removeAllSearches(BuildContext context) async {
    final response = await http.delete(Uri.parse('$url'));

    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Hubo un problema al eliminar las búsquedas. Por favor, inténtalo de nuevo.'),
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

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapController {
  final apiKey = 'AIzaSyCW7oQvJj05PXKlLMoZ_3QJHiFSfavbC4c';

  Future<Map<String, dynamic>?> geocodeAddress(String address) async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Error al geocodificar la dirección');
    }
  }

  Future<double> calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$startLatitude,$startLongitude&destinations=$endLatitude,$endLongitude&key=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final distance = data['rows'][0]['elements'][0]['distance']['value'];
      return distance / 1000.0; 
    } else {
      throw Exception('Error al calcular la distancia');
    }
  }

  double getLatitude(dynamic geocodedData){
    final location = geocodedData != null
              ? geocodedData['results'][0]['geometry']['location']
              : '';
    return location['lat'];
  }

  double getLongitude(dynamic geocodedData){
    final location = geocodedData != null
              ? geocodedData['results'][0]['geometry']['location']
              : '';
    return location['lng'];
  }

  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Servicio de ubicación desactivado');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permiso de ubicación denegado');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Permiso de ubicación denegado permanentemente, no se puede solicitar');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(position.latitude, position.longitude);
    
  }
}

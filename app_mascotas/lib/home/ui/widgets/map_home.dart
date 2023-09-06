import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHome extends StatefulWidget {
  @override
  State<MapHome> createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  GoogleMapController? _controller;
  LatLng _currentLocation = LatLng(0.0, 0.0); // Coordenadas iniciales

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Obtener la ubicación actual al iniciar la pantalla
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target:
            _currentLocation, // Usar la ubicación actual como objetivo inicial
        zoom: 14.0, // Cambia el nivel de zoom según tus necesidades
      ),
      onMapCreated: (controller) {
        setState(() {
          _controller = controller;
        });
      },
      markers: Set<Marker>.of([
        Marker(
          markerId: MarkerId('marker_1'),
          position: _currentLocation, // Usar la ubicación actual
          infoWindow: InfoWindow(title: 'Ubicación actual'),
        ),
      ]),
    );
  }
}
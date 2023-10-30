import 'package:app_mascotas/profile/ui/widget/housing/housing_or_request_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHome extends StatefulWidget {
  final LatLng currentLocation;

  const MapHome({super.key, required this.currentLocation});

  @override
  State<MapHome> createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  GoogleMapController? _controller; //Coordenadas iniciales
  Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    //_getCurrentLocation(); // Obtener la ubicación actual al iniciar la pantalla
  }

  // void _getCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   setState(() {
  //     currentLocation = LatLng(position.latitude, position.longitude);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.currentLocation, // Usar la ubicación actual como objetivo inicial
        zoom: 14.0, // Cambia el nivel de zoom según tus necesidades
      ),
      onMapCreated: (controller) {
        _controller = controller;
        addMarker(LatLng(4.604273, -74.065854), 'Cuidador', 'Nombre cuidador', 'Descripción cuidador', 'assets/images/logo/logo_Dug.png');
        addMarker(widget.currentLocation, 'Ubicación actual', 'Ubicación actual', 'Casa de la mascota', '');
      },
      markers: _markers.values.toSet(),
    );
  }
  
  void addMarker(LatLng latLng, String id, String name, String description, String customMarker) async {
    var markerIcon = BitmapDescriptor.defaultMarker;
    if (customMarker.isNotEmpty) {
      markerIcon = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(0.5, 0.5)), customMarker);
    }
    var marker = Marker(
        markerId: MarkerId(id),
        position: latLng, // Usar la ubicación actual
        infoWindow: InfoWindow(title: name),
        icon: markerIcon,
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(),
              //   child: HousingOrRequestCard(
              //     name: 'name',
              //     image: customMarker,
              //     housing: true, 
              //     favorite: false,
              //   ),
              );
            },
          );
        },
    );

    _markers[id] = marker;
    setState(() {});
  }
}
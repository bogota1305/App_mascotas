import 'package:app_mascotas/home/controller/map_controller.dart';
import 'package:app_mascotas/home/controller/search_controller.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/localization_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/profile/ui/widget/housing/housing_or_request_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHome extends StatefulWidget {
  final LatLng currentLocation;
  final List<User> cuidadores;
  final SearchController searchController;
  final MapController mapController;
  final LogedUserController logedUserController;

  const MapHome({
    super.key,
    required this.currentLocation,
    required this.cuidadores,
    required this.searchController, 
    required this.mapController, 
    required this.logedUserController,
  });

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
    // _markers = updateMap();
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.currentLocation,
        zoom: 14.0,
      ),
      onMapCreated: (controller) async {
        _controller = controller;
        addMarker(
          widget.currentLocation,
          'Ubicación actual',
          'Casa de la mascota',
          null,
          '',
          true,
        );
        int i = 1;
        for (User cuidador in widget.cuidadores) {
        
          addMarker(
            LatLng(cuidador.alojamiento?.ubicacion.latitud ?? 0, cuidador.alojamiento?.ubicacion.longitud ?? 0),
            cuidador.id ?? '',
            cuidador.nombre,
            cuidador,
            cuidador.calificacionPromedio >= 4.8
                ? 'assets/images/logo/logo_Dug.png'
                : '',
            false,
          );
          i++;
        }
      },
      markers: _markers.values.toSet(),
    );
  }

  // Map<String, Marker> updateMap() {
  //   Map<String, Marker> updateMarkers = _markers;

  //   _markers.forEach((key, value) {
  //     bool delete = true;
  //     for (User cuidador in widget.cuidadores) {
  //       if(value.markerId.value == cuidador.id || value.markerId.value == 'Ubicación actual'){
  //         delete = false;
  //       }
  //     }
  //     if(delete){
  //       updateMarkers.remove(key);
  //     }
  //   });

  //   return updateMarkers;
  // }

  void addMarker(
    LatLng latLng,
    String id,
    String name,
    User? user,
    String customMarker,
    bool home,
  ) async {
    var markerIcon = home
        ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)
        : BitmapDescriptor.defaultMarker;
    final User cuidador = user ?? widget.logedUserController.createDefaultUser();
    if (customMarker.isNotEmpty) {
      markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(0.5, 0.5)),
        customMarker,
      );
    }
    var marker = Marker(
      markerId: MarkerId(id),
      position: latLng,
      infoWindow: InfoWindow(title: name),
      icon: markerIcon,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // child: SizedBox(),
              child: Visibility(
                visible: user != null,
                child: HousingOrRequestCard(
                  housing: cuidador.tipo == 'Cuidador',
                  favorite: false,
                  alojamiento: cuidador.alojamiento ??
                      Accommodation(
                        photos: [],
                        ubicacion: Localization(
                          ciudad: '',
                          direccion: '',
                          indicacionesEspeciales: '', 
                          latitud: 0, 
                          longitud: 0,
                        ),
                        descripcionEspacio: '',
                        precioPorNoche: 0,
                        precioPorHora: 0,
                        idUser: '',
                        tipoDeServicio: '',
                        diaInicioDisponibilidad: DateTime.now(),
                        diaFinDisponibilidad: DateTime.now(),
                        horaFinDisponibilidad: 0,
                        horaInicioDisponibilidad: 0,
                      ),
                  user: cuidador,
                  tipoReserva: '',
                  perros: [],
                  inicioDiaReserva:
                      widget.searchController.search.fechaDeInicio,
                  finDiaReserva: widget.searchController.search.fechaDeFin,
                  inicioHoraReserva:
                      widget.searchController.search.horaDeInicio,
                  finHoraReserva: widget.searchController.search.horaDeFin, 
                  distancia: cuidador.distancia ?? '', 
                  logedUserController: widget.logedUserController,
                ),
              ),
            );
          },
        );
      },
    );

    _markers[id] = marker;
    setState(() {});
  }
}

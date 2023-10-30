import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/controller/users_list_controller.dart';
import 'package:app_mascotas/home/ui/widgets/map_home.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/profile/ui/widget/housing/housing_or_request_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_switch/flutter_switch.dart';

enum NavigationEvent { home, pet, favorite, message, profile }

class HomeScreen extends StatefulWidget {
  final bool housingUser;
  final bool activeService;

  const HomeScreen(
      {super.key, required this.housingUser, required this.activeService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showMap = false;
  LatLng currentLocation = LatLng(0, 0);
  List<User> cuidadores = [];

  final UsersListController usersListController = UsersListController();

  @override
  void initState() {
    super.initState();
    _getCuidadores();
  }

  Future<void> _getCuidadores() async {
    try {
      final cuidadoresData = await usersListController.getCuidadores();
      setState(() {
        cuidadores = cuidadoresData;
      });
    } catch (e) {
      // Maneja los errores
      print('Error al obtener cuidadores: $e');
    }
  }

  // Función para solicitar permiso de ubicación
  void requestLocationPermission() async {
    var status = await Permission.location.request();

    // Verificar si se concedió el permiso
    if (status.isGranted) {
      // El permiso de ubicación fue concedido, puedes acceder a la ubicación.
      // Aquí puedes iniciar la lógica de acceso a la ubicación.
    } else if (status.isDenied) {
      // El usuario negó el permiso. Puedes mostrar un mensaje explicativo.
    } else if (status.isPermanentlyDenied) {
      // El usuario negó permanentemente el permiso.
      // Puedes mostrar un mensaje y guiar al usuario a la configuración de la aplicación para habilitar el permiso.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Visibility(
            visible: !widget.activeService,
            replacement: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: Text(
                      'Servicio activo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.text.size.xl,
                        color: widget.housingUser
                            ? DugColors.orange
                            : DugColors.blue,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: DugColors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(context.radius.xl)),
                        border: Border.all(
                          color: widget.housingUser
                              ? DugColors.orange
                              : DugColors.blue,
                          width: 2,
                        )),
                    child: Column(
                      children: [
                        Container(
                          height: 390,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(context.radius.xl)),
                                ),
                                child: Image(
                                  image: NetworkImage(
                                    'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 320),
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[
                                        DugColors.black.withOpacity(0.01),
                                        DugColors.black.withOpacity(0.9),
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'David',
                                          style: TextStyle(
                                              color: DugColors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                        InfoItem(
                                          icon: Icons.star,
                                          name: '4.6',
                                          textSize: 25,
                                          textColor: DugColors.white,
                                          colorIcon: DugColors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 163,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: !widget.housingUser,
                                  child: Column(
                                    children: [
                                      InfoItem(
                                        icon: Icons.location_on,
                                        name: 'Calle 123 #4 - 5',
                                        textSize: 18,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                InfoItem(
                                  icon: Icons.date_range,
                                  name: '20 nov - 25 nov',
                                  textSize: 18,
                                  colorIcon: widget.housingUser
                                      ? DugColors.orange
                                      : DugColors.blue,
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: widget.housingUser
                                              ? DugColors.orange
                                              : DugColors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InfoItem(
                                          icon: Icons.message,
                                          name: 'Mensaje',
                                          textSize: 15,
                                          colorIcon: DugColors.white,
                                          textColor: DugColors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: widget.housingUser
                                              ? DugColors.orange
                                              : DugColors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InfoItem(
                                          icon: Icons.phone,
                                          name: 'Llamar',
                                          textSize: 15,
                                          colorIcon: DugColors.white,
                                          textColor: DugColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: widget.housingUser,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                        child: Container(
                                          width: 130,
                                          decoration: BoxDecoration(
                                            color: DugColors.purple,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InfoItem(
                                              icon: Icons.medical_services,
                                              name: 'Veterinaria',
                                              textSize: 15,
                                              colorIcon: DugColors.white,
                                              textColor: DugColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            child: Stack(
              children: [
                IndexedStack(
                  index: showMap ? 1 : 0,
                  children: [
                    HousingOrRequestCardList(
                        widget: widget, cuidadores: cuidadores),
                    Visibility(
                      visible: currentLocation != LatLng(0, 0) &&
                          !widget.housingUser,
                      child: MapHome(
                        currentLocation: currentLocation,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: !widget.housingUser,
                  child: Column(
                    children: [
                      Spacer(),
                      Center(
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: showMap
                                ? DugColors.green
                                : DugColors.greyInactive,
                            borderRadius:
                                BorderRadius.circular(context.radius.xxxl),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: DugColors.black.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlutterSwitch(
                              activeText: "Mapa",
                              inactiveText: "Mapa",
                              value: showMap,
                              valueFontSize: 15.0,
                              width: 85,
                              borderRadius: 30.0,
                              showOnOff: true,
                              inactiveColor: DugColors.greyInactive,
                              activeColor: DugColors.green,
                              activeTextColor: DugColors.white,
                              inactiveTextColor: DugColors.white,
                              onToggle: (val) {
                                if (!showMap) {
                                  _getCurrentLocation();
                                }
                                setState(() {
                                  showMap = val;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _getCurrentLocation() async {
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
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }
}

class HousingOrRequestCardList extends StatelessWidget {
  const HousingOrRequestCardList({
    super.key,
    required this.widget,
    required this.cuidadores,
  });

  final HomeScreen widget;
  final List<User> cuidadores;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Center(
              child: Text(
                widget.housingUser
                    ? 'Solicitudes de alojamiento'
                    : 'Cuidadores Disponibles',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.text.size.xl,
                  color: widget.housingUser ? DugColors.orange : DugColors.blue,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
              visible: cuidadores.isNotEmpty,
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < cuidadores.length; i++) ...{
                    HousingOrRequestCard(
                      name: cuidadores[i].nombre.split(' ').first,
                      image: cuidadores[i].fotos.isNotEmpty
                          ? cuidadores[i].fotos[0]
                          : '',
                      housing: cuidadores[i].tipo == 'Cuidador',
                      favorite: false,
                      location:
                          cuidadores[i].alojamiento?.ubicacion.direccion ?? '',
                      pricePerNight: cuidadores[i]
                              .alojamiento
                              ?.precioPorNoche
                              .toString()
                              .split(".")
                              .first ??
                          '',
                      pricePerHour: cuidadores[i]
                              .alojamiento
                              ?.precioPorHora
                              .toString()
                              .split(".")
                              .first ??
                          '',
                      perros: cuidadores[i].perros ?? [],
                      rating: 0,
                    ),
                  }
                ],
              )),
        ],
      ),
    );
  }
}

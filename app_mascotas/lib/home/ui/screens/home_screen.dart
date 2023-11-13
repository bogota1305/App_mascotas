import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/controller/map_controller.dart';
import 'package:app_mascotas/home/controller/request_housing_users_controller.dart';
import 'package:app_mascotas/home/controller/search_controller.dart';
import 'package:app_mascotas/home/controller/users_list_controller.dart';
import 'package:app_mascotas/home/model/search_model.dart';
import 'package:app_mascotas/home/repository/search_home_repository.dart';
import 'package:app_mascotas/home/repository/user_home_repository.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/home/ui/widgets/map_home.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/dog_model.dart';
import 'package:app_mascotas/login/models/localization_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/profile/ui/widget/housing/housing_or_request_card.dart';
import 'package:app_mascotas/reservation/models/request_controller.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:time_range_picker/time_range_picker.dart';

enum NavigationEvent { home, pet, favorite, message, profile }

class HomeScreen extends StatefulWidget {
  final bool housingUser;
  final SearchController searchController;
  final LogedUserController logedUserController;
  final RequestsHousingUsersController requestsHousingUsersController;

  const HomeScreen({
    super.key,
    required this.housingUser,
    required this.searchController,
    required this.logedUserController,
    required this.requestsHousingUsersController,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool activeSwitch = false;
  bool showMap = false;
  bool showAceptedRequests = false;
  bool showCreatedRequests = false;
  LatLng currentLocation = LatLng(0, 0);
  List<User> listaUsuarios = [];
  List<User> listaUsuariosSolicitudesRecibidas = [];
  List<User> listaUsuariosSolicitudesAceptadas = [];
  List<User> listaCuidadoresDisponibles = [];

  bool cargando = false;
  bool activeService = false;
  User activeServiceUser = User(
    id: 'Guest',
    nombre: 'Guest',
    apellidos: '',
    fotos: [],
    descripcion: '',
    contrasena: '',
    fechaNacimiento: DateTime.now(),
    correo: '',
    tipo: '',
    sexo: '',
    prefijoTelefono: '',
    telefono: '',
    tipoDocumento: '',
    documento: '',
    pais: '',
    fotosDocumento: [],
    calificaciones: [],
    calificacionPromedio: 0,
    solicitudesCreadas: [],
    solicitudesRecibidas: [],
  );
  RequestModel activeRequest = RequestModel(
    estado: '',
    idUsuarioSolicitante: '',
    idUsuarioSolicitado: '',
    tipoDeServicio: '',
    fechaDeInicio: DateTime.now(),
    fechaDeFin: DateTime.now(),
    horaDeInicio: 0,
    horaDeFin: 0,
    idPerros: [],
    idAlojamiento: '',
    precio: 0,
  );

  final UsersListController usersListController = UsersListController();
  final SearchHomeRepository searchHomeRepository = SearchHomeRepository();
  final MapController mapController = MapController();
  final UserHomeRepository userHomeRepository = UserHomeRepository();

  @override
  void initState() {
    super.initState();
    if (widget.housingUser) {
      _getDuenos();
    } else {
      _getCuidadores();
    }
  }

  Future<void> _getCuidadores() async {
    setState(() {
      cargando = true;
      if (activeSwitch) {
        activeSwitch = false;
      }
      if (showMap) {
        showMap = false;
      }
      if (showCreatedRequests) {
        showCreatedRequests = false;
      }
    });

    try {
      List<User> cuidadoresData =
          await usersListController.getCuidadoresDisponibles(
        widget.searchController.search,
        widget.requestsHousingUsersController,
        widget.logedUserController.user,
      );
      cuidadoresData = usersListController.orderCuidadoresByAttribute(
        cuidadoresData,
        widget.searchController.search.ordenamiento,
      );

      listaCuidadoresDisponibles = cuidadoresData;

      for (RequestModel request
          in widget.logedUserController.user.solicitudesCreadas) {
        if (request.estado == 'Aceptada') {
          activeService = isActiveService(request);
          if (activeService) {
            activeServiceUser = await userHomeRepository
                .findUserById(request.idUsuarioSolicitado);
            activeRequest = request;
          }
        }
      }

      setState(() {
        listaUsuarios = listaCuidadoresDisponibles;
      });
    } catch (e) {
      // Maneja los errores
      print('Error al obtener cuidadores: $e');
    }
    setState(() {
      cargando = false;
    });
  }

  Future<void> _getDuenos() async {
    listaUsuariosSolicitudesAceptadas = [];
    setState(() {
      cargando = true;
    });
    if (activeSwitch) {
      setState(() {
        activeSwitch = false;
      });
    }
    try {
      final duenosData = await usersListController.getDuenos(
        widget.logedUserController.user,
      );
      for (User dueno in duenosData) {
        if (dueno.solicitudesCreadas.first.estado == 'Aceptada') {
          activeService = isActiveService(dueno.solicitudesCreadas.first);
          listaUsuariosSolicitudesAceptadas.add(dueno);
          if (activeService) {
            activeServiceUser = dueno;
            activeRequest = dueno.solicitudesCreadas.first;
          }
        }
      }

      listaUsuariosSolicitudesRecibidas =
          await usersListController.getDuenosDisponibles(
        widget.searchController.search,
        widget.logedUserController.user,
        duenosData,
      );

      setState(() {
        listaUsuarios = listaUsuariosSolicitudesRecibidas;
      });
    } catch (e) {
      // Maneja los errores
      print('Error al obtener cuidadores: $e');
    }
    setState(() {
      cargando = false;
    });
  }

  void showAceptedOrReceivedRequests() {
    setState(() {
      if (showAceptedRequests) {
        listaUsuarios = listaUsuariosSolicitudesAceptadas;
      } else {
        listaUsuarios = listaUsuariosSolicitudesRecibidas;
      }
    });
  }

  void showHousingUsersOrCreatedRequests() {
    setState(() {
      if (showCreatedRequests) {
        listaUsuarios = widget.requestsHousingUsersController.users;
      } else {
        listaUsuarios = listaCuidadoresDisponibles;
      }
    });
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
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  bool isActiveService(RequestModel request) {
    if (request.tipoDeServicio == 'Fecha') {
      return DateRange(request.fechaDeInicio, request.fechaDeFin)
          .contains(DateTime.now());
    } else {
      return (request.horaDeInicio <= DateTime.now().hour &&
          request.horaDeFin >= DateTime.now().hour);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Visibility(
            visible: !activeService,
            replacement: ActiveServiceCard(
              widget: widget,
              user: activeServiceUser,
              perro: activeServiceUser.perros?.first ??
                  Dog(
                    nombre: '',
                    fechaNacimiento: DateTime.now(),
                    raza: '',
                    personalidad: '',
                    cuidadosEspeciales: '',
                    sexo: '',
                    idUser: '',
                    photos: [],
                  ),
              servicio: activeRequest,
            ),
            child: Stack(
              children: [
                Visibility(
                  visible: !showMap,
                  replacement: Visibility(
                    visible:
                        currentLocation != LatLng(0, 0) && !widget.housingUser,
                    child: MapHome(
                      currentLocation: currentLocation,
                      cuidadores: listaUsuarios,
                      searchController: widget.searchController,
                      mapController: mapController,
                      logedUserController: widget.logedUserController,
                    ),
                  ),
                  child: HousingOrRequestCardList(
                    housingUser: widget.housingUser,
                    listaUsusarios: listaUsuarios,
                    search: widget.searchController.search,
                    mapController: mapController,
                    cargando: cargando,
                    logedUserController: widget.logedUserController,
                    showAceptedRequests: showAceptedRequests,
                  ),
                ),
                Column(
                  children: [
                    Spacer(),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: !widget.housingUser ? 100 : 140,
                            decoration: BoxDecoration(
                              color: activeSwitch
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
                                activeText:
                                    !widget.housingUser ? "Mapa" : 'Aceptadas',
                                inactiveText:
                                    !widget.housingUser ? "Mapa" : 'Recibidas',
                                value: activeSwitch,
                                valueFontSize: 15.0,
                                width: !widget.housingUser ? 85 : 125,
                                borderRadius: 30.0,
                                showOnOff: true,
                                inactiveColor: DugColors.greyInactive,
                                activeColor: DugColors.green,
                                activeTextColor: DugColors.white,
                                inactiveTextColor: DugColors.white,
                                onToggle: (val) {
                                  if (!widget.housingUser) {
                                    _getCurrentLocation();
                                    showMap = val;
                                  } else {
                                    showAceptedRequests = val;
                                    showAceptedOrReceivedRequests();
                                  }
                                  setState(() {
                                    activeSwitch = val;
                                  });
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.requestsHousingUsersController.users
                                    .isNotEmpty &&
                                !showMap,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  Text(
                                    'Ver solicitudes',
                                    style: TextStyle(
                                      color: DugColors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FlutterSwitch(
                                        activeText: 'Si',
                                        inactiveText: 'No',
                                        value: showCreatedRequests,
                                        valueFontSize: 15.0,
                                        width: 60,
                                        borderRadius: 30.0,
                                        showOnOff: true,
                                        inactiveColor: DugColors.greyInactive,
                                        activeColor: DugColors.green,
                                        activeTextColor: DugColors.white,
                                        inactiveTextColor: DugColors.white,
                                        onToggle: (val) {
                                          setState(() {
                                            showCreatedRequests = val;
                                          });
                                          showHousingUsersOrCreatedRequests();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrincipalButton(
                      onPressed: () {
                        if (widget.housingUser) {
                          _getDuenos();
                        } else {
                          _getCuidadores();
                        }
                      },
                      text: 'Buscar',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ActiveServiceCard extends StatelessWidget {
  final User user;
  final Dog perro;
  final RequestModel servicio;
  const ActiveServiceCard({
    super.key,
    required this.widget,
    required this.user,
    required this.perro,
    required this.servicio,
  });

  final HomeScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Center(
            child: Text(
              'Servicio activo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: context.text.size.xl,
                color: widget.housingUser ? DugColors.orange : DugColors.blue,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
          child: Container(
            decoration: BoxDecoration(
                color: DugColors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(context.radius.xl)),
                border: Border.all(
                  color: widget.housingUser ? DugColors.orange : DugColors.blue,
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.housingUser
                                      ? perro.nombre
                                      : user.nombre,
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
                          icon: servicio.tipoDeServicio == 'Fecha'
                              ? Icons.date_range
                              : Icons.access_time_filled_sharp,
                          name: servicio.tipoDeServicio == 'Fecha'
                              ? '${servicio.fechaDeInicio.day}/${servicio.fechaDeInicio.month} - ${servicio.fechaDeFin.day}/${servicio.fechaDeFin.month}'
                              : '${servicio.horaDeInicio}:00 - ${servicio.horaDeFin}:00 Hoy',
                          textSize: 18,
                          colorIcon: widget.housingUser
                              ? DugColors.orange
                              : DugColors.blue,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: widget.housingUser
                                      ? DugColors.orange
                                      : DugColors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
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
    );
  }
}

class HousingOrRequestCardList extends StatelessWidget {
  HousingOrRequestCardList({
    super.key,
    required this.listaUsusarios,
    required this.search,
    required this.housingUser,
    required this.mapController,
    required this.cargando,
    required this.logedUserController,
    required this.showAceptedRequests, 
  });

  final List<User> listaUsusarios;
  final bool housingUser;
  final Search search;
  final MapController mapController;
  final bool cargando;
  final LogedUserController logedUserController;
  final bool showAceptedRequests;

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
                housingUser
                    ? !showAceptedRequests
                        ? 'Solicitudes de alojamiento'
                        : 'Solicitudes Aceptadas'
                    : 'Cuidadores Disponibles',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.text.size.xl,
                  color: housingUser ? DugColors.orange : DugColors.blue,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: !cargando,
            replacement: Center(
              child: CircularProgressIndicator(),
            ),
            child: Visibility(
              visible: listaUsusarios.isNotEmpty,
              replacement: Padding(
                padding: EdgeInsets.only(top: 200),
                child: Center(
                  child: Text(
                    !housingUser
                        ? 'No se han encontrado cuidadores'
                        : 'No tienes solicitudes',
                    style: TextStyle(
                      fontSize: context.text.size.xl,
                      color: DugColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < listaUsusarios.length; i++) ...{
                    HousingOrRequestCard(
                      user: listaUsusarios[i],
                      alojamiento: listaUsusarios[i].alojamiento ??
                          defaultAccommodation(),
                      housing: listaUsusarios[i].tipo == 'Cuidador',
                      favorite: false,
                      perros: listaUsusarios[i].perros ?? [],
                      tipoReserva: search.tipoDeServicio,
                      inicioDiaReserva: search.fechaDeInicio,
                      finDiaReserva: search.fechaDeFin,
                      inicioHoraReserva: search.horaDeInicio,
                      finHoraReserva: search.horaDeFin,
                      distancia: listaUsusarios[i].distancia ?? '',
                      logedUserController: logedUserController,
                    ),
                  }
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Accommodation defaultAccommodation() {
    return Accommodation(
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
    );
  }
}

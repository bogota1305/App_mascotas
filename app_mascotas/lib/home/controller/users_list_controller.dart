import 'dart:convert';
import 'package:app_mascotas/home/controller/map_controller.dart';
import 'package:app_mascotas/home/controller/request_housing_users_controller.dart';
import 'package:app_mascotas/home/model/search_model.dart';
import 'package:app_mascotas/home/repository/search_home_repository.dart';
import 'package:app_mascotas/home/repository/user_home_repository.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/localization_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/reservation/models/request_controller.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:time_range_picker/time_range_picker.dart';

enum SortOrder { ascending, descending }

class UsersListController {
  SearchHomeRepository searchHomeRepository = SearchHomeRepository();
  MapController mapController = MapController();

  Future<List<User>> getCuidadores(
    RequestsHousingUsersController requestsHousingUsersController,
    User user,
  ) async {
    List<User> usersData = [];
    List<User> cuidadores = [];
    String distancia = '';
    List<RequestModel> solicitudes = [];
    String userId = user.id ?? '${user.pais}${user.documento}';
    final userHomeRepository = UserHomeRepository();
    try {
      usersData = await userHomeRepository.getUsers();
      requestsHousingUsersController.users = [];
      for (User cuidador in usersData) {
        if (cuidador.tipo == 'Cuidador') {
          if (cuidador.alojamiento != null) {
            distancia = await getDistance(
              cuidador.alojamiento ?? defaultAccommodation(),
            );
            if (user.solicitudesCreadas.isNotEmpty) {
              for (RequestModel solicitud in user.solicitudesCreadas) {
                if (solicitud.idUsuarioSolicitado == cuidador.id && solicitud.idUsuarioSolicitante == userId) {
                  solicitudes.add(solicitud);
                  requestsHousingUsersController.users.add(
                    cuidador.copyWith(
                      distancia: distancia,
                      solicitudesRecibidas: solicitudes,
                    ),
                  );
                  solicitudes = [];
                } else {
                  cuidadores.add(
                    cuidador.copyWith(
                      distancia: distancia,
                    ),
                  );
                }
              }
            } else {
              cuidadores.add(
                cuidador.copyWith(
                  distancia: distancia,
                ),
              );
            }
          }
        }
      }
    } catch (e) {
      print('Error al obtener cuidadores: $e');
    }

    return cuidadores;
  }

  Future<List<User>> getDuenos(User user) async {
    List<User> usersData = [];
    List<User> duenos = [];
    final userHomeRepository = UserHomeRepository();
    String idUsuarioSolicitado = user.id ?? '${user.pais}${user.documento}';
    String idUsuarioSolicitante = '';
    List<RequestModel> solicitudes = [];
    try {
      usersData = await userHomeRepository.getUsers();
      for (int i = 0; i < usersData.length; i++) {
        if (usersData[i].tipo == 'Dueno') {
          idUsuarioSolicitante = usersData[i].id ?? '${usersData[i].pais}${usersData[i].documento}';
          for (RequestModel solicitud in user.solicitudesRecibidas) {
            if (solicitud.idUsuarioSolicitado == idUsuarioSolicitado && solicitud.idUsuarioSolicitante == idUsuarioSolicitante) {
              solicitudes.add(solicitud);
              duenos
                  .add(usersData[i].copyWith(solicitudesCreadas: solicitudes));
              solicitudes = [];
            }
          }
        }
      }
    } catch (e) {
      print('Error al obtener cuidadores: $e');
    }

    return duenos;
  }

  Future<List<User>> getCuidadoresDisponibles(
      Search search,
      RequestsHousingUsersController requestsHousingUsersController,
      User user) async {
    final cuidadores =
        await getCuidadores(requestsHousingUsersController, user);

    final cuidadoresDisponibles = cuidadores.where((cuidador) {
      final alojamiento = cuidador.alojamiento;

      if (alojamiento == null) {
        return false;
      }

      if (alojamientoMatchesServiceType(alojamiento, search) &&
          alojamientoMatchesAvailability(alojamiento, search)) {
        return true;
      }
      return false;
    }).toList();

    return cuidadoresDisponibles;
  }

  bool alojamientoMatchesServiceType(Accommodation alojamiento, Search search) {
    final tipoDeServicio = alojamiento.tipoDeServicio;
    return tipoDeServicio == search.tipoDeServicio || tipoDeServicio == 'Ambos';
  }

  bool alojamientoMatchesAvailability(
      Accommodation alojamiento, Search search) {
    if (search.tipoDeServicio == 'Fecha') {
      final disponibilidad = DateRange(
        alojamiento.diaInicioDisponibilidad,
        alojamiento.diaFinDisponibilidad,
      );
      return disponibilidad.contains(search.fechaDeInicio) &&
          disponibilidad.contains(search.fechaDeFin);
    }
    if (search.tipoDeServicio == 'Hora') {
      final horaInicioDisponibilidad = alojamiento.horaInicioDisponibilidad;
      final horaFinDisponibilidad = alojamiento.horaFinDisponibilidad;
      return horaInicioDisponibilidad <= search.horaDeInicio &&
          horaFinDisponibilidad >= search.horaDeFin;
    }
    return false;
  }

  List<User> orderCuidadoresByAttribute(
    List<User> cuidadores,
    String attribute,
  ) {
    SortOrder sortOrder = SortOrder.descending;

    if (attribute == '\$ Noche Bajo' ||
        attribute == '\$ Hora Bajo' ||
        attribute == 'Distancia') {
      sortOrder = SortOrder.ascending;
    }

    cuidadores.sort((a, b) {
      double attributeValueA = 0;
      double attributeValueB = 0;

      if (attribute == 'Calificación') {
        attributeValueA = a.calificacionPromedio;
        attributeValueB = b.calificacionPromedio;
      } else if (attribute == '\$ Noche Bajo' || attribute == '\$ Noche Alto') {
        attributeValueA = a.alojamiento?.precioPorNoche ?? 0;
        attributeValueB = b.alojamiento?.precioPorNoche ?? 0;
      } else if (attribute == '\$ Hora Bajo' || attribute == '\$ Hora Alto') {
        attributeValueA = a.alojamiento?.precioPorHora ?? 0;
        attributeValueB = b.alojamiento?.precioPorHora ?? 0;
      } /* else if (attribute == 'Distancia') {
        attributeValueA = a.alojamiento?.ubicacion.direccion ?? 0;
        attributeValueB = b.alojamiento?.ubicacion.direccion ?? 0;
      }*/
      else if (attribute == '# Perros') {
        attributeValueA = a.perros?.length.toDouble() ?? 0;
        attributeValueB = b.perros?.length.toDouble() ?? 0;
      }

      if (sortOrder == SortOrder.ascending) {
        return attributeValueA.compareTo(attributeValueB);
      } else {
        return attributeValueB.compareTo(attributeValueA);
      }
    });

    return cuidadores;
  }

  Future<String> getDistance(Accommodation alojamiento) async {
    LatLng userLocation = await mapController.getCurrentLocation();
    double distance = await mapController.calculateDistance(
        userLocation.latitude,
        userLocation.longitude,
        alojamiento.ubicacion.latitud,
        alojamiento.ubicacion.longitud);
    String distanceFinal = distance.toStringAsFixed(1);

    return 'A $distanceFinal Km de ti';
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

  Future<List<User>> getDuenosDisponibles(
    Search search,
    User user,
    List<User> duenos,
  ) async {
    final duenosDisponibles = duenos.where((dueno) {
      final solicitud = dueno.solicitudesCreadas.first;

      if (solicitud.estado == 'Creada' &&
          solicitudMatchesAvailability(solicitud, search)) {
        return true;
      }
      return false;
    }).toList();

    return duenosDisponibles;
  }

  bool solicitudMatchesAvailability(
    RequestModel solicitud,
    Search search,
  ) {
    if (search.tipoDeServicio == 'Fecha') {
      final disponibilidad = DateRange(
        solicitud.fechaDeInicio,
        solicitud.fechaDeFin,
      );
      return disponibilidad.contains(search.fechaDeInicio) &&
          disponibilidad.contains(search.fechaDeFin);
    }
    if (search.tipoDeServicio == 'Hora') {
      final horaInicio = solicitud.horaDeInicio;
      final horaFin = solicitud.horaDeFin;
      return horaInicio <= search.horaDeInicio && horaFin >= search.horaDeFin;
    }
    return false;
  }
}

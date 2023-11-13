import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/dog_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/login/repository/user_registration_repository.dart';
import 'package:app_mascotas/reservation/models/request_controller.dart';
import 'package:app_mascotas/reservation/repository/request_repository.dart';
import 'package:app_mascotas/reservation/ui/widgets/reservation_alert_dialog.dart';
import 'package:app_mascotas/reservation/ui/widgets/reservation_error_alert_dialog.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

class RequestReservationButton extends StatelessWidget {
  final LogedUserController logedUserController;
  final User user;
  final Accommodation alojamiento;
  final String tipoReserva;
  final DateTime inicioDiaReserva;
  final DateTime finDiaReserva;
  final int inicioHoraReserva;
  final int finHoraReserva;
  final int number;
  final int price;

  final RequestRepository requestRepository = RequestRepository();
  final UserRegistrationRepository userRegistrationRepository =
      UserRegistrationRepository();

  RequestReservationButton({
    super.key,
    required this.logedUserController,
    required this.user,
    required this.alojamiento,
    required this.tipoReserva,
    required this.inicioDiaReserva,
    required this.finDiaReserva,
    required this.inicioHoraReserva,
    required this.finHoraReserva,
    required this.number,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: DugColors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              context.radius.xxxl,
            ), // Ajusta el valor según desees
          ),
        ),
        onPressed: () {
          String idSolicitante = logedUserController.user.id ??
              '${logedUserController.user.pais}${logedUserController.user.documento}';
          String idSolicitado = user.id ?? '${user.pais}${user.documento}';
          DateTime fechaDeInicio = tipoReserva == 'Fecha'
              ? DateTime(
                  inicioDiaReserva.year,
                  inicioDiaReserva.month,
                  inicioDiaReserva.day,
                )
              : DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                );
          DateTime fechaDeFin = tipoReserva == 'Fecha'
              ? DateTime(
                  finDiaReserva.year,
                  finDiaReserva.month,
                  finDiaReserva.day,
                  23,
                  59,
                  59,
                )
              : DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  23,
                  59,
                  59,
                );
          int horaDeInicio = tipoReserva == 'Fecha' ? 0 : inicioHoraReserva;
          int horaDeFin = tipoReserva == 'Fecha' ? 0 : finHoraReserva;
          List<String> idPerros = [];
          bool solicitudNueva = true;
          String titulo = '';
          String descripcion = '';
          for (Dog perro in logedUserController.user.perros ?? []) {
            idPerros.add(perro.id ?? '');
          }

          RequestModel solicitud = RequestModel(
            estado: 'Creada',
            idUsuarioSolicitante: idSolicitante,
            idUsuarioSolicitado: idSolicitado,
            tipoDeServicio: tipoReserva,
            fechaDeInicio: fechaDeInicio,
            fechaDeFin: fechaDeFin,
            horaDeInicio: horaDeInicio,
            horaDeFin: horaDeFin,
            idPerros: idPerros,
            idAlojamiento: user.alojamiento?.id ?? '',
            precio: (price * number),
          );

          for (RequestModel solicitudCreada in logedUserController.user.solicitudesCreadas) {
            if (solicitudCreada.idUsuarioSolicitado == solicitud.idUsuarioSolicitado) {
              solicitudNueva = false;
              titulo = 'Ya tienes una reserva para este cuidador';
              descripcion = 'No puedes solicitar mas de una reserva para un mismo cuidador, espera a que sea respondida';
            }
            if (solicitudNueva && solicitudCreada.tipoDeServicio == 'Fecha') {
              solicitudNueva = isOutsideDaysRange(
                solicitudCreada.fechaDeInicio,
                solicitudCreada.fechaDeFin,
                solicitud.fechaDeInicio,
                solicitud.fechaDeFin,
              );
              titulo = 'Ya tienes una reserva dentro de estas fechas';
              descripcion = 'No puedes solicitar mas de una reserva para un mismo rango de fechas, espera a que sea respondida';
            }
            if (solicitudNueva && solicitudCreada.tipoDeServicio == 'Hora') {
              solicitudNueva = isOutsideHoursRange(
                solicitudCreada.fechaDeInicio,
                solicitud.fechaDeInicio,
                solicitudCreada.horaDeInicio,
                solicitudCreada.horaDeFin,
                solicitud.horaDeInicio,
                solicitud.horaDeFin,
              );
              titulo = 'Ya tienes una reserva hoy dentro de estas horas';
              descripcion = 'No puedes solicitar mas de una reserva para un mismo rango de horas, espera a que sea respondida';
            }
          }

          if (solicitudNueva) {
            List<RequestModel> solicitudesCreadas =
                logedUserController.user.solicitudesCreadas;
            solicitudesCreadas.add(solicitud);

            List<RequestModel> solicitudesRecibidas = user.solicitudesRecibidas;
            solicitudesRecibidas.add(solicitud);

            requestRepository.createRequest(
              context,
              solicitud,
            );

            logedUserController.user = logedUserController.user.copyWith(solicitudesCreadas: solicitudesCreadas);

            userRegistrationRepository.updateUser(
              context,
              idSolicitante,
              logedUserController.user.copyWith(solicitudesCreadas: solicitudesCreadas),
            );

            userRegistrationRepository.updateUser(
              context,
              idSolicitado,
              user.copyWith(solicitudesRecibidas: solicitudesRecibidas),
            );

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ReservationAlertDialog();
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ReservationErrorAlertDialog(titulo: titulo, descripcion: descripcion,);
              },
            );
          }
        },
        child: Row(
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.spacing.xs),
              child: Text(
                'Solicitar reserva',
                style: TextStyle(
                  fontSize: context.text.size.lg,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer()
          ],
        ));
  }

  bool isOutsideDaysRange(
    DateTime solicitudCreadaInicio,
    DateTime solicitudCreadaFin,
    DateTime solicitudNuevaInicio,
    DateTime solicitudNuevaFin,
  ) {
    bool isOutside = true;
    DateRange rango = DateRange(solicitudCreadaInicio, solicitudCreadaFin);
    if (rango.contains(solicitudNuevaInicio) ||
        rango.contains(solicitudNuevaFin)) {
      isOutside = false;
    }
    return isOutside;
  }

  bool isOutsideHoursRange(
    DateTime existingStartDate,
    DateTime newStartDate,
    int existingStartTime,
    int existingEndTime,
    int newStartTime,
    int newEndTime,
  ) {
    if (existingStartDate != newStartDate) {
      return true;
    }

    bool overlap =
        (newEndTime > existingStartTime && newStartTime < existingEndTime);
    return !overlap;
  }
}

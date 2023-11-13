import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/reservation/models/request_controller.dart';
import 'package:app_mascotas/reservation/ui/screens/resume_reservation_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class HousingResumeReservationCard extends StatelessWidget {
  final User user;
  final Accommodation alojamiento;
  String tipoReserva;
  DateTime inicioDiaReserva;
  DateTime finDiaReserva;
  int inicioHoraReserva;
  int finHoraReserva;
  final LogedUserController logedUserController;

  HousingResumeReservationCard({
    super.key,
    required this.tipoReserva,
    required this.inicioDiaReserva,
    required this.finDiaReserva,
    required this.inicioHoraReserva,
    required this.finHoraReserva,
    required this.logedUserController,
    required this.user,
    required this.alojamiento,
  });

  @override
  Widget build(BuildContext context) {
    RequestModel? solicitud = getRequest();
    return Container(
      height: 105,
      color: DugColors.greyBackground,
      child: Padding(
        padding: EdgeInsets.all(context.spacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tipoReserva == 'Fecha'
                      ? 'Fecha de reserva'
                      : 'Hora de reserva (${DateTime.now().day}/${DateTime.now().month})',
                  style: TextStyle(
                    fontSize: context.text.size.sm,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      tipoReserva == 'Fecha'
                          ? Icons.date_range_rounded
                          : Icons.access_time,
                      color: DugColors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(context.spacing.xxxs),
                      child: Text(
                        tipoReserva == 'Fecha'
                            ? '${inicioDiaReserva.day}/${inicioDiaReserva.month} - ${finDiaReserva.day}/${finDiaReserva.month}'
                            : '$inicioHoraReserva:00 - $finHoraReserva:00',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // InkWell(
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(context.radius.lg),
                    //       ),
                    //       color: DugColors.white,
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsets.symmetric(
                    //           vertical: context.spacing.xxxs,
                    //           horizontal: context.spacing.xs),
                    //       child: Text(
                    //         'Editar',
                    //         style: TextStyle(
                    //           color: DugColors.blue,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
            Spacer(),
            Visibility(
              visible: solicitud == null,
              replacement: Column(
                children: [
                  SizedBox(height: 8,),
                  Text('Estado de la reserva:', style: TextStyle(fontWeight: FontWeight.bold,),),
                  SizedBox(height: 8,),
                  Text('${solicitud?.estado ?? ''}', style: TextStyle(fontWeight: FontWeight.bold, color: DugColors.blue, fontSize: 16),),
                ],
              ), 
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResumeReservationScreen(
                      logedUserController: logedUserController,
                      tipoReserva: tipoReserva,
                      inicioDiaReserva: inicioDiaReserva,
                      finDiaReserva: finDiaReserva,
                      inicioHoraReserva: inicioHoraReserva,
                      finHoraReserva: finHoraReserva,
                      user: user,
                      alojamiento: alojamiento,
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(context.radius.lg),
                    ),
                    color: DugColors.blue,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(context.spacing.sm),
                    child: Text(
                      'Reservar',
                      style: TextStyle(
                        color: DugColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RequestModel? getRequest() {
    RequestModel? solicitud = null;
    String userId = logedUserController.user.id ?? "${logedUserController.user.pais}${logedUserController.user.documento}";
    if (user.solicitudesRecibidas.length == 1 && user.solicitudesRecibidas.first.idUsuarioSolicitante == userId) {
      
      solicitud = user.solicitudesRecibidas.first;

      tipoReserva = solicitud.tipoDeServicio;
      inicioDiaReserva = solicitud.fechaDeInicio;
      finDiaReserva = solicitud.fechaDeFin;
      inicioHoraReserva = solicitud.horaDeInicio;
      finHoraReserva = solicitud.horaDeFin;
    }

    return solicitud;
  }
}

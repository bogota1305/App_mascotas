import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/reservation/repository/request_repository.dart';
import 'package:app_mascotas/reservation/ui/widgets/housing_tipe_card_content.dart';
import 'package:app_mascotas/reservation/ui/widgets/payment_card_content.dart';
import 'package:app_mascotas/reservation/ui/widgets/price_card_content.dart';
import 'package:app_mascotas/reservation/ui/widgets/request_reservation_button.dart';
import 'package:app_mascotas/reservation/ui/widgets/resume_reservation_card.dart';
import 'package:app_mascotas/reservation/ui/widgets/resume_reservation_profile_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class ResumeReservationScreen extends StatelessWidget {
  final LogedUserController logedUserController;
  final User user;
  final Accommodation alojamiento;
  final String tipoReserva;
  final DateTime inicioDiaReserva;
  final DateTime finDiaReserva;
  final int inicioHoraReserva;
  final int finHoraReserva;

  const ResumeReservationScreen({
    super.key,
    required this.logedUserController,
    required this.user,
    required this.alojamiento,
    required this.tipoReserva,
    required this.inicioDiaReserva,
    required this.finDiaReserva,
    required this.inicioHoraReserva,
    required this.finHoraReserva,
  });
  @override
  Widget build(BuildContext context) {
    final int number = getNumber();
    final int price = getPrice();
    final String servicio = getService();
    return Scaffold(
      appBar: AppBar(
        title: AppBarDug(
          homeScreen: false,
          barContent: Text(
            'Resumen de reserva',
            style: TextStyle(
              fontSize: context.text.size.md,
              fontWeight: FontWeight.bold,
            ),
          ),
          logedUserController: logedUserController,
        ),
        backgroundColor: DugColors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.spacing.md),
            ResumeReservationProfileCard(
              user: user,
              alojamiento: alojamiento,
            ),
            SizedBox(height: context.spacing.md),
            ResumeReservationCard(
              child: HousingTipeCardContent(
                tipoReserva: tipoReserva,
                inicioDiaReserva: inicioDiaReserva,
                finDiaReserva: finDiaReserva,
                inicioHoraReserva: inicioHoraReserva,
                finHoraReserva: finHoraReserva,
              ),
            ),
            SizedBox(height: context.spacing.md),
            ResumeReservationCard(
              child: PriceCardContent(
                number: number,
                price: price,
                servicio: servicio,
              ),
            ),
            SizedBox(height: context.spacing.md),
            ResumeReservationCard(
              child: PaymentCardContent(),
            ),
            SizedBox(height: context.spacing.md),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.xxxl),
              child: RequestReservationButton(
                logedUserController: logedUserController,
                tipoReserva: tipoReserva,
                inicioDiaReserva: inicioDiaReserva,
                finDiaReserva: finDiaReserva,
                inicioHoraReserva: inicioHoraReserva,
                finHoraReserva: finHoraReserva,
                user: user,
                alojamiento: alojamiento,
                price: price,
                number: number,
              ),
            ),
            SizedBox(height: context.spacing.md),
          ],
        ),
      ),
    );
  }

  int getNumber() {
    int finalNumber = 0;

    if (tipoReserva == 'Hora') {
      finalNumber = finHoraReserva - inicioHoraReserva;
    } else {
      finalNumber = finDiaReserva.difference(inicioDiaReserva).inDays;
    }

    return finalNumber;
  }

  int getPrice() {
    int finalPrice = 0;

    if (tipoReserva == 'Hora') {
      finalPrice = alojamiento.precioPorHora.toInt();
    } else {
      finalPrice = alojamiento.precioPorNoche.toInt();
    }

    return finalPrice;
  }

  String getService() {
    String finalService = '';

    if (tipoReserva == 'Hora') {
      finalService = 'Hora';
    } else {
      finalService = 'Día';
    }

    return finalService;
  }
}

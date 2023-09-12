import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
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
  @override
  Widget build(BuildContext context) {
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
        ),
        backgroundColor: DugColors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.spacing.md),
            ResumeReservationProfileCard(),
            SizedBox(height: context.spacing.md),
            ResumeReservationCard(
              child: HousingTipeCardContent(),
            ),
            SizedBox(height: context.spacing.md),
            ResumeReservationCard(
              child: PriceCardContent(),
            ),
            SizedBox(height: context.spacing.md),
            ResumeReservationCard(
              child: PaymentCardContent(),
            ),
            SizedBox(height: context.spacing.md),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.xxxl),
              child: RequestReservationButton(),
            ),
            SizedBox(height: context.spacing.md),
          ],
        ),
      ),
    );
  }
}

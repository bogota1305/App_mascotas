import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/reservation/ui/widgets/reservation_alert_dialog.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class RequestReservationButton extends StatelessWidget {
  const RequestReservationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: DugColors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                context.radius.xxxl), // Ajusta el valor según desees
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ReservationAlertDialog();
            },
          );
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
}

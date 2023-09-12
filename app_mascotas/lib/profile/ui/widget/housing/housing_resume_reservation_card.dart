import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/reservation/ui/screens/resume_reservation_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class HousingResumeReservationCard extends StatelessWidget {
  const HousingResumeReservationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  'Hora de reserva (Sep 05)',
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
                      Icons.access_time,
                      color: DugColors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(context.spacing.xxxs),
                      child: Text('14:00 - 19:00'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(context.radius.lg),
                          ),
                          color: DugColors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: context.spacing.xxxs, horizontal: context.spacing.xs),
                          child: Text(
                            'Editar',
                            style: TextStyle(
                              color: DugColors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Spacer(),
            InkWell(
            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => ResumeReservationScreen())),
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
          ],
        ),
      ),
    );
  }
}

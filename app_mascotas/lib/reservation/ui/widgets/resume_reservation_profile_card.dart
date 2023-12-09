import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class ResumeReservationProfileCard extends StatelessWidget {
  final User user;
  final Accommodation alojamiento;

  const ResumeReservationProfileCard({
    super.key,
    required this.user,
    required this.alojamiento,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(context.radius.xxxl),
          ),
          color: DugColors.white,
          border: Border.all(color: DugColors.greyTextCard),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Color de la sombra
              spreadRadius: 2, // Cuán extendida estará la sombra
              blurRadius: 5, // Cuán desenfocada estará la sombra
              offset: const Offset(
                  5, 3), // Offset de la sombra (horizontal, vertical)
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(context.spacing.xl),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                width: 100,
                height: 100,
                child: Image.network(user.fotos.first),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user.nombre,
                        style: TextStyle(
                          fontSize: context.text.size.md,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.star),
                      Text(user.calificacionPromedio.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.location_on, color: DugColors.blue),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 150,
                        child: Text(
                          alojamiento.ubicacion.direccion,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.pets,
                        color: DugColors.blue,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('${user.perros?.length ?? 0} Mascotas en casa'),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

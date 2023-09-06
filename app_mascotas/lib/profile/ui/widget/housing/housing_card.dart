import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class HousingCard extends StatelessWidget {
  const HousingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(context.radius.lg),
          ),
          color: DugColors.white,
          border: Border.all(color: DugColors.greyTextCard),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Color de la sombra
              spreadRadius: 2, // Cuán extendida estará la sombra
              blurRadius: 5, // Cuán desenfocada estará la sombra
              offset: const Offset(5, 3), // Offset de la sombra (horizontal, vertical)
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(context.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Alojamiento',
                    style: TextStyle(
                      fontSize: context.text.size.md,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.star),
                  Text('4.5'),
                ],
              ),
              SizedBox(height: 25,),
              Text(
                'Ubicación',
                style: TextStyle(
                  fontSize: context.text.size.xxs,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: DugColors.blue,
                  ),
                  Text(
                    'Carrera 1 E #19a - 70',
                    style: TextStyle(
                      fontSize: context.text.size.sm,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
              Text(
                'Precios',
                style: TextStyle(
                  fontSize: context.text.size.xxs,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Noche',
                        style: TextStyle(
                          fontSize: context.text.size.xxs,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            color: DugColors.blue,
                          ),
                          Text(
                            '\$40-60 mil ',
                            style: TextStyle(
                              fontSize: context.text.size.sm,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 40,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hora',
                        style: TextStyle(
                          fontSize: context.text.size.xxs,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: DugColors.blue,
                          ),
                          Text(
                            '\$40-60 mil ',
                            style: TextStyle(
                              fontSize: context.text.size.sm,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25,),
              Text(
                'Macotas',
                style: TextStyle(
                  fontSize: context.text.size.xxs,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Propias',
                        style: TextStyle(
                          fontSize: context.text.size.xxs,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Icon(
                            Icons.pets,
                            color: DugColors.blue,
                          ),
                          Text(
                            '1 perro y 1 gato',
                            style: TextStyle(
                              fontSize: context.text.size.sm,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 40,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cuidando',
                        style: TextStyle(
                          fontSize: context.text.size.xxs,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Icon(
                            Icons.pets,
                            color: DugColors.blue,
                          ),
                          Text(
                            '0 perros',
                            style: TextStyle(
                              fontSize: context.text.size.sm,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
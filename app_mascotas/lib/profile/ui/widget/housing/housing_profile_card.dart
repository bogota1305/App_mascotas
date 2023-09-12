import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class HosingProfileCard extends StatelessWidget {
  const HosingProfileCard({
    super.key,
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
              offset: const Offset(5, 3), // Offset de la sombra (horizontal, vertical)
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(context.spacing.xl),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: DugColors.blue,
                height: 175,
                width: 125,
              ),
              SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'David',
                        style: TextStyle(
                          fontSize: context.text.size.md,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Icon(Icons.star),
                      Text('4.5'),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Text('Descripción')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
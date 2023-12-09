import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class HosingProfileCard extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final double rating;

  const HosingProfileCard({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.rating,
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
                5,
                3,
              ), 
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(context.spacing.xl),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 175,
                width: 125,
                child: Image.network(image),
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
                      SizedBox(
                        width: 110,
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: context.text.size.md,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(Icons.star),
                      Text(rating.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(description)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

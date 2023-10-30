import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/profile/ui/widget/housing/housing_or_request_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: context.spacing.sm,
          ),
          // HousingOrRequestCard(
          //   name: 'Item 1',
          //   image:
          //       'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
          //   housing: true,
          //   favorite: true,
          // ),
        ],
      ),
    ));
  }
}

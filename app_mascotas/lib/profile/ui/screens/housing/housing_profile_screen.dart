import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/profile/ui/widget/housing/housing_card.dart';
import 'package:app_mascotas/profile/ui/widget/housing/housing_profile_card.dart';
import 'package:app_mascotas/profile/ui/widget/housing/housing_resume_reservation_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HousingProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarDug(HomeScreen: false,),
        backgroundColor: DugColors.blue,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  items: [
                    Image.network(
                        'https://pics.nuroa.com/casa_en_venta_en_bogota_bosque_de_pinos_4300006692099552305.jpg'),
                    Image.network(
                        'https://pics.nuroa.com/casa_en_venta_en_bogota_bosque_de_pinos_4300006692099552305.jpg'),
                    Image.network(
                        'https://pics.nuroa.com/casa_en_venta_en_bogota_bosque_de_pinos_4300006692099552305.jpg'),
                    Image.network(
                        'https://pics.nuroa.com/casa_en_venta_en_bogota_bosque_de_pinos_4300006692099552305.jpg'),
                  ].map((image) {
                    return Container(
                      color: DugColors.black,
                      height: 50,
                      child: image,
                    );
                  }).toList(),
                  options: CarouselOptions(
                    aspectRatio: 1.3,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 8),
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      // Acción cuando se cambia la página del carrusel
                    },
                  ),
                ),
                SizedBox(height: context.spacing.md),
                HousingCard(),
                SizedBox(height: context.spacing.xl),
                HosingProfileCard(),
                SizedBox(height: 130),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: HousingResumeReservationCard(),
          )
        ],
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(context.radius.xl),
          ),
        ),
        height: 182,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Tu solicitud fue enviada con éxito',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text('Se te notificará cuando sea aceptada'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: DugColors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context
                            .radius.xxxl), // Ajusta el valor según desees
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(context.spacing.xs),
                      child: Text(
                        'Aceptar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.text.size.md,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/screens/principal_screen.dart';
import 'package:app_mascotas/login/ui/screens/selection_user_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:flutter/material.dart';

class PrincipalFuctionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: DugColors.blue, // Cambia este color al que desees
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 100),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dug',
                  style: TextStyle(
                      color: DugColors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Spacer(),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 180),
                  child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(150),
                          topRight: Radius.circular(150),
                        ),
                        color: DugColors.white,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 380),
                  child: Container(
                    height: 300,
                    color: DugColors.white,
                  ),
                ),
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: DugColors.white),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/login/start_dogs.png',
                    width: 320,
                    height: 320,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 350),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tu mejor amigo se',
                          style: TextStyle(
                              color: DugColors.black,
                              fontSize: context.text.size.xxl,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'sentirá como en casa',
                          style: TextStyle(
                              color: DugColors.orange,
                              fontSize: context.text.size.xxl,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: context.spacing.lg,
                        ),
                        Text(
                          'Busca y encuentra alternativas de',
                          style: TextStyle(
                            color: DugColors.greyCard,
                            fontSize: context.text.size.lg,
                          ),
                        ),
                        Text(
                          'alojamiento para tu mascota',
                          style: TextStyle(
                            color: DugColors.greyCard,
                            fontSize: context.text.size.lg,
                          ),
                        ),
                        SizedBox(
                          height: context.spacing.xxxl,
                        ),
                        PrincipalButton(onPressed: () { 
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  SelectionUserScreen(), // La siguiente pantalla
                            ),
                          );
                         }, 
                         text: 'Empezar',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}

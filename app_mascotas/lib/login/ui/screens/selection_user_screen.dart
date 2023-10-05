// Página de inicio
import 'package:app_mascotas/login/ui/screens/user_personal_info_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:flutter/material.dart';

class SelectionUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: DugColors.blue,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 150),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Dug',
                    style: TextStyle(
                        color: DugColors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '¿Qué deseas hacer?',
                    style: TextStyle(
                        color: DugColors.white.withOpacity(0.6),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100.0),
              PrincipalButton(
                onPressed: () {
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         UserPersonalInfoScreen(), // La siguiente pantalla
                  //   ),
                  // );
                },
                text: 'Dueño',
                backgroundColor: DugColors.white,
                textColor: DugColors.blue,
              ),
              const SizedBox(height: 30.0),
              PrincipalButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          UserPersonalInfoScreen(), // La siguiente pantalla
                    ),
                  );
                },
                text: 'Cuidador',
                backgroundColor: DugColors.white,
                textColor: DugColors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

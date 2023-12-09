// Página de inicio
import 'package:app_mascotas/home/ui/screens/principal_screen.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/ui/screens/login_screen.dart';
import 'package:app_mascotas/login/ui/screens/user_personal_info_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:flutter/material.dart';

class SelectionUserScreen extends StatefulWidget {

  final LogedUserController logedUserController;

  const SelectionUserScreen({super.key, required this.logedUserController});

  @override
  State<SelectionUserScreen> createState() => _SelectionUserScreenState();
}

class _SelectionUserScreenState extends State<SelectionUserScreen> {
  bool registration = false;

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
              Visibility(
                visible: registration,
                replacement: Column(
                  children: [
                    PrincipalButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      text: 'Ingresar',
                      backgroundColor: DugColors.white,
                      textColor: DugColors.blue,
                    ),
                    const SizedBox(height: 30.0),
                    PrincipalButton(
                      onPressed: () {
                        setState(() {
                          registration = true;
                        });
                      },
                      text: 'Registrarme',
                      backgroundColor: DugColors.white,
                      textColor: DugColors.blue,
                    ),
                    const SizedBox(height: 30.0),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PrincipalScreen(
                              housingUser: false,
                              logedUserController: widget.logedUserController,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Lo hare luego',
                        style: TextStyle(
                          color: DugColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    PrincipalButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UserPersonalInfoScreen(
                              userTipe: UserTipe.owner,
                              logedUserController: widget.logedUserController, 
                            ), // La siguiente pantalla
                          ),
                        );
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
                            builder: (context) => UserPersonalInfoScreen(
                              userTipe: UserTipe.housing,
                              logedUserController: widget.logedUserController,
                            ), // La siguiente pantalla
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
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:app_mascotas/home/ui/screens/principal_screen.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/ui/screens/principal_functions_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:flutter/material.dart';

class LogoScreen extends StatefulWidget {

  final bool isLogged;

  const LogoScreen({super.key, required this.isLogged});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {

  final LogedUserController logedUserController = LogedUserController();

  @override
  void initState() {
    super.initState();

    // Espera 8 segundos y luego navega a la siguiente pantalla
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => widget.isLogged ? PrincipalScreen(housingUser: false, logedUserController: logedUserController,) : PrincipalFuctionsScreen(logedUserController: logedUserController,), // La siguiente pantalla
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: DugColors.blue, // Cambia este color al que desees
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo/logo_Dug.png',
                width: 150,
                height: 150,
              ),
              Text(
                'Dug',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/screens/principal_screen.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/repository/auth_repository.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:app_mascotas/widgets/textFields/registration_text_box.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key,}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LogedUserController logedUserController = LogedUserController();
  String email = '';
  String password = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthRepository authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 150),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ingresar',
                      style: TextStyle(
                        color: DugColors.blue,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 130.0),
                RegistrationTextBox(
                  title: 'Correo',
                  textBox: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.radius.xxxl),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                RegistrationTextBox(
                  title: 'Contraseña',
                  textBox: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.radius.xxxl),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                PrincipalButton(
                  onPressed: () async {
                    String token = await authRepository.loginUser(context, email, password);
          
                    if (token.isNotEmpty) {
                      logedUserController.user =
                          await authRepository.getUserFromToken(context, token) ??
                              logedUserController.createDefaultUser();
                      logedUserController.token = token;
                    }
          
                    if (logedUserController.user.id != 'Guest') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PrincipalScreen(
                            housingUser:
                                logedUserController.user.tipo == 'Cuidador',
                            logedUserController: logedUserController,
                          ),
                        ),
                      );
                    }
                  },
                  text: 'Ingresar',
                  backgroundColor: DugColors.blue,
                  textColor: DugColors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

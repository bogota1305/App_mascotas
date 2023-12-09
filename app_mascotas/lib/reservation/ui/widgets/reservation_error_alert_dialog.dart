import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/screens/principal_screen.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class ReservationErrorAlertDialog extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final LogedUserController logedUserController;

  const ReservationErrorAlertDialog({
    super.key,
    required this.titulo,
    required this.descripcion, 
    required this.logedUserController,
  });
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
        height: 230,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(descripcion),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PrincipalScreen(
                            housingUser:
                                logedUserController.user.tipo == 'Cuidador',
                            logedUserController: logedUserController,
                          ),
                        ),
                      );
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
                        'Volver',
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

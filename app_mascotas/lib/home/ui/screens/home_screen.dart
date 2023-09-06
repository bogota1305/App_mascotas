import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/widgets/map_home.dart';
import 'package:app_mascotas/profile/ui/widget/housing/housing_or_request_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_switch/flutter_switch.dart';

enum NavigationEvent { home, pet, favorite, message, profile }
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showMap = false;

  @override
  void initState() {
    super.initState();
    requestLocationPermission(); // Solicitar permiso al iniciar la pantalla
  }

  // Función para solicitar permiso de ubicación
  void requestLocationPermission() async {
    var status = await Permission.location.request();

    // Verificar si se concedió el permiso
    if (status.isGranted) {
      // El permiso de ubicación fue concedido, puedes acceder a la ubicación.
      // Aquí puedes iniciar la lógica de acceso a la ubicación.
    } else if (status.isDenied) {
      // El usuario negó el permiso. Puedes mostrar un mensaje explicativo.
    } else if (status.isPermanentlyDenied) {
      // El usuario negó permanentemente el permiso.
      // Puedes mostrar un mensaje y guiar al usuario a la configuración de la aplicación para habilitar el permiso.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              IndexedStack(
                index: showMap ? 1 : 0,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Center(
                            child: Text(
                              'Cuidadores Disponibles',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: context.text.size.xl,
                                color: DugColors.blue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        HousingOrRequestCard(
                          name: 'Item 1',
                          image: 'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                          housing: true,
                          color: DugColors.purple,
                        ),
                        HousingOrRequestCard(
                          name: 'Item 1',
                          image: 'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                          housing: true,
                          color: DugColors.purple,
                        ),
                        HousingOrRequestCard(
                          name: 'Item 1',
                          image: 'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                          housing: true,
                          color: DugColors.purple,
                        ),
                        HousingOrRequestCard(
                          name: 'Item 1',
                          image: 'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                          housing: true,
                          color: DugColors.purple,
                        ),
                        HousingOrRequestCard(
                          name: 'Item 1',
                          image: 'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                          housing: true,
                          color: DugColors.purple,
                        ),
                        HousingOrRequestCard(
                          name: 'Item 1',
                          image: 'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                          housing: true,
                          color: DugColors.purple,
                        ),
                      ],
                    ),
                  ),
                  MapHome(),
                ],
              ),
              Column(
                children: [
                  Spacer(),
                  Center(
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: showMap ? DugColors.green : DugColors.grey300,
                        borderRadius: BorderRadius.circular(context.radius.xxxl),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: DugColors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlutterSwitch(
                          activeText: "Mapa",
                          inactiveText: "Mapa",
                          value: showMap,
                          valueFontSize: 15.0,
                          width: 85,
                          borderRadius: 30.0,
                          showOnOff: true,
                          inactiveColor: DugColors.grey300,
                          activeColor: DugColors.green,
                          activeTextColor: DugColors.white,
                          inactiveTextColor: DugColors.white,
                          onToggle: (val) {
                            setState(() {
                              showMap = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
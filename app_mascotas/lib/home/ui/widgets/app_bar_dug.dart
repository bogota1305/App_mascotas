import 'package:app_mascotas/home/controller/map_controller.dart';
import 'package:app_mascotas/home/model/map_model.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AppBarDug extends StatefulWidget {
  final bool homeScreen;
  final Widget? barContent;
  AppBarDug({
    super.key,
    required this.homeScreen,
    this.barContent,
  });

  @override
  State<AppBarDug> createState() => _AppBarDugState();
}

class _AppBarDugState extends State<AppBarDug> {
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.homeScreen,
      replacement: widget.barContent ?? Container(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Ordenar por:',
                  style: TextStyle(
                      fontSize: context.text.size.sm,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 140,
                decoration: BoxDecoration(
                  color: DugColors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blue,
                      ),
                      value: 'Calificación',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      dropdownColor: DugColors.blue,
                      onChanged: (String? newValue) {},
                      items: <String>[
                        'Calificación',
                        '\$ Noche Bajo',
                        '\$ Noche Alto',
                        '\$ Hora Bajo',
                        '\$ Hora Alto',
                        'Distancia',
                        '# Perros'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  value: 'Fecha',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  dropdownColor: DugColors.blue,
                  onChanged: (String? newValue) {},
                  items: <String>[
                    'Fecha',
                    'Hora',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: DugColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  border: Border.all(
                    color: DugColors.white,
                    width: 1,
                  ),
                ),
                width: 130,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      '05/09 - 06/09',
                      style: TextStyle(
                        fontSize: context.text.size.xs,
                        fontWeight: FontWeight.bold,
                        color: DugColors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          InkWell(
            onTap: () {
              
            },
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                  ),
                  radius: 30,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Perfil',
                  style: TextStyle(
                    fontSize: context.text.size.xs,
                    fontWeight: FontWeight.bold,
                    color: DugColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

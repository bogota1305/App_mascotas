import 'package:app_mascotas/home/controller/map_controller.dart';
import 'package:app_mascotas/home/model/map_model.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AppBarDug extends StatefulWidget {
  final bool HomeScreen;

  AppBarDug({
    super.key,
    required this.HomeScreen,
  });

  @override
  State<AppBarDug> createState() => _AppBarDugState();
}

class _AppBarDugState extends State<AppBarDug> {
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.HomeScreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ordenar por:',
            style: TextStyle(
                fontSize: context.text.size.sm, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
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
              SizedBox(
                width: 15,
              ),
              Container(
                width: 90,
                decoration: BoxDecoration(
                  color: DugColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                  border: Border.all(
                    color: DugColors.white,
                    width: 1,
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
                      value: 'Fecha',
                      style: TextStyle(
                        color: Colors.blue,
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
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: DugColors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  border: Border.all(
                    color: DugColors.white,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      '05/09 - 06/09',
                      style: TextStyle(
                          fontSize: context.text.size.xs,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

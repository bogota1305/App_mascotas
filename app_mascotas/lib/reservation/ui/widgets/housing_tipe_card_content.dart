import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class HousingTipeCardContent extends StatelessWidget {
  final String tipoReserva;
  final DateTime inicioDiaReserva;
  final DateTime finDiaReserva;
  final int inicioHoraReserva;
  final int finHoraReserva;

  const HousingTipeCardContent({
    super.key,
    required this.tipoReserva,
    required this.inicioDiaReserva,
    required this.finDiaReserva,
    required this.inicioHoraReserva,
    required this.finHoraReserva,
  });

  @override
  Widget build(BuildContext context) {
    String serviceRange = getServiceRange();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tipo de estadia: $tipoReserva',
          style: TextStyle(
            fontSize: context.text.size.md,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: context.spacing.md,
        ),
        Row(
          children: [
            Icon(tipoReserva == 'Hora' ? Icons.access_time_outlined : Icons.date_range_rounded, color: DugColors.blue),
            SizedBox(
              width: context.spacing.xxxs,
            ),
            Text(serviceRange),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(context.radius.lg),
                ),
                color: DugColors.blue,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.spacing.xxs,
                    horizontal: context.spacing.sm),
                child: Text(
                  'Editar',
                  style: TextStyle(
                    color: DugColors.white,
                    fontSize: context.text.size.xxs,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  String getServiceRange() {
    String service = '';
    if(tipoReserva == 'Hora'){
      service = '$inicioHoraReserva:00 - $finHoraReserva:00 ${DateTime.now().day}/${DateTime.now().month}';
    } else {
      service = '${inicioDiaReserva.day}/${inicioDiaReserva.month} - ${finDiaReserva.day}/${finDiaReserva.month}';
    }
    return service;
  }
}

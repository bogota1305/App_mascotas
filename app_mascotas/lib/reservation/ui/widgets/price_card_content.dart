import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class PriceCardContent extends StatelessWidget {
  const PriceCardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Precio total',
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
            Text('Hora'),
            Spacer(),
            Text('\$ 10.000'),
          ],
        ),
        SizedBox(
          height: context.spacing.sm,
        ),
        Row(
          children: [
            Text('Total horas'),
            Spacer(),
            Text('x5'),
          ],
        ),
        SizedBox(
          height: context.spacing.sm,
        ),
        Row(
          children: [
            Text('Servicio especiales'),
            Spacer(),
            Text('\$ 0.00'),
          ],
        ),
        SizedBox(
          height: context.spacing.xl,
        ),
        Row(
          children: [
            Text(
              'Total (COP)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              '\$ 50.000',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
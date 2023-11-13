import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class PriceCardContent extends StatelessWidget {
  final int number;
  final int price;
  final String servicio;
  const PriceCardContent({
    super.key, 
    required this.number, 
    required this.price, 
    required this.servicio,
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
            Text(servicio),
            Spacer(),
            Text('\$ $price'),
          ],
        ),
        SizedBox(
          height: context.spacing.sm,
        ),
        Row(
          children: [
            Text('Total ${servicio}s'),
            Spacer(),
            Text(number.toString()),
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
              '\$ ${number*price}',
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
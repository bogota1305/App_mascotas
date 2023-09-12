import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class PaymentCardContent extends StatelessWidget {
  const PaymentCardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Metodo de pago',
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
            Icon(Icons.credit_card, color: DugColors.blue),
            SizedBox(
              width: context.spacing.xxxs,
            ),
            Text('....1234'),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(context.radius.lg),
                ),
                color: DugColors.blue,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: context.spacing.xxs, horizontal: context.spacing.sm),
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
}
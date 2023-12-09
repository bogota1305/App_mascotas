import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/reservation/ui/widgets/resume_reservation_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final LogedUserController logedUserController;

  const PaymentMethodsScreen({super.key, required this.logedUserController});
  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  bool pet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarDug(
          homeScreen: false,
          barContent: Text(
            'Metodos de pago',
            style: TextStyle(
              fontSize: context.text.size.md,
              fontWeight: FontWeight.bold,
            ),
          ), 
          logedUserController: widget.logedUserController,
        ),
        backgroundColor: DugColors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.spacing.xxl),
            ResumeReservationCard(
              child: GuestProfilePaymentCardContent(),
            ),
            SizedBox(height: context.spacing.xxl),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.xxxl),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: DugColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        context.radius.xxxl), // Ajusta el valor según desees
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.spacing.xs),
                      child: Text(
                        'Guardar',
                        style: TextStyle(
                          fontSize: context.text.size.lg,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GuestProfilePaymentCardContent extends StatelessWidget {
  const GuestProfilePaymentCardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Metodos de pago',
              style: TextStyle(
                fontSize: context.text.size.md,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.spacing.xs,
        ),
        Row(
          children: [
            Spacer(),
            Text(
              'Elegir predeterminado',
            ),
          ],
        ),
        SizedBox(
          height: context.spacing.xs,
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
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: DugColors.greyCard),
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                      color: DugColors.blue, shape: BoxShape.circle),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: context.spacing.xs,
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
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: DugColors.greyCard),
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: context.spacing.xs,
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
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: DugColors.greyCard),
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: context.spacing.xs,
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
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: DugColors.greyCard),
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: context.spacing.xs,
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
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: DugColors.greyCard),
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: context.spacing.md,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: DugColors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    context.radius.xxxl,
                  ),
                ),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: context.spacing.xs,
                        bottom: context.spacing.xs,
                        right: context.spacing.xxxs),
                    child: Icon(
                      Icons.delete,
                      color: DugColors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: context.spacing.xs),
                    child: Text(
                      'Eliminar',
                      style: TextStyle(
                        fontSize: context.text.size.sm,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: context.spacing.xl,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: DugColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    context.radius.xxxl,
                  ), // Ajusta el valor según desees
                ),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: context.spacing.xs,
                      bottom: context.spacing.xs,
                      right: context.spacing.xxxs,
                    ),
                    child: Icon(
                      Icons.add_circle,
                      color: DugColors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: context.spacing.xs),
                    child: Text(
                      'Agregar',
                      style: TextStyle(
                        fontSize: context.text.size.sm,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

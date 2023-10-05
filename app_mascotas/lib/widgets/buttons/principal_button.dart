import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class PrincipalButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  const PrincipalButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xxl),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? DugColors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                context.radius.xxxl), // Ajusta el valor según desees
          ),
        ),
        onPressed: () {
          onPressed();
        },
        child: Row(
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.spacing.xs),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: context.text.size.lg,
                  fontWeight: FontWeight.bold,
                  color: textColor ?? DugColors.white,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

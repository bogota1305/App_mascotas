import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class NavigationsButton extends StatelessWidget {
  const NavigationsButton({super.key, required this.icon, required this.text, required this.selected});

  final IconData icon;
  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: selected,
      replacement: Icon(
        icon,
        size: 30,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(context.radius.xxxl)),
          color: DugColors.orangeLight,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: DugColors.orange,
              ),
              SizedBox(
                width: context.spacing.xxxs,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: context.text.size.sm,
                  fontWeight: FontWeight.bold,
                  color: DugColors.orange,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {
  const SelectionButton({
    super.key,
    required this.actiavte, 
    required this.text, 
    this.icon,
  });

  final bool actiavte;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(context.radius.xxxl),
        ),
        color: actiavte ? DugColors.white : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  color: actiavte ? DugColors.black : DugColors.white,
                ),
              ),
              SizedBox(width: context.spacing.xxxs,),
              Visibility(
                visible: icon != null,
                child: Icon(
                  icon,
                  color: actiavte ? DugColors.black : DugColors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

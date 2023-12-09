import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/widgets/navigation_button.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:flutter/material.dart';

class NavigationsButtonsBar extends StatelessWidget {
  const NavigationsButtonsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(context.radius.xxxl), topRight: Radius.circular(context.radius.xxxl)),
        color: DugColors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: DugColors.black.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            NavigationsButton(icon: Icons.home_outlined, text: 'Home', selected: false,),
            NavigationsButton(icon: Icons.pets_outlined, text: 'Pet', selected: false,),
            NavigationsButton(icon: Icons.settings_outlined, text: 'Configuration', selected: true,),
          ],
        ),
      ),
    );
  }
}

import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/widgets/selection_button.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:flutter/material.dart';

class SelectionBannerButtons extends StatelessWidget {

  final bool search;

  const SelectionBannerButtons({
    super.key, 
    required this.search,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(context.radius.xxxl),
          ),
          border: Border.all(color: DugColors.blue),
          color: DugColors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectionButton(
                actiavte: !search, 
                text: 'Cuidadores Recomendados',
              ),
              SelectionButton(
                actiavte: search, 
                text: 'Buscar', 
                icon: Icons.search,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


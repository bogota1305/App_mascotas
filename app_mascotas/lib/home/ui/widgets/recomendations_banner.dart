import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:flutter/material.dart';

class RecomendationsBanner extends StatelessWidget {
  final bool recomendations;

  const RecomendationsBanner({
    super.key,
    required this.recomendations,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(context.radius.xxxl),
          ),
          color: DugColors.grey350,
        ),
        child: Column(
          children: const [
            InkWell(
              child: Icon(
                Icons.keyboard_arrow_up,
                size: 35,
              ),
            ),
            
          ]
        ),
      ),
    );
  }
}

import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class PetBanner extends StatelessWidget {
  const PetBanner({super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(context.radius.xxxl),),
          border: Border.all(color: DugColors.blue),
          color: DugColors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: DugColors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hola Max',
                    style: TextStyle(
                      fontSize: context.text.size.xxl,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      width: 160,
                      height: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(context.radius.xxxl),),
                        border: Border.all(color: DugColors.blue),
                        color:DugColors.blue,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: DugColors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '2',
                            style: TextStyle(
                              color: DugColors.white,
                            ),
                          )
                        ),
                      ),
                      SizedBox(width: context.spacing.xs,),
                      const Text('Nombre del nivel'),
                    ],
                  ),
                  SizedBox(height: context.spacing.xs,),
                  Container(
                    width: 160,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(context.radius.xxxl),),
                      border: Border.all(color: DugColors.blue),
                      color:DugColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only( right: 50),
                      child: Container(
                        width: 100,
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(context.radius.xxxl),),
                          color:DugColors.blue,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  'assets/images/home/image_example.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

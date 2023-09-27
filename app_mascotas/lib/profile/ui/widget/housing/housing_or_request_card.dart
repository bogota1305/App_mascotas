import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/profile/ui/screens/housing/housing_profile_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class HousingOrRequestCard extends StatelessWidget {
  final String name;
  final String image;
  final bool housing;
  final Color color;
  final bool favorite;

  const HousingOrRequestCard({
    super.key,
    required this.name,
    required this.image,
    required this.housing,
    required this.color, required this.favorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.spacing.xs),
      child: InkWell(
        onTap: () => housing
            ? Navigator.push(context,
                MaterialPageRoute(builder: (context) => HousingProfileScreen()))
            : Navigator.pushNamed(context, '/request'),
        child: Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(context.radius.lg),
              ),
              color: favorite ? DugColors.orange : color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Color de la sombra
                  spreadRadius: 2, // Cuán extendida estará la sombra
                  blurRadius: 5, // Cuán desenfocada estará la sombra
                  offset: const Offset(
                      5, 3), // Offset de la sombra (horizontal, vertical)
                ),
              ],
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(image),
                                  radius: 40,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: context.spacing.xxxs,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(context.radius.sm)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    color: DugColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(context.radius.md),
                        ),
                        border: Border.all(color: favorite ? DugColors.orange : color, width: 2),
                        color: DugColors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          context.spacing.xs,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '5.2 km de Kanicat',
                                  style: TextStyle(
                                      color: DugColors.greyTextCard,
                                      fontWeight: FontWeight.bold,
                                      fontSize: context.text.size.sm),
                                ),
                                SizedBox(
                                  width: 22,
                                ),
                                const InfoItem(
                                  icon: Icons.star,
                                  name: '4.8',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.spacing.xs,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: context.spacing.xs,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Noche',
                                      style: TextStyle(
                                          color: DugColors.greyTextCard,
                                          fontSize: context.text.size.xxs),
                                    ),
                                    const InfoItem(
                                      icon: Icons.mode_night,
                                      name: '\$40 - 60 mil',
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: context.spacing.xs,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hora',
                                      style: TextStyle(
                                        color: DugColors.greyTextCard,
                                        fontSize: context.text.size.xxs,
                                      ),
                                    ),
                                    const InfoItem(
                                      icon: Icons.access_time_filled,
                                      name: '\$10 mil',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.spacing.xs,
                            ),
                            Row(
                              children: [
                                const InfoItem(
                                  icon: Icons.pets,
                                  name: '2',
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Mascotas en casa',
                                  style: TextStyle(
                                    color: DugColors.greyTextCard,
                                    fontSize: context.text.size.xxs,
                                  ),
                                ),
                                SizedBox(
                                  width: context.spacing.xxxl,
                                ),
                                Visibility(
                                  visible: favorite,
                                  child: Icon(
                                    Icons.favorite,
                                    color: DugColors.orange
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String name;

  const InfoItem({
    super.key,
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: DugColors.blue,
        ),
        SizedBox(
          width: context.spacing.xxxs,
        ),
        Text(
          name,
          style: TextStyle(
              color: DugColors.greyTextCard, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

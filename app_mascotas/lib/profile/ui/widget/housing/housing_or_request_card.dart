import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/login/models/dod_model.dart';
import 'package:app_mascotas/profile/ui/screens/guest/guest_profile_screen.dart';
import 'package:app_mascotas/profile/ui/screens/housing/housing_profile_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class HousingOrRequestCard extends StatefulWidget {
  final String name;
  final String image;
  final bool housing;
  final bool favorite;
  final String? petName;
  final String? petImage;
  final String location;
  final String pricePerNight;
  final String pricePerHour;
  final List<Dog> perros;
  final double rating;

  HousingOrRequestCard({
    super.key,
    required this.name,
    required this.image,
    required this.housing,
    required this.favorite,
    this.petName,
    this.petImage,
    required this.location,
    required this.pricePerNight,
    required this.pricePerHour,
    required this.perros,
    required this.rating,
  });

  @override
  State<HousingOrRequestCard> createState() => _HousingOrRequestCardState();
}

class _HousingOrRequestCardState extends State<HousingOrRequestCard> {
  bool petView = true;

  @override
  Widget build(BuildContext context) {
    final Color color = getCardColor();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.spacing.xs),
      child: InkWell(
        onTap: () => widget.housing
            ? Navigator.push(context,
                MaterialPageRoute(builder: (context) => HousingProfileScreen()))
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GuestProfileScreen(
                    ownProfile: false,
                  ),
                ),
              ),
        child: Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(context.radius.lg),
              ),
              color: widget.favorite ? DugColors.orange : color,
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
                    if (widget.housing) ...{
                      PhotoImageCard(
                        image: widget.image,
                        name: widget.name,
                        housing: true,
                      ),
                      Spacer(),
                      ContainerInfoHousingCard(
                        favorite: widget.favorite,
                        color: color,
                        location: widget.location,
                        pricePerNight: widget.pricePerNight,
                        pricePerHour: widget.pricePerHour,
                        perros: widget.perros,
                        rating: widget.rating,
                      )
                    } else ...{
                      if (petView) ...{
                        ContainerInfoRequestPetCard(
                          favorite: widget.favorite,
                          color: color,
                        ),
                        Spacer(),
                        PhotoImageCard(
                          image: widget.petImage ?? '',
                          name: widget.petName ?? '',
                          housing: false,
                        ),
                      } else ...{
                        PhotoImageCard(
                          image: widget.image,
                          name: widget.name,
                          housing: false,
                        ),
                        Spacer(),
                        ContainerInfoRequestCard(
                          favorite: widget.favorite,
                          color: color,
                        ),
                      }
                    }
                  ],
                ),
                Visibility(
                  visible: !widget.housing,
                  child: Padding(
                    padding: EdgeInsets.only(left: petView ? 10 : 160, top: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          petView = !petView;
                        });
                      },
                      child: Row(
                        children: [
                          InfoItem(
                            icon: petView
                                ? Icons.arrow_circle_right
                                : Icons.arrow_circle_left,
                            name: petView ? "usuario" : "mascota",
                            colorIcon:
                                petView ? DugColors.purple : DugColors.green,
                            button: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Color getCardColor() {
    if (widget.favorite) {
      return DugColors.orange.withOpacity(0.6);
    }
    if (!widget.housing) {
      if (petView) {
        return DugColors.green.withOpacity(0.6);
      }
      return DugColors.purple.withOpacity(0.6);
    }
    return DugColors.blue.withOpacity(0.6);
  }
}

class PhotoImageCard extends StatelessWidget {
  const PhotoImageCard({
    super.key,
    required this.image,
    required this.name,
    required this.housing,
    this.petName,
    this.petImage,
  });

  final String image;
  final String name;
  final bool housing;
  final String? petName;
  final String? petImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: housing ? 18 : 28),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: 40,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: context.spacing.xxxs,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(context.radius.sm)),
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ContainerInfoHousingCard extends StatelessWidget {
  const ContainerInfoHousingCard({
    super.key,
    required this.favorite,
    required this.color,
    required this.location,
    required this.pricePerNight,
    required this.pricePerHour,
    required this.perros,
    required this.rating,
  });

  final bool favorite;
  final Color color;
  final String location;
  final String pricePerNight;
  final String pricePerHour;
  final List<Dog> perros;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(context.radius.md),
        ),
        border:
            Border.all(color: favorite ? DugColors.orange : color, width: 2),
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
                Container(
                  width: 140,
                  child: Text(
                    location,
                    style: TextStyle(
                      color: DugColors.greyTextCard,
                      fontWeight: FontWeight.bold,
                      fontSize: context.text.size.sm,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 22,
                ),
                InfoItem(
                  icon: Icons.star,
                  name: rating.toString(),
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
                        fontSize: context.text.size.xxs,
                      ),
                    ),
                    InfoItem(
                      icon: Icons.mode_night,
                      name: "\$${pricePerNight}",
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
                    InfoItem(
                      icon: Icons.access_time_filled,
                      name: "\$${pricePerHour}",
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
                InfoItem(
                  icon: Icons.pets,
                  name: perros.length.toString(),
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
                  child: Icon(Icons.favorite, color: DugColors.orange),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ContainerInfoRequestPetCard extends StatelessWidget {
  const ContainerInfoRequestPetCard({
    super.key,
    required this.favorite,
    required this.color,
  });

  final bool favorite;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(context.radius.md),
        ),
        border:
            Border.all(color: favorite ? DugColors.orange : color, width: 2),
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
              children: const [
                SizedBox(
                  width: 140,
                ),
                InfoItem(
                  icon: Icons.star,
                  name: '4.8',
                  colorIcon: DugColors.green,
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
                const InfoItem(
                  icon: Icons.pets,
                  name: 'Labrador',
                  colorIcon: DugColors.green,
                ),
                SizedBox(
                  width: context.spacing.xl,
                ),
                const InfoItem(
                  icon: Icons.cake,
                  name: '3 años',
                  colorIcon: DugColors.green,
                ),
              ],
            ),
            SizedBox(
              height: context.spacing.xs,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personalidad',
                      style: TextStyle(
                          color: DugColors.greyTextCard,
                          fontSize: context.text.size.xxs),
                    ),
                    const InfoItem(
                      icon: Icons.emoji_emotions,
                      name: 'Nervioso, jugueton',
                      colorIcon: DugColors.green,
                    ),
                  ],
                ),
                SizedBox(
                  width: context.spacing.xxxl,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ContainerInfoRequestCard extends StatelessWidget {
  const ContainerInfoRequestCard({
    super.key,
    required this.favorite,
    required this.color,
  });

  final bool favorite;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(context.radius.md),
        ),
        border:
            Border.all(color: favorite ? DugColors.orange : color, width: 2),
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
              children: const [
                SizedBox(
                  width: 140,
                ),
                InfoItem(
                  icon: Icons.star,
                  name: '4.8',
                  colorIcon: DugColors.purple,
                ),
              ],
            ),
            SizedBox(
              height: context.spacing.xs,
            ),
            SizedBox(
              width: 195,
              height: 75,
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                overflow: TextOverflow.clip,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final Color? colorIcon;
  final bool? button;
  final double? textSize;
  final Color? textColor;

  const InfoItem({
    super.key,
    required this.icon,
    required this.name,
    this.colorIcon,
    this.button, 
    this.textSize, 
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    bool isButton = button ?? false;
    return Row(
      children: [
        Icon(
          icon,
          color: colorIcon ?? DugColors.blue,
        ),
        SizedBox(
          width: context.spacing.xxxs,
        ),
        Text(
          name,
          style: TextStyle(
            color: textColor ?? DugColors.greyTextCard,
            fontWeight: isButton ? FontWeight.normal : FontWeight.bold,
            fontSize: textSize ?? 14
          ),
        )
      ],
    );
  }
}

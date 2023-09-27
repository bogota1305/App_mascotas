import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/messages/ui/screens/chat_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: context.spacing.sm,
        ),
        MessageCard(
          active: true,
        ),
        MessageCard(
          active: false,
        ),
      ],
    ));
  }
}

class MessageCard extends StatelessWidget {
  final bool active;

  const MessageCard({
    super.key,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: context.spacing.xs, horizontal: context.spacing.md),
      child: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatScreen())),
        child: Container(
            height: 105,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(context.radius.lg),
              ),
              border: Border.all(
                  color: active ? DugColors.blue : DugColors.greyInactive,
                  width: 2),
              color: DugColors.white,
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                              ),
                              radius: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(context.radius.lg),
                        ),
                        color: DugColors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          context.spacing.xs,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'David',
                                  style: TextStyle(
                                      color: active
                                          ? DugColors.blue
                                          : DugColors.greyInactive,
                                      fontSize: context.text.size.md,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    const InfoItem(
                                      icon: Icons.date_range,
                                      name: '22 Sep - 25 Sep',
                                    ),
                                    SizedBox(
                                      height: context.spacing.xxs,
                                    ),
                                    const InfoItem(
                                      icon: Icons.location_pin,
                                      name: 'Calle 123 #4 - 5',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.spacing.sm,
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur',
                              style: TextStyle(
                                color: active
                                    ? DugColors.black
                                    : DugColors.greyInactive,
                                fontSize: context.text.size.xs,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
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
          color: DugColors.greyCard,
          size: context.text.size.sm,
        ),
        SizedBox(
          width: context.spacing.xxxs,
        ),
        Text(
          name,
          style: TextStyle(
              color: DugColors.greyCard, fontSize: context.text.size.xxs),
        )
      ],
    );
  }
}

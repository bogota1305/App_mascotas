import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/profile/ui/screens/guest/payment_methods_screen.dart';
import 'package:app_mascotas/reservation/ui/widgets/housing_tipe_card_content.dart';
import 'package:app_mascotas/reservation/ui/widgets/payment_card_content.dart';
import 'package:app_mascotas/reservation/ui/widgets/price_card_content.dart';
import 'package:app_mascotas/reservation/ui/widgets/request_reservation_button.dart';
import 'package:app_mascotas/reservation/ui/widgets/resume_reservation_card.dart';
import 'package:app_mascotas/reservation/ui/widgets/resume_reservation_profile_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class GuestProfileScreen extends StatefulWidget {
  @override
  State<GuestProfileScreen> createState() => _GuestProfileScreenState();
}

class _GuestProfileScreenState extends State<GuestProfileScreen> {
  bool pet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarDug(
          homeScreen: false,
          barContent: Text(
            'Perfil',
            style: TextStyle(
              fontSize: context.text.size.md,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: DugColors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.spacing.xxl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      pet = false;
                      setState(() {});
                    },
                    child: ProfileCircleCard(
                      pet: pet,
                      image:
                          'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                      isUser: true,
                      name: 'Juan Diego',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      pet = true;
                      setState(() {});
                    },
                    child: ProfileCircleCard(
                      pet: pet,
                      image:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Labrador_Retriever_%281210559%29.jpg/1200px-Labrador_Retriever_%281210559%29.jpg',
                      isUser: false,
                      name: 'Max',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.spacing.md),
            Visibility(
              visible: !pet,
              replacement: PetProfileContent(),
              child: GuestProfileContent(),
            ),
            SizedBox(height: context.spacing.md),
          ],
        ),
      ),
    );
  }
}

class GuestProfileContent extends StatelessWidget {
  const GuestProfileContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResumeReservationCard(
          child: ProfileRatingCardContent(
            pet: false,
            rating: '4.8',
          ),
        ),
        SizedBox(height: context.spacing.md),
        ResumeReservationCard(
          child: GuestProfileLocationCardContent(),
        ),
        SizedBox(height: context.spacing.md),
        ResumeReservationCard(
          child: GuestProfilePaymentCardContent(),
        ),
        SizedBox(height: context.spacing.md),
        ResumeReservationCard(
          child: GuestProfileInfoCardContent(),
        ),
        SizedBox(height: context.spacing.md),
        ResumeReservationCard(
          child: GuestProfileDescriptionCardContent(pet: false),
        ),
      ],
    );
  }
}

class PetProfileContent extends StatelessWidget {
  const PetProfileContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResumeReservationCard(
          child: ProfileRatingCardContent(
            pet: true,
            rating: '4.5',
          ),
        ),
        SizedBox(height: context.spacing.md),
        ResumeReservationCard(
          child: PetProfileInfoCardContent(),
        ),
        SizedBox(height: context.spacing.md),
        ResumeReservationCard(
          child: GuestProfileDescriptionCardContent(pet: true),
        ),
      ],
    );
  }
}

class ProfileCircleCard extends StatelessWidget {
  const ProfileCircleCard({
    super.key,
    required this.pet,
    required this.isUser,
    required this.name,
    required this.image,
  });

  final bool pet;
  final bool isUser;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    bool petActive = isUser ? pet : !pet;
    Color activeColor = isUser ? DugColors.blue : DugColors.green;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: !petActive ? activeColor : DugColors.greyCard,
                width: 5,
              ),
              shape: BoxShape.circle),
          child: Stack(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  image,
                ),
                radius: petActive ? 45 : 60,
              ),
              Visibility(
                visible: petActive,
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: DugColors.greyCard.withOpacity(0.8),
                      shape: BoxShape.circle),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: context.spacing.sm,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: context.text.size.lg,
            fontWeight: FontWeight.bold,
            color: !petActive ? DugColors.black : DugColors.greyCard,
          ),
        ),
        SizedBox(
          height: context.spacing.xxs,
        ),
        Text(
          isUser ? 'Dueño' : 'Mascota',
          style: TextStyle(
              fontSize: context.text.size.xs,
              color: !petActive ? DugColors.black : DugColors.greyCard),
        ),
      ],
    );
  }
}

class ProfileRatingCardContent extends StatelessWidget {
  final bool pet;
  final String rating;

  const ProfileRatingCardContent({
    super.key,
    required this.pet,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star,
                color: pet ? DugColors.green : DugColors.blue, size: 40),
            Text(
              rating,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    Text('20 ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Reseñas'),
                  ],
                ),
                SizedBox(
                  height: context.spacing.xxs,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(context.radius.lg),
                    ),
                    color: pet ? DugColors.green : DugColors.blue,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: context.spacing.xxxs,
                        horizontal: context.spacing.sm),
                    child: Text(
                      'Ver reseñas',
                      style: TextStyle(
                        color: DugColors.white,
                        fontSize: context.text.size.xxs,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class GuestProfileLocationCardContent extends StatelessWidget {
  const GuestProfileLocationCardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Ubicación preterminada',
              style: TextStyle(
                fontSize: context.text.size.md,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(context.radius.lg),
                ),
                color: DugColors.blue,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.spacing.xxs,
                    horizontal: context.spacing.sm),
                child: Text(
                  'Editar',
                  style: TextStyle(
                    color: DugColors.white,
                    fontSize: context.text.size.xxs,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.spacing.lg,
        ),
        Center(
          child: GuestProfileLocationToggleButtons(),
        ),
        SizedBox(
          height: context.spacing.lg,
        ),
        Row(
          children: [
            Text('Dirección:', style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            Text('Calle 123 #4 - 5'),
          ],
        ),
        SizedBox(
          height: context.spacing.xs,
        ),
        Row(
          children: [
            Text('Cercania:', style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            Text('5 kilometros'),
          ],
        ),
      ],
    );
  }
}

class GuestProfileLocationToggleButtons extends StatefulWidget {
  @override
  GuestProfileLocationToggleButtonsState createState() =>
      GuestProfileLocationToggleButtonsState();
}

class GuestProfileLocationToggleButtonsState
    extends State<GuestProfileLocationToggleButtons> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: [
        ToggleButton('Casa'),
        ToggleButton('Veterinaria'),
      ],
      isSelected: isSelected,
      onPressed: (int index) {
        setState(() {
          isSelected[index] = !isSelected[index];
          isSelected[1 - index] = !isSelected[1 - index];
        });
      },
      borderRadius: BorderRadius.circular(30.0),
      selectedColor: DugColors.white,
      fillColor: DugColors.blue,
      borderColor: DugColors.blue,
      borderWidth: 2.0,
      selectedBorderColor: DugColors.blue,
    );
  }
}

class ToggleButton extends StatelessWidget {
  final String text;

  ToggleButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 20,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.text.size.sm,
          ),
        ),
      ),
    );
  }
}

class GuestProfilePaymentCardContent extends StatelessWidget {
  const GuestProfilePaymentCardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Metodos de pago',
              style: TextStyle(
                fontSize: context.text.size.md,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => PaymentMethodsScreen()));
            },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(context.radius.lg),
                  ),
                  color: DugColors.blue,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: context.spacing.xxs,
                      horizontal: context.spacing.sm),
                  child: Text(
                    'Editar',
                    style: TextStyle(
                      color: DugColors.white,
                      fontSize: context.text.size.xxs,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.spacing.lg,
        ),
        Row(
          children: [
            Icon(Icons.credit_card, color: DugColors.blue),
            SizedBox(
              width: context.spacing.xxxs,
            ),
            Text('....1234'),
            Spacer(),
            Text(
              'Predeterminado',
            ),
          ],
        ),
      ],
    );
  }
}

class GuestProfileInfoCardContent extends StatelessWidget {
  const GuestProfileInfoCardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Información',
              style: TextStyle(
                fontSize: context.text.size.md,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(context.radius.lg),
                ),
                color: DugColors.blue,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.spacing.xxs,
                    horizontal: context.spacing.sm),
                child: Text(
                  'Editar',
                  style: TextStyle(
                    color: DugColors.white,
                    fontSize: context.text.size.xxs,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.spacing.lg,
        ),
        Row(
          children: [
            Text('Correo:', style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            Text('correo@gmail.com'),
          ],
        ),
        SizedBox(
          height: context.spacing.xs,
        ),
        Row(
          children: [
            Text('Celular:', style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            Text('+57 3216540987'),
          ],
        ),
      ],
    );
  }
}

class GuestProfileDescriptionCardContent extends StatelessWidget {
  final bool pet;

  const GuestProfileDescriptionCardContent({
    super.key,
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Descripción',
              style: TextStyle(
                fontSize: context.text.size.md,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(context.radius.lg),
                ),
                color: pet ? DugColors.green : DugColors.blue,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.spacing.xxs,
                    horizontal: context.spacing.sm),
                child: Text(
                  'Editar',
                  style: TextStyle(
                    color: DugColors.white,
                    fontSize: context.text.size.xxs,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.spacing.lg,
        ),
        Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
      ],
    );
  }
}

class PetProfileInfoCardContent extends StatelessWidget {
  const PetProfileInfoCardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Información',
              style: TextStyle(
                fontSize: context.text.size.md,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(context.radius.lg),
                ),
                color: DugColors.green,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.spacing.xxs,
                    horizontal: context.spacing.sm),
                child: Text(
                  'Editar',
                  style: TextStyle(
                    color: DugColors.white,
                    fontSize: context.text.size.xxs,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.spacing.lg,
        ),
        Text('Raza:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: context.spacing.xs,
        ),
        Text('Labrador'),
        SizedBox(
          height: context.spacing.sm,
        ),
        Text('Comportamiento:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: context.spacing.xs,
        ),
        Text('Respetuoso, Energico '),
        SizedBox(
          height: context.spacing.sm,
        ),
        Text('Cuidados especiales:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: context.spacing.xs,
        ),
        Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
      ],
    );
  }
}

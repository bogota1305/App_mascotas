import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/dog_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/login/repository/user_registration_repository.dart';
import 'package:app_mascotas/profile/ui/widget/housing/housing_card.dart';
import 'package:app_mascotas/profile/ui/widget/housing/housing_profile_card.dart';
import 'package:app_mascotas/profile/ui/widget/housing/housing_resume_reservation_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HousingProfileScreen extends StatefulWidget {
  final User user;
  final Accommodation alojamiento;
  final List<Dog> perros;
  final String tipoReserva;
  final DateTime inicioDiaReserva;
  final DateTime finDiaReserva;
  final int inicioHoraReserva;
  final int finHoraReserva;
  final LogedUserController logedUserController;
  bool? favorito;

  HousingProfileScreen({
    super.key,
    required this.user,
    required this.alojamiento,
    required this.perros,
    required this.tipoReserva,
    required this.inicioDiaReserva,
    required this.finDiaReserva,
    required this.inicioHoraReserva,
    required this.finHoraReserva,
    required this.logedUserController,
    this.favorito,
  });

  @override
  State<HousingProfileScreen> createState() => _HousingProfileScreenState();
}

class _HousingProfileScreenState extends State<HousingProfileScreen> {
  final UserRegistrationRepository userRegistrationRepository =
      UserRegistrationRepository();

  @override
  Widget build(BuildContext context) {
    List<String> cuidadoresFavoritos =
        widget.logedUserController.user.cuidadoresFavoritos;
    if (widget.favorito == null) {
      widget.favorito = isFavorite();
    }
    return Scaffold(
      appBar: AppBar(
        title: AppBarDug(
          homeScreen: false,
          barContent: Row(
            children: [
              Text(
                'Perfil del cuidador',
                style: TextStyle(
                  fontSize: context.text.size.md,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Visibility(
                visible: widget.logedUserController.user.id != 'Guest',
                child: IconButton(
                  onPressed: () {
                    String idCuidador = widget.user.id ??
                        '${widget.user.pais}${widget.user.documento}';
                    String idUser = widget.logedUserController.user.id ??
                        '${widget.logedUserController.user.pais}${widget.logedUserController.user.documento}';

                    if (widget.favorito ?? false) {
                      cuidadoresFavoritos.remove(idCuidador);
                      widget.favorito = false;
                    } else {
                      cuidadoresFavoritos.add(idCuidador);
                      widget.favorito = true;
                    }

                    User userUpdated = widget.logedUserController.user
                        .copyWith(cuidadoresFavoritos: cuidadoresFavoritos);
                    userRegistrationRepository.updateUser(
                        context, idUser, userUpdated);
                    widget.logedUserController.user = userUpdated;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: (widget.favorito ?? false)
                        ? DugColors.orange
                        : DugColors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  color: DugColors.white,
                ),
              )
            ],
          ),
          logedUserController: widget.logedUserController,
        ),
        backgroundColor: DugColors.blue,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: CarouselSlider(
                    items: widget.alojamiento.photos.map((imageUrl) {
                      return Container(
                        color: DugColors.black,
                        height: 50,
                        child: Image.network(imageUrl),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      aspectRatio: 1.3,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 8),
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        // Acción cuando se cambia la página del carrusel
                      },
                    ),
                  ),
                ),
                SizedBox(height: context.spacing.md),
                HousingCard(
                  location: widget.alojamiento.ubicacion.direccion,
                  pricePerNight:
                      widget.alojamiento.precioPorNoche.toInt().toString(),
                  pricePerHour:
                      widget.alojamiento.precioPorHora.toInt().toString(),
                  ownDogs: widget.perros.length,
                  housingDogs: 0,
                ),
                SizedBox(height: context.spacing.xl),
                HosingProfileCard(
                  image: widget.user.fotos.isNotEmpty
                      ? widget.user.fotos.first
                      : '',
                  name: widget.user.nombre,
                  description: widget.user.descripcion,
                  rating: widget.user.calificacionPromedio,
                ),
                SizedBox(
                    height: widget.tipoReserva != '' &&
                            widget.logedUserController.user.id != 'Guest'
                        ? 130
                        : 20),
              ],
            ),
          ),
          Visibility(
            visible: widget.tipoReserva != '' &&
                widget.logedUserController.user.id != 'Guest',
            child: Align(
              alignment: Alignment.bottomCenter,
              child: HousingResumeReservationCard(
                tipoReserva: widget.tipoReserva,
                inicioDiaReserva: widget.inicioDiaReserva,
                finDiaReserva: widget.finDiaReserva,
                inicioHoraReserva: widget.inicioHoraReserva,
                finHoraReserva: widget.finHoraReserva,
                logedUserController: widget.logedUserController,
                user: widget.user,
                alojamiento: widget.alojamiento,
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isFavorite() {
    bool favorito = false;
    List<String> listaDeFavoritos =
        widget.logedUserController.user.cuidadoresFavoritos;
    String idCuidador =
        widget.user.id ?? '${widget.user.pais}${widget.user.documento}';

    for (String idFavorito in listaDeFavoritos) {
      if (idFavorito == idCuidador) {
        favorito = true;
      }
    }

    return favorito;
  }
}

class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(context.radius.xl),
          ),
        ),
        height: 182,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Tu solicitud fue enviada con éxito',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text('Se te notificará cuando sea aceptada'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: DugColors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context
                            .radius.xxxl), // Ajusta el valor según desees
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(context.spacing.xs),
                      child: Text(
                        'Aceptar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.text.size.md,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

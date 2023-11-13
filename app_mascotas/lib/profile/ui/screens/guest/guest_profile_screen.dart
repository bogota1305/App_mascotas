import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/controller/map_controller.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/dog_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/login/repository/user_registration_repository.dart';
import 'package:app_mascotas/profile/ui/screens/guest/payment_methods_screen.dart';
import 'package:app_mascotas/reservation/models/request_controller.dart';
import 'package:app_mascotas/reservation/repository/request_repository.dart';
import 'package:app_mascotas/reservation/ui/widgets/resume_reservation_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GuestProfileScreen extends StatefulWidget {
  final bool ownProfile;
  final int? numberOfpets;
  final LogedUserController logedUserController;
  final User? userRequest;

  const GuestProfileScreen({
    super.key,
    required this.ownProfile,
    this.numberOfpets,
    required this.logedUserController,
    this.userRequest,
  });

  @override
  State<GuestProfileScreen> createState() => _GuestProfileScreenState();
}

class _GuestProfileScreenState extends State<GuestProfileScreen> {
  bool pet = false;
  int actualPet = 0;
  int numberOfpets = 1;
  final MapController mapController = MapController();
  final UserRegistrationRepository userRegistrationRepository = UserRegistrationRepository();
  final RequestRepository requestRepository = RequestRepository();

  @override
  Widget build(BuildContext context) {
    numberOfpets = widget.numberOfpets ?? 1;
    User user = widget.logedUserController.user;
    RequestModel request = RequestModel(
      estado: '',
      idUsuarioSolicitante: '',
      idUsuarioSolicitado: '',
      tipoDeServicio: '',
      fechaDeInicio: DateTime.now(),
      fechaDeFin: DateTime.now(),
      horaDeInicio: 0,
      horaDeFin: 0,
      idPerros: [],
      idAlojamiento: '',
      precio: 0,
    );
    String inicio = '';
    String fin = '';
    String duracion = '';

    if (!widget.ownProfile) {
      user = widget.userRequest ?? widget.logedUserController.createDefaultUser();
      request = user.solicitudesCreadas.first;
      if (request.tipoDeServicio == 'Fecha') {
        inicio = '${request.fechaDeInicio.day}/${request.fechaDeInicio.month}';
        fin = '${request.fechaDeFin.day}/${request.fechaDeFin.month}';
        duracion =
            ' (Días: ${request.fechaDeFin.difference(request.fechaDeInicio).inDays})';
      } else {
        inicio = '${request.horaDeInicio}:00';
        fin = '${request.horaDeFin}:00';
        duracion = ' (Horas: ${request.horaDeFin - request.horaDeInicio}) Hoy';
      }
    }

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
          logedUserController: widget.logedUserController,
        ),
        backgroundColor: pet ? DugColors.green : DugColors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.spacing.xxl),
            Visibility(
                visible: !widget.ownProfile,
                child: Padding(
                  padding: EdgeInsets.only(bottom: context.spacing.sm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tipo:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: context.text.size.sm,
                        ),
                      ),
                      Icon(
                        Icons.nightlight,
                        color: DugColors.purple,
                      ),
                      Text(
                        request.tipoDeServicio,
                        style: TextStyle(fontSize: context.text.size.sm),
                      )
                    ],
                  ),
                )),
            Visibility(
                visible: !widget.ownProfile,
                child: Padding(
                  padding: EdgeInsets.only(bottom: context.spacing.sm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        inicio,
                        style: TextStyle(fontSize: context.text.size.sm),
                      ),
                      Text(
                        " - ",
                        style: TextStyle(fontSize: context.text.size.sm),
                      ),
                      Text(
                        fin,
                        style: TextStyle(fontSize: context.text.size.sm),
                      ),
                      Text(
                        duracion,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.text.size.sm),
                      ),
                    ],
                  ),
                )),
            Visibility(
                visible: !widget.ownProfile,
                child: Padding(
                  padding: EdgeInsets.only(bottom: context.spacing.sm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.text.size.sm),
                      ),
                      Text(
                        " \$${request.precio}",
                        style: TextStyle(fontSize: context.text.size.sm),
                      )
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Row(
                mainAxisAlignment: (user.perros?.isNotEmpty ?? false)
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
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
                      name: user.nombre,
                      ownProfile: widget.ownProfile,
                    ),
                  ),
                  Visibility(
                    visible: user.perros?.isNotEmpty ?? false,
                    child: Stack(
                      children: [
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
                            name: user.perros?[actualPet].nombre ?? '',
                            ownProfile: widget.ownProfile,
                          ),
                        ),
                        Visibility(
                          visible: numberOfpets > 1 && pet,
                          child: InkWell(
                            onTap: () {
                              if (actualPet > 1) {
                                actualPet--;
                              } else {
                                actualPet = numberOfpets;
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 155),
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: DugColors.green,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: numberOfpets > 1 && pet,
                          child: InkWell(
                            onTap: () {
                              if (actualPet < numberOfpets) {
                                actualPet++;
                              } else {
                                actualPet = 1;
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 155, left: 100),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: DugColors.green,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: numberOfpets > 1 && pet,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 80),
                            child: Container(
                              decoration: BoxDecoration(
                                color: DugColors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  '${actualPet + 1}/${numberOfpets.toString()}',
                                  style: TextStyle(
                                    fontSize: context.text.size.xs,
                                    fontWeight: FontWeight.bold,
                                    color: DugColors.white,
                                  ),
                                ),
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
            SizedBox(height: context.spacing.md),
            Visibility(
              visible: !pet,
              replacement: PetProfileContent(
                ownProfile: widget.ownProfile,
                user: user,
                dog: user.perros?[actualPet] ??
                    Dog(
                      nombre: '',
                      fechaNacimiento: DateTime.now(),
                      raza: '',
                      personalidad: '',
                      cuidadosEspeciales: '',
                      sexo: '',
                      idUser: '',
                      photos: [],
                    ),
              ),
              child: GuestProfileContent(
                ownProfile: widget.ownProfile,
                user: user,
                logedUserController: widget.logedUserController,
              ),
            ),
            SizedBox(height: context.spacing.md),
            Visibility(
              visible: !widget.ownProfile && request.estado == 'Creada',
              child: PrincipalButton(
                onPressed: () {

                  List<RequestModel> solicitudesRecibidas = widget.logedUserController.user.solicitudesRecibidas;
                  solicitudesRecibidas.remove(request);

                  List<RequestModel> solicitudesCreadas = user.solicitudesCreadas;
                  solicitudesCreadas.remove(request);

                  request = request.copyWith(estado: 'Aceptada');

                  solicitudesRecibidas.add(request);
                  solicitudesCreadas.add(request);


                  requestRepository.updateRequest(context, request.id ?? 0, request);

                  userRegistrationRepository.updateUser(context, widget.logedUserController.user.id ?? '', widget.logedUserController.user.copyWith(solicitudesRecibidas: solicitudesRecibidas));
                  userRegistrationRepository.updateUser(context, user.id ?? '', user.copyWith(solicitudesCreadas: solicitudesCreadas));

                },
                text: 'Aceptar solicitud',
              ),
            ),
            SizedBox(height: context.spacing.xs),
            Visibility(
              visible: !widget.ownProfile && request.estado == 'Creada',
              child: PrincipalButton(
                onPressed: () {

                  List<RequestModel> solicitudesRecibidas = widget.logedUserController.user.solicitudesRecibidas;
                  solicitudesRecibidas.remove(request);

                  List<RequestModel> solicitudesCreadas = user.solicitudesCreadas;
                  solicitudesCreadas.remove(request);

                  request = request.copyWith(estado: 'Rechazada');

                  solicitudesCreadas.add(request);

                  requestRepository.updateRequest(context, request.id ?? 0, request);

                  userRegistrationRepository.updateUser(context, widget.logedUserController.user.id ?? '', widget.logedUserController.user.copyWith(solicitudesRecibidas: solicitudesRecibidas));
                  userRegistrationRepository.updateUser(context, user.id ?? '', user.copyWith(solicitudesCreadas: solicitudesCreadas));

                },
                text: 'Rechazar solicitud',
                backgroundColor: DugColors.orange,
              ),
            ),
            SizedBox(height: context.spacing.md),
          ],
        ),
      ),
    );
  }
}

class GuestProfileContent extends StatelessWidget {
  final bool ownProfile;
  final User user;
  final LogedUserController logedUserController;

  const GuestProfileContent({
    super.key,
    required this.ownProfile,
    required this.user,
    required this.logedUserController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResumeReservationCard(
          child: ProfileRatingCardContent(
            pet: false,
            ownProfile: ownProfile,
            user: user,
          ),
        ),
        SizedBox(height: context.spacing.md),
        ResumeReservationCard(
          child: PhotosCarousel(
              image1:
                  'https://pics.nuroa.com/casa_en_venta_en_bogota_bosque_de_pinos_4300006692099552305.jpg',
              image2:
                  'https://pics.nuroa.com/casa_en_venta_en_bogota_bosque_de_pinos_4300006692099552305.jpg',
              image3:
                  'https://pics.nuroa.com/casa_en_venta_en_bogota_bosque_de_pinos_4300006692099552305.jpg',
              image4:
                  'https://pics.nuroa.com/casa_en_venta_en_bogota_bosque_de_pinos_4300006692099552305.jpg'),
        ),
        SizedBox(height: context.spacing.md),
        Visibility(
          visible: ownProfile,
          child: Column(
            children: [
              ResumeReservationCard(
                child: GuestProfileLocationCardContent(
                  user: user,
                ),
              ),
              SizedBox(height: context.spacing.md),
              ResumeReservationCard(
                child: GuestProfilePaymentCardContent(
                  logedUserController: logedUserController,
                ),
              ),
              SizedBox(height: context.spacing.md),
              ResumeReservationCard(
                child: GuestProfileInfoCardContent(
                  user: user,
                ),
              ),
              SizedBox(height: context.spacing.md),
            ],
          ),
        ),
        ResumeReservationCard(
          child: GuestProfileDescriptionCardContent(
            pet: false,
            ownProfile: ownProfile,
            user: user,
          ),
        ),
      ],
    );
  }
}

class PhotosCarousel extends StatelessWidget {
  final String image1;
  final String image2;
  final String image3;
  final String image4;

  const PhotosCarousel({
    super.key,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Image.network(image1),
        Image.network(image2),
        Image.network(image3),
        Image.network(image4),
      ].map((image) {
        return Container(
          height: 50,
          child: image,
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
    );
  }
}

class PetProfileContent extends StatelessWidget {
  final bool ownProfile;
  final User user;
  final Dog dog;

  const PetProfileContent({
    super.key,
    required this.ownProfile,
    required this.user,
    required this.dog,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResumeReservationCard(
          child: ProfileRatingCardContent(
            pet: true,
            ownProfile: ownProfile,
            user: user,
          ),
        ),
        SizedBox(height: context.spacing.md),
        ResumeReservationCard(
          child: PhotosCarousel(
              image1:
                  'https://pics.nuroa.com/casa_en_venta_en_bogota_bosque_de_pinos_4300006692099552305.jpg',
              image2:
                  'https://pics.nuroa.com/casa_en_venta_en_bogota_bosque_de_pinos_4300006692099552305.jpg',
              image3:
                  'https://pics.nuroa.com/casa_en_venta_en_bogota_bosque_de_pinos_4300006692099552305.jpg',
              image4:
                  'https://pics.nuroa.com/casa_en_venta_en_bogota_bosque_de_pinos_4300006692099552305.jpg'),
        ),
        SizedBox(height: context.spacing.md),
        ResumeReservationCard(
          child: PetProfileInfoCardContent(
            ownProfile: ownProfile,
            dog: dog,
          ),
        ),
        SizedBox(height: context.spacing.md),
        ResumeReservationCard(
          child: GuestProfileDescriptionCardContent(
            pet: true,
            ownProfile: ownProfile,
            user: user,
          ),
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
    required this.ownProfile,
  });

  final bool pet;
  final bool isUser;
  final String name;
  final String image;
  final bool ownProfile;

  @override
  Widget build(BuildContext context) {
    bool petActive = isUser ? pet : !pet;
    Color activeColor = pet ? DugColors.green : DugColors.purple;

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
  final bool ownProfile;
  final User user;

  const ProfileRatingCardContent({
    super.key,
    required this.pet,
    required this.ownProfile,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.star,
              color: pet ? DugColors.green : DugColors.purple,
              size: 40,
            ),
            Text(
              '${user.calificacionPromedio}',
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
                    Text('${user.calificaciones.length} ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                    color: pet ? DugColors.green : DugColors.purple,
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
  final User user;
  GuestProfileLocationCardContent({
    super.key,
    required this.user,
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
                color: DugColors.purple,
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
            Container(
              width: 150,
              child: Text(
                '${user.alojamiento?.ubicacion.direccion ?? ''}',
              ),
            ),
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
      fillColor: DugColors.purple,
      borderColor: DugColors.purple,
      borderWidth: 2.0,
      selectedBorderColor: DugColors.purple,
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
  final LogedUserController logedUserController;
  const GuestProfilePaymentCardContent({
    super.key,
    required this.logedUserController,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentMethodsScreen(
                      logedUserController: logedUserController,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(context.radius.lg),
                  ),
                  color: DugColors.purple,
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
            Icon(Icons.credit_card, color: DugColors.purple),
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
  final User user;
  const GuestProfileInfoCardContent({
    super.key,
    required this.user,
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
                color: DugColors.purple,
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
            Text(user.correo),
          ],
        ),
        SizedBox(
          height: context.spacing.xs,
        ),
        Row(
          children: [
            Text('Celular:', style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            Text(user.telefono),
          ],
        ),
      ],
    );
  }
}

class GuestProfileDescriptionCardContent extends StatelessWidget {
  final bool pet;
  final bool ownProfile;
  final User user;
  final Dog? dog;

  const GuestProfileDescriptionCardContent({
    super.key,
    required this.pet,
    required this.ownProfile,
    required this.user,
    this.dog,
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
            Visibility(
              visible: ownProfile,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(context.radius.lg),
                  ),
                  color: pet ? DugColors.green : DugColors.purple,
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
        Text(pet ? dog?.personalidad ?? '' : user.descripcion),
      ],
    );
  }
}

class PetProfileInfoCardContent extends StatelessWidget {
  final bool ownProfile;
  final Dog dog;

  const PetProfileInfoCardContent({
    super.key,
    required this.ownProfile,
    required this.dog,
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
            Visibility(
              visible: ownProfile,
              child: Container(
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
            ),
          ],
        ),
        SizedBox(
          height: context.spacing.lg,
        ),
        Text(
          'Raza:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: context.spacing.xs,
        ),
        Text(dog.raza),
        SizedBox(
          height: context.spacing.sm,
        ),
        Text(
          'Comportamiento:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: context.spacing.xs,
        ),
        Text(dog.personalidad),
        SizedBox(
          height: context.spacing.sm,
        ),
        Text(
          'Cuidados especiales:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: context.spacing.xs,
        ),
        Text(dog.cuidadosEspeciales),
      ],
    );
  }
}

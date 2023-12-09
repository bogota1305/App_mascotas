import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/controller/map_controller.dart';
import 'package:app_mascotas/home/ui/screens/principal_screen.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/dog_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/login/repository/auth_repository.dart';
import 'package:app_mascotas/login/repository/user_registration_repository.dart';
import 'package:app_mascotas/login/ui/screens/selection_user_screen.dart';
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
  final UserRegistrationRepository userRegistrationRepository =
      UserRegistrationRepository();
  final RequestRepository requestRepository = RequestRepository();
  final AuthRepository authRepository = AuthRepository();

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
      user =
          widget.userRequest ?? widget.logedUserController.createDefaultUser();
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

    List<Dog> perros = user.perros ?? [];

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
                          fontSize: context.text.size.sm,
                        ),
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
                mainAxisAlignment: (perros.isNotEmpty)
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
                      image: user.fotos.first,
                      isUser: true,
                      name: user.nombre,
                      ownProfile: widget.ownProfile,
                    ),
                  ),
                  Visibility(
                    visible: perros.isNotEmpty,
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            pet = true;
                            setState(() {});
                          },
                          child: ProfileCircleCard(
                            pet: pet,
                            image: perros.isNotEmpty && perros[actualPet].photos.isNotEmpty
                                ? perros[actualPet].photos.first
                                : '',
                            isUser: false,
                            name: perros.isNotEmpty
                                ? perros[actualPet].nombre
                                : '',
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
                dog: perros.isNotEmpty
                    ? perros[actualPet]
                    : Dog(
                        nombre: '',
                        fechaNacimiento: DateTime.now(),
                        raza: '',
                        personalidad: '',
                        cuidadosEspeciales: '',
                        sexo: '',
                        idUser: '',
                        photos: [],
                      ),
                logedUserController: widget.logedUserController,
                userRegistrationRepository: userRegistrationRepository,
              ),
              child: GuestProfileContent(
                ownProfile: widget.ownProfile,
                user: user,
                logedUserController: widget.logedUserController,
                userRegistrationRepository: userRegistrationRepository,
              ),
            ),
            SizedBox(height: context.spacing.md),
            Visibility(
              visible: widget.ownProfile,
              child: PrincipalButton(
                onPressed: () async {
                  bool logout = await authRepository.logoutUser(
                      context, widget.logedUserController.token);

                  if (logout) {
                    widget.logedUserController.user =
                        widget.logedUserController.createDefaultUser();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SelectionUserScreen(
                            logedUserController: widget.logedUserController),
                      ),
                    );
                  }
                },
                text: 'Cerrar sesión',
                backgroundColor: DugColors.orange,
                textColor: DugColors.white,
              ),
            ),
            Visibility(
              visible: !widget.ownProfile && request.estado == 'Creada',
              child: Column(
                children: [
                  PrincipalButton(
                    onPressed: () {
                      String idSolicitante = widget.logedUserController.user.id ??
                          '${widget.logedUserController.user.pais}${widget.logedUserController.user.documento}';
                      String idSolicitado = user.id ?? '${user.pais}${user.documento}';
                      String idSolicitud = request.id ?? '$idSolicitante$idSolicitado' ;
                      List<RequestModel> solicitudesRecibidas =
                          widget.logedUserController.user.solicitudesRecibidas;
                      solicitudesRecibidas.remove(request);

                      List<RequestModel> solicitudesCreadas =
                          user.solicitudesCreadas;
                      solicitudesCreadas.remove(request);

                      request = request.copyWith(estado: 'Aceptada');

                      solicitudesRecibidas.add(request);
                      solicitudesCreadas.add(request);

                      requestRepository.updateRequest(
                        context,
                        idSolicitud,
                        request,
                      );

                      userRegistrationRepository.updateUser(
                        context,
                        widget.logedUserController.user.id ?? '',
                        widget.logedUserController.user.copyWith(
                          solicitudesRecibidas: solicitudesRecibidas,
                        ),
                      );
                      userRegistrationRepository.updateUser(
                        context,
                        user.id ?? '',
                        user.copyWith(
                          solicitudesCreadas: solicitudesCreadas,
                        ),
                      );

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PrincipalScreen(
                            housingUser:
                                widget.logedUserController.user.tipo == 'Cuidador',
                            logedUserController: widget.logedUserController,
                          ),
                        ),
                      );
                    },
                    text: 'Aceptar solicitud',
                  ),
                  SizedBox(height: context.spacing.xs),
                  PrincipalButton(
                    onPressed: () {
                      String idSolicitante = widget.logedUserController.user.id ??
                          '${widget.logedUserController.user.pais}${widget.logedUserController.user.documento}';
                      String idSolicitado = user.id ?? '${user.pais}${user.documento}';
                      String idSolicitud = request.id ?? '$idSolicitante$idSolicitado' ;
                      List<RequestModel> solicitudesRecibidas =
                          widget.logedUserController.user.solicitudesRecibidas;
                      solicitudesRecibidas.remove(request);

                      List<RequestModel> solicitudesCreadas =
                          user.solicitudesCreadas;
                      solicitudesCreadas.remove(request);

                      request = request.copyWith(estado: 'Rechazada');

                      solicitudesCreadas.add(request);

                      requestRepository.updateRequest(
                        context,
                        idSolicitud,
                        request,
                      );

                      userRegistrationRepository.updateUser(
                        context,
                        widget.logedUserController.user.id ?? '',
                        widget.logedUserController.user.copyWith(
                          solicitudesRecibidas: solicitudesRecibidas,
                        ),
                      );
                      userRegistrationRepository.updateUser(
                        context,
                        user.id ?? '',
                        user.copyWith(
                          solicitudesCreadas: solicitudesCreadas,
                        ),
                      );

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PrincipalScreen(
                            housingUser:
                                widget.logedUserController.user.tipo == 'Cuidador',
                            logedUserController: widget.logedUserController,
                          ),
                        ),
                      );
                    },
                    text: 'Rechazar solicitud',
                    backgroundColor: DugColors.orange,
                    
                  ),
                ],
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
  final UserRegistrationRepository userRegistrationRepository;

  const GuestProfileContent({
    super.key,
    required this.ownProfile,
    required this.user,
    required this.logedUserController,
    required this.userRegistrationRepository,
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
          child: PhotosCarousel(images: user.fotos,),
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
              Visibility(
                visible: user.tipo == 'Cuidador',
                child: Column(
                  children: [
                    ResumeReservationCard(
                      child: PhotosCarousel(images: user.alojamiento?.photos ?? [],),
                    ),
                    SizedBox(height: context.spacing.md),
                  ],
                ),
              ),
              ResumeReservationCard(
                child: GuestProfilePaymentCardContent(
                  logedUserController: logedUserController,
                ),
              ),
              SizedBox(height: context.spacing.md),
              ResumeReservationCard(
                child: GuestProfileInfoCardContent(
                  user: user,
                  logedUserController: logedUserController,
                  userRegistrationRepository: userRegistrationRepository,
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
            logedUserController: logedUserController,
            userRegistrationRepository: userRegistrationRepository,
          ),
        ),
      ],
    );
  }
}

class PhotosCarousel extends StatelessWidget {
  final List<String> images;

  const PhotosCarousel({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map((image) {
        return Container(
          height: 50,
          child: Image.network(image),
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
  final LogedUserController logedUserController;
  final UserRegistrationRepository userRegistrationRepository;

  const PetProfileContent({
    super.key,
    required this.ownProfile,
    required this.user,
    required this.dog,
    required this.logedUserController,
    required this.userRegistrationRepository,
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
          child: PhotosCarousel(images: dog.photos),
        ),
        SizedBox(height: context.spacing.md),
        ResumeReservationCard(
          child: PetProfileInfoCardContent(
            ownProfile: ownProfile,
            dog: dog,
            logedUserController: logedUserController,
            userRegistrationRepository: userRegistrationRepository,
          ),
        ),
        SizedBox(height: context.spacing.md),
        ResumeReservationCard(
          child: GuestProfileDescriptionCardContent(
            pet: true,
            ownProfile: ownProfile,
            user: user,
            logedUserController: logedUserController,
            userRegistrationRepository: userRegistrationRepository,
            dog: dog,
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
    bool housingUser = user.tipo == 'Cuidador';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              housingUser ? 'Ubicación alojamiento' : 'Veterinaria',
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
        // Column(
        //   children: [
        //     Center(
        //       child: GuestProfileLocationToggleButtons(),
        //     ),
        //     SizedBox(
        //       height: context.spacing.lg,
        //     ),
        //   ],
        // ),
        Visibility(
          visible: !housingUser,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Nombre:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 150,
                    child: Text(
                      user.clinicaVeterinaria?.nombre ?? '',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.spacing.lg,
              ),
              Row(
                children: [
                  Text(
                    'Telefono:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 150,
                    child: Text(
                      user.clinicaVeterinaria?.numeroTelefono ?? '',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.spacing.lg,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              'Dirección:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              width: 150,
              child: Text(
                housingUser
                    ? user.alojamiento?.ubicacion.direccion ?? ''
                    : user.clinicaVeterinaria?.ubicacion.direccion ?? '',
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
  final LogedUserController logedUserController;
  final UserRegistrationRepository userRegistrationRepository;
  const GuestProfileInfoCardContent({
    super.key,
    required this.user,
    required this.logedUserController,
    required this.userRegistrationRepository,
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

class GuestProfileDescriptionCardContent extends StatefulWidget {
  final bool pet;
  final bool ownProfile;
  final User user;
  final Dog? dog;
  final LogedUserController logedUserController;
  final UserRegistrationRepository userRegistrationRepository;

  GuestProfileDescriptionCardContent({
    super.key,
    required this.pet,
    required this.ownProfile,
    required this.user,
    this.dog,
    required this.logedUserController,
    required this.userRegistrationRepository,
  });

  @override
  State<GuestProfileDescriptionCardContent> createState() =>
      _GuestProfileDescriptionCardContentState();
}

class _GuestProfileDescriptionCardContentState
    extends State<GuestProfileDescriptionCardContent> {
  bool editing = false;

  String description = '';
  String newDescription = 'null';
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    description =
        widget.pet ? widget.dog?.personalidad ?? '' : widget.user.descripcion;
    if (newDescription == 'null') {
      newDescription = description;
      descriptionController = TextEditingController(text: newDescription);
    }
    @override
    void dispose() {
      // Liberar controladores cuando la página se cierre
      descriptionController.dispose();
      super.dispose();
    }

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
              visible: widget.ownProfile,
              child: InkWell(
                onTap: () {
                  if (editing) {
                    User updateUser = widget.user;

                    if (widget.pet) {
                      List<Dog> perros = widget.user.perros ?? [];
                      for (int i = 0; i < perros.length; i++) {
                        if (perros[i] == widget.dog) {
                          perros[i] = widget.dog
                                  ?.copyWith(personalidad: newDescription) ??
                              perros[i];
                        }
                      }
                      updateUser = widget.user.copyWith(
                        perros: perros,
                      );
                    } else {
                      updateUser = widget.user.copyWith(
                        descripcion: newDescription,
                      );
                    }

                    widget.userRegistrationRepository.updateUser(
                      context,
                      updateUser.id ??
                          '${updateUser.pais}${updateUser.documento}',
                      updateUser,
                    );

                    widget.logedUserController.user = updateUser;
                  }
                  setState(() {
                    editing = !editing;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(context.radius.lg),
                    ),
                    color: widget.pet ? DugColors.green : DugColors.purple,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: context.spacing.xxs,
                        horizontal: context.spacing.sm),
                    child: Text(
                      editing ? 'Guardar' : 'Editar',
                      style: TextStyle(
                        color: DugColors.white,
                        fontSize: context.text.size.xxs,
                      ),
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
        Visibility(
          visible: !editing,
          replacement: TextField(
            controller: descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Escribe una descripción..',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.radius.xxxl),
              ),
            ),
            onChanged: (value) {
              setState(() {
                newDescription = value;
              });
            },
          ),
          child: Text(
            newDescription,
          ),
        ),
      ],
    );
  }
}

class PetProfileInfoCardContent extends StatefulWidget {
  final bool ownProfile;
  final Dog dog;
  final LogedUserController logedUserController;
  final UserRegistrationRepository userRegistrationRepository;

  PetProfileInfoCardContent({
    super.key,
    required this.ownProfile,
    required this.dog,
    required this.logedUserController,
    required this.userRegistrationRepository,
  });

  @override
  State<PetProfileInfoCardContent> createState() =>
      _PetProfileInfoCardContentState();
}

class _PetProfileInfoCardContentState extends State<PetProfileInfoCardContent> {
  bool editing = false;
  String newPersonality = 'null';
  TextEditingController personalityController = TextEditingController();
  String newCares = 'null';
  TextEditingController caresController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (newPersonality == 'null') {
      newPersonality = widget.dog.personalidad;
      personalityController = TextEditingController(text: newPersonality);
    }
    if (newCares == 'null') {
      newCares = widget.dog.cuidadosEspeciales;
      caresController = TextEditingController(text: newCares);
    }

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
              visible: widget.ownProfile,
              child: InkWell(
                onTap: () {
                  if (editing) {
                    User updateUser = widget.logedUserController.user;

                    List<Dog> perros = updateUser.perros ?? [];
                    for (int i = 0; i < perros.length; i++) {
                      if (perros[i] == widget.dog) {
                        perros[i] = widget.dog.copyWith(
                          personalidad: newPersonality,
                          cuidadosEspeciales: newCares,
                        );
                      }
                    }
                    updateUser = updateUser.copyWith(
                      perros: perros,
                    );

                    widget.userRegistrationRepository.updateUser(
                      context,
                      updateUser.id ??
                          '${updateUser.pais}${updateUser.documento}',
                      updateUser,
                    );

                    widget.logedUserController.user = updateUser;
                  }
                  setState(() {
                    editing = !editing;
                  });
                },
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
                      editing ? 'Guardar' : 'Editar',
                      style: TextStyle(
                        color: DugColors.white,
                        fontSize: context.text.size.xxs,
                      ),
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
        Text(widget.dog.raza),
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
        Visibility(
          visible: !editing,
          replacement: TextField(
            controller: personalityController,
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.radius.xxxl),
              ),
            ),
            onChanged: (value) {
              setState(() {
                newPersonality = value;
              });
            },
          ),
          child: Text(newPersonality),
        ),
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
        Visibility(
          visible: !editing,
          replacement: TextField(
            controller: caresController,
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.radius.xxxl),
              ),
            ),
            onChanged: (value) {
              setState(() {
                newCares = value;
              });
            },
          ),
          child: Text(newCares),
        ),
      ],
    );
  }
}

import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/localization_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/login/repository/accommodation_registration_repository.dart';
import 'package:app_mascotas/login/repository/user_registration_repository.dart';
import 'package:app_mascotas/profile/ui/widget/housing/housing_or_request_card.dart';
import 'package:app_mascotas/reservation/ui/widgets/resume_reservation_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

class FavoritesScreen extends StatefulWidget {
  final bool housingUser;
  final LogedUserController logedUserController;
  final List<User> favoritos;

  FavoritesScreen({
    super.key,
    required this.housingUser,
    required this.logedUserController,
    required this.favoritos,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool editing = false;
  String selectedDate = '';
  String selectedHour = '';
  DateTime fechaDeInicio = DateTime.now();
  DateTime fechaDeFin = DateTime.now();
  int horaDeInicio = 0;
  int horaDeFin = 0;
  Accommodation? alojamiento = null;

  AccommodationsRegistrationRepository accommodationsRegistrationRepository =
      AccommodationsRegistrationRepository();
  UserRegistrationRepository userRegistrationRepository =
      UserRegistrationRepository();

  @override
  Widget build(BuildContext context) {
    alojamiento = widget.logedUserController.user.alojamiento;
    selectedDate = selectedDate.isEmpty ? getSelectedDateRange() : selectedDate;
    selectedHour = selectedHour.isEmpty ? getSelectedHourRange() : selectedHour;

    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: context.spacing.sm,
          ),
          Visibility(
            visible: widget.housingUser,
            replacement: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
              child: Column(
                children: [
                  for (User favorito in widget.favoritos) ...{
                    HousingOrRequestCard(
                      user: favorito,
                      alojamiento: favorito.alojamiento ?? defaultAccommodation(),
                      housing: favorito.tipo == 'Cuidador',
                      favorite: true,
                      perros: favorito.perros ?? [],
                      tipoReserva: '',
                      inicioDiaReserva: DateTime.now(),
                      finDiaReserva: DateTime.now(),
                      inicioHoraReserva: 0,
                      finHoraReserva: 0,
                      distancia: favorito.distancia ?? '',
                      logedUserController: widget.logedUserController,
                    ),
                  }
                ],
              ),
            ),
            child: ResumeReservationCard(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fechas de disponibilidad',
                      style: TextStyle(
                        fontSize: context.text.size.sm,
                        fontWeight: FontWeight.bold,
                        color: DugColors.orange,
                      ),
                    ),
                    Visibility(
                      visible: !editing,
                      child: SizedBox(
                        width: 80,
                        child: PrincipalButton(
                          onPressed: () {
                            setState(() {
                              editing = true;
                            });
                          },
                          text: 'Editar',
                          padding: 0,
                          textSize: context.text.size.xs,
                          backgroundColor: DugColors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.spacing.sm,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Días',
                          style: TextStyle(
                            fontSize: context.text.size.sm,
                          ),
                        ),
                        SizedBox(
                          height: context.spacing.xxs,
                        ),
                        buttonDateRange(),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Horas (Hoy)',
                          style: TextStyle(
                            fontSize: context.text.size.sm,
                          ),
                        ),
                        SizedBox(
                          height: context.spacing.xxs,
                        ),
                        hourRange(),
                      ],
                    )
                  ],
                ),
                Visibility(
                  visible: editing,
                  child: Column(
                    children: [
                      SizedBox(
                        height: context.spacing.sm,
                      ),
                      PrincipalButton(
                        onPressed: () {
                          setState(() {
                            editing = false;
                          });
                          updateDisponibility();
                        },
                        text: 'Guardar',
                        textSize: context.text.size.xs,
                        backgroundColor: DugColors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    ));
  }

  Container buttonDateRange() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        border: Border.all(
          color: DugColors.orange,
          width: 3,
        ),
      ),
      width: 145,
      child: InkWell(
        onTap: () {
          if (editing) {
            _selectDate();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Text(
              selectedDate,
              style: TextStyle(
                fontSize: context.text.size.xs,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container hourRange() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        border: Border.all(
          color: DugColors.orange,
          width: 3,
        ),
      ),
      width: 145,
      child: InkWell(
        onTap: () {
          if (editing) {
            _selectHour();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Text(
              selectedHour,
              style: TextStyle(
                fontSize: context.text.size.xs,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Listo',
    );

    if (result != null) {
      setState(() {
        selectedDate =
            '${result.start.day.toString()}/${result.start.month.toString()} - ${result.end.day.toString()}/${result.end.month.toString()}';
        fechaDeInicio = result.start;
        fechaDeFin = result.end;
      });
    }
  }

  Future<void> _selectHour() async {
    int startTime = DateTime.now().hour;
    final TimeRange result = await showTimeRangePicker(
      context: context,
      start: TimeOfDay(hour: startTime, minute: 0),
      end: const TimeOfDay(hour: 24, minute: 0),
      interval: const Duration(minutes: 30),
      use24HourFormat: true,
    );

    setState(() {
      selectedHour =
          '${result.startTime.hour}:00 - ${result.endTime.hour}:00';
      horaDeInicio = result.startTime.hour;
      horaDeFin = result.endTime.hour;
    });
    }

  String getSelectedDateRange() {
    String startingDay =
        '${alojamiento?.diaInicioDisponibilidad.day}/${alojamiento?.diaInicioDisponibilidad.month}';
    String finishingDay =
        '${alojamiento?.diaFinDisponibilidad.day}/${alojamiento?.diaFinDisponibilidad.month}';
    return '$startingDay - $finishingDay';
  }

  String getSelectedHourRange() {
    String startingHour = '${alojamiento?.horaInicioDisponibilidad}:00';
    String finishingHour = '${alojamiento?.horaFinDisponibilidad}:00';
    return '$startingHour - $finishingHour';
  }

  void updateDisponibility() {
    alojamiento = alojamiento?.copyWith(
      diaInicioDisponibilidad: fechaDeInicio,
      diaFinDisponibilidad: fechaDeFin,
      horaInicioDisponibilidad: horaDeInicio,
      horaFinDisponibilidad: horaDeFin,
    );

    User updateUser = widget.logedUserController.user.copyWith(
      alojamiento: alojamiento,
    );

    // accommodationsRegistrationRepository(
    //   context,
    //   alojamiento,
    // );
    //TODO

    userRegistrationRepository.updateUser(
      context,
      updateUser.id ?? '${updateUser.pais}${updateUser.documento}',
      updateUser,
    );

    widget.logedUserController.user = updateUser;
  }

  Accommodation defaultAccommodation() {
    return Accommodation(
      photos: [],
      ubicacion: Localization(
        ciudad: '',
        direccion: '',
        indicacionesEspeciales: '',
        latitud: 0,
        longitud: 0,
      ),
      descripcionEspacio: '',
      precioPorNoche: 0,
      precioPorHora: 0,
      idUser: '',
      tipoDeServicio: '',
      diaInicioDisponibilidad: DateTime.now(),
      diaFinDisponibilidad: DateTime.now(),
      horaFinDisponibilidad: 0,
      horaInicioDisponibilidad: 0,
    );
  }
}

import 'package:app_mascotas/home/controller/map_controller.dart';
import 'package:app_mascotas/home/controller/search_controller.dart';
import 'package:app_mascotas/home/model/search_model.dart';
import 'package:app_mascotas/home/repository/search_home_repository.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/profile/ui/screens/guest/guest_profile_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

class AppBarDug extends StatefulWidget {
  final bool homeScreen;
  final Widget? barContent;
  final bool? housingUser;
  final SearchDateController? searchController;
  final LogedUserController logedUserController;

  AppBarDug({
    super.key,
    required this.homeScreen,
    this.barContent,
    this.housingUser,
    this.searchController,
    required this.logedUserController,
  });

  @override
  State<AppBarDug> createState() => _AppBarDugState();
}

class _AppBarDugState extends State<AppBarDug> {
  final MapController mapController = MapController();
  String selectedOption = 'Fecha';
  String selectedRange = '';
  DateTime fechaDeInicio = DateTime.now();
  DateTime fechaDeFin = DateTime.now();
  String horaDeInicio = '';
  String horaDeFin = '';
  bool housingUser = false;
  final SearchHomeRepository searchHomeRepository = SearchHomeRepository();

  @override
  Widget build(BuildContext context) {
    housingUser = widget.housingUser != null && widget.housingUser == true;
    if (selectedRange == '' && widget.homeScreen) {
      selectedRange = getDayRange();
    }

    return Visibility(
      visible: !housingUser,
      replacement: Visibility(
        visible: widget.homeScreen,
        replacement: widget.barContent ?? Container(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filtrar Solicitudes',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: DugColors.white),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    dateOrHourDropdown(),
                    SizedBox(
                      width: 20,
                    ),
                    buttonDateOrHourRange(),
                  ],
                ),
              ],
            ),
            Spacer(),
            ProfilePhotoButton(
              logedUserController: widget.logedUserController,
            ),
          ],
        ),
      ),
      child: Visibility(
        visible: widget.homeScreen,
        replacement: widget.barContent ?? Container(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SortByDropdown(
              searchController: widget.searchController,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dateOrHourDropdown(),
                buttonDateOrHourRange(),
              ],
            ),
            Spacer(),
            ProfilePhotoButton(
              logedUserController: widget.logedUserController,
            ),
          ],
        ),
      ),
    );
  }

  Container buttonDateOrHourRange() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      width: 155,
      child: InkWell(
        onTap: () {
          _selectDateOrTime();
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Text(
              selectedRange,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  DropdownButtonHideUnderline dateOrHourDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        value: selectedOption,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        dropdownColor: Colors.blue,
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue!;
            if (newValue == 'Hora (Hoy)') {
              selectedRange = getHourRange();
              widget.searchController?.search = Search(
                tipoDeServicio: 'Hora',
                fechaDeInicio: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                fechaDeFin: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59),
                horaDeInicio: DateTime.now().hour,
                horaDeFin: 24,
                ordenamiento:
                    widget.searchController?.search.ordenamiento ?? '\$ Noche Bajo',
              );
            } else {
              selectedRange = getDayRange();
              DateTime hoy = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
              widget.searchController?.search = Search(
                tipoDeServicio: 'Fecha',
                fechaDeInicio: hoy,
                fechaDeFin: DateTime(hoy.year, hoy.month, hoy.day, 23, 59, 59).add(Duration(days: 1)),
                horaDeInicio: 0,
                horaDeFin: 0,
                ordenamiento:
                    widget.searchController?.search.ordenamiento ?? '\$ Noche Bajo',
              );
            }
          });
        },
        items: <String>[
          'Fecha',
          'Hora (Hoy)',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _selectDateOrTime() async {
    if (selectedOption == 'Fecha') {
      DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,),
        lastDate: DateTime(2030, 12, 31), 
        currentDate: DateTime.now(),
        saveText: 'Listo',
      );

      if (result != null) {
        setState(() {
          selectedRange =
              '${result.start.day.toString()}/${result.start.month.toString()} - ${result.end.day.toString()}/${result.end.month.toString()}';
        });

        widget.searchController?.search = Search(
          tipoDeServicio: 'Fecha',
          fechaDeInicio: result.start,
          fechaDeFin: result.end,
          horaDeInicio: 0,
          horaDeFin: 0,
          ordenamiento:
              widget.searchController?.search.ordenamiento ?? '\$ Noche Bajo',
        );
      }
    } else if (selectedOption == 'Hora (Hoy)') {
      int startTime = DateTime.now().hour;
      final TimeRange result = await showTimeRangePicker(
        context: context,
        start: TimeOfDay(hour: startTime, minute: 0),
        end: const TimeOfDay(hour: 24, minute: 0),
        interval: const Duration(minutes: 30),
        use24HourFormat: true,
      );

      if (result != null) {
        setState(() {
          selectedRange = '${result.startTime.hour}:00 - ${result.endTime.hour}:00';
        });

        widget.searchController?.search = Search(
          tipoDeServicio: 'Hora',
          fechaDeInicio: DateTime.now(),
          fechaDeFin: DateTime.now(),
          horaDeInicio: result.startTime.hour,
          horaDeFin: result.endTime.hour,
          ordenamiento:
              widget.searchController?.search.ordenamiento ?? '\$ Noche Bajo',
        );
      }
    }
  }

  String getHourRange() {
    return DateTime.now().hour.toString() +
        ':00 - 23:59'; 
  }

  String getDayRange() {
    DateTime selected = DateTime.now();
    String range = DateTime.now().day.toString() +
        '/' +
        DateTime.now().month.toString() +
        ' - ';

    if (DateTime.now().day == 30 ||
        DateTime.now().day == 31 ||
        (DateTime.now() == DateTime.february && DateTime.now().day == 28)) {
      range = range + '1' + '/' + (DateTime.now().month + 1).toString();
      selected = DateTime(DateTime.now().year, DateTime.now().month + 1);
    } else {
      range = range +
          (DateTime.now().day + 1).toString() +
          '/' +
          DateTime.now().month.toString();
      selected = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    }

    setState(() {
      fechaDeFin = selected;
    });
    return range;
  }
}

class ProfilePhotoButton extends StatelessWidget {
  final LogedUserController logedUserController;
  const ProfilePhotoButton({
    super.key,
    required this.logedUserController,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (logedUserController.user.id != 'Guest') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuestProfileScreen(
                ownProfile: true,
                logedUserController: logedUserController,
              ),
            ),
          );
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(
              logedUserController.user.fotos.first,
            ),
            radius: 30,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Perfil',
            style: TextStyle(
              fontSize: context.text.size.xs,
              fontWeight: FontWeight.bold,
              color: DugColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class SortByDropdown extends StatefulWidget {
  final SearchDateController? searchController;

  const SortByDropdown({
    Key? key,
    this.searchController,
  }) : super(key: key);

  @override
  _SortByDropdownState createState() => _SortByDropdownState();
}

class _SortByDropdownState extends State<SortByDropdown> {
  String selectedValue = 'Calificación';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Ordenar por:',
            style: TextStyle(
                fontSize: context.text.size.sm, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 140,
          decoration: BoxDecoration(
            color: DugColors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                value: selectedValue,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                dropdownColor: DugColors.white,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                    widget.searchController?.search = Search(
                      tipoDeServicio:
                          widget.searchController?.search.tipoDeServicio ??
                              'Fecha',
                      fechaDeInicio:
                          widget.searchController?.search.fechaDeInicio ??
                              DateTime.now(),
                      fechaDeFin: widget.searchController?.search.fechaDeFin ??
                          DateTime.now().add(const Duration(days: 1)),
                      horaDeInicio:
                          widget.searchController?.search.horaDeInicio ?? 0,
                      horaDeFin: widget.searchController?.search.horaDeFin ?? 0,
                      ordenamiento: selectedValue,
                    );
                  });
                },
                items: <String>[
                  'Calificación',
                  '\$ Noche Bajo',
                  '\$ Noche Alto',
                  '\$ Hora Bajo',
                  '\$ Hora Alto',
                  'Distancia',
                  '# Perros',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

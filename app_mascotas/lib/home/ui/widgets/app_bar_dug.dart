import 'package:app_mascotas/home/controller/map_controller.dart';
import 'package:app_mascotas/home/model/map_model.dart';
import 'package:app_mascotas/profile/ui/screens/guest/guest_profile_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:time_range_picker/time_range_picker.dart';

class AppBarDug extends StatefulWidget {
  final bool homeScreen;
  final Widget? barContent;
  final bool? housingUser;
  AppBarDug({
    super.key,
    required this.homeScreen,
    this.barContent, 
    this.housingUser,
  });

  @override
  State<AppBarDug> createState() => _AppBarDugState();
}

class _AppBarDugState extends State<AppBarDug> {
  final MapController mapController = MapController();
  String selectedOption = 'Fecha';
  String selectedRange = '';
  bool housingUser = false;

  @override
  Widget build(BuildContext context) {
    selectedRange = selectedRange == '' ? getDayRange() : selectedRange;
    housingUser = widget.housingUser != null && widget.housingUser == true;
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
                    fontWeight: FontWeight.bold,
                    color: DugColors.white
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    dateOrHourDropdown(),
                    SizedBox(width: 20,),
                    buttonDateOrHourRange(),
                  ],
                ),
              ],
            ),
            Spacer(),
            ProfilePhotoButton(),
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
            SortByDropdown(),
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
            ProfilePhotoButton(),
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
              } else {
                selectedRange = getDayRange();
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
        firstDate: DateTime(2022, 1, 1), // la fecha más temprana permitida
        lastDate: DateTime(2030, 12, 31), // la fecha más reciente permitida
        currentDate: DateTime.now(),
        saveText: 'Listo',
      );

      if (result != null) {
        setState(() {
          selectedRange =
              '${result.start.day.toString()}/${result.start.month.toString()} - ${result.end.day.toString()}/${result.end.month.toString()}';
        });
      }
    } else if (selectedOption == 'Hora (Hoy)') {
      final TimeRange result = await showTimeRangePicker(
        context: context,
        start: const TimeOfDay(hour: 8, minute: 0),
        end: const TimeOfDay(hour: 20, minute: 0),
        interval: const Duration(minutes: 15),
        use24HourFormat: false,
      );

      if (result != null) {
        String startMinutes = result.startTime.minute == 0
            ? '00'
            : result.startTime.minute.toString();
        String endMinutes = result.endTime.minute == 0
            ? '00'
            : result.endTime.minute.toString();
        setState(() {
          selectedRange =
              '${result.startTime.hour}:$startMinutes - ${result.endTime.hour}:$endMinutes';
        });
      }
    }
  }

  String getHourRange() {
    String minutes = DateTime.now().minute >= 0 && DateTime.now().minute < 10
        ? '0${DateTime.now().minute.toString()}'
        : DateTime.now().minute.toString();
    return DateTime.now().hour.toString() +
        ':' +
        minutes +
        ' - ' +
        (DateTime.now().hour + 5).toString() +
        ':' +
        minutes;
  }

  String getDayRange() {
    String range = DateTime.now().day.toString() +
        '/' +
        DateTime.now().month.toString() +
        ' - ';

    if (DateTime.now().day == 30 ||
        DateTime.now().day == 31 ||
        (DateTime.now() == DateTime.february && DateTime.now().day == 28)) {
      range = range + '1' + '/' + (DateTime.now().month + 1).toString();
    } else {
      range = range +
          (DateTime.now().day + 1).toString() +
          '/' +
          DateTime.now().month.toString();
    }
    return range;
  }
}

class ProfilePhotoButton extends StatelessWidget {
  const ProfilePhotoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GuestProfileScreen(
                      ownProfile: true,
                    )));
      },
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
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

class SortByDropdown extends StatelessWidget {
  const SortByDropdown({
    super.key,
  });

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
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
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
                value: 'Calificación',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                dropdownColor: DugColors.blue,
                onChanged: (String? newValue) {},
                items: <String>[
                  'Calificación',
                  '\$ Noche Bajo',
                  '\$ Noche Alto',
                  '\$ Hora Bajo',
                  '\$ Hora Alto',
                  'Distancia',
                  '# Perros'
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

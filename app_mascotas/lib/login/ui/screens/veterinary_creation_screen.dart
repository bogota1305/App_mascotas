import 'dart:convert';

import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/controller/map_controller.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/localization_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/login/models/veterinary_model.dart';
import 'package:app_mascotas/login/repository/user_registration_repository.dart';
import 'package:app_mascotas/login/repository/veterinary_registration_repository.dart';
import 'package:app_mascotas/login/ui/screens/selection_user_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VeterinaryCreationScreen extends StatefulWidget {
  final User user;
  final LogedUserController logedUserController;

  const VeterinaryCreationScreen({
    super.key,
    required this.user,
    required this.logedUserController,
  });
  @override
  _VeterinaryCreationScreenState createState() =>
      _VeterinaryCreationScreenState();
}

class _VeterinaryCreationScreenState extends State<VeterinaryCreationScreen> {
  String address = '';
  String name = '';
  String phoneNumber = '';
  List<String> suggestions = [];

  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final UserRegistrationRepository userRegistrationRepository =
      UserRegistrationRepository();
  final VeterinaryRegistrationRepository veterinaryRegistrationRepository =
      VeterinaryRegistrationRepository();
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarDug(
          homeScreen: false,
          barContent: Text(
            'Información de veterinaria',
            style: TextStyle(
              fontSize: context.text.size.md,
              fontWeight: FontWeight.bold,
            ),
          ),
          logedUserController: widget.logedUserController,
        ),
        backgroundColor: DugColors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.spacing.md),
            Text(
              'Creación de veterinaria',
              style: TextStyle(
                fontSize: context.text.size.md,
                fontWeight: FontWeight.bold,
                color: DugColors.green,
              ),
            ),
            SizedBox(height: context.spacing.xxl),
            Text(
              'Nombre',
              style: TextStyle(
                fontSize: context.text.size.md,
              ),
            ),
            SizedBox(height: context.spacing.sm),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nombre de la veterinaria',
                hintText: 'Nombre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.radius.xxxl),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            SizedBox(height: context.spacing.lg),
            Text(
              'Número de telefono',
              style: TextStyle(
                fontSize: context.text.size.md,
              ),
            ),
            SizedBox(height: context.spacing.sm),
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número de la veterinaria',
                hintText: 'Número',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.radius.xxxl),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  phoneNumber = value;
                });
              },
            ),
            SizedBox(height: context.spacing.lg),
            Text(
              'Dirección',
              style: TextStyle(
                fontSize: context.text.size.md,
              ),
            ),
            SizedBox(height: context.spacing.sm),
            Column(
              children: [
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Dirección',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(context.radius.xxxl),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      address = value;
                      getSuggestions();
                    });
                  },
                ),
                SizedBox(height: 10),
                if (suggestions.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: suggestions
                        .map(
                          (suggestion) => ListTile(
                            title: Text(suggestion),
                            onTap: () {
                              addressController.text = suggestion;
                              setState(
                                () {
                                  address = suggestion;
                                  suggestions = [];
                                },
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
            SizedBox(height: 200.0),
            PrincipalButton(
              onPressed: () {
                onTapVeterinaryButton(context);
              },
              text: 'Enviar Veterinaria',
              backgroundColor: DugColors.green
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  Future<void> onTapVeterinaryButton(BuildContext context) async {
    final geocodedData = await mapController.geocodeAddress(address);
    final double latitude = mapController.getLatitude(geocodedData);
    final double longitude = mapController.getLongitude(geocodedData);
    String userId = widget.logedUserController.user.id ??
        '${widget.user.pais}${widget.user.documento}';

    Veterinary veterinary = Veterinary(
      nombre: name,
      numeroTelefono: phoneNumber,
      ubicacion: Localization(
        ciudad: 'Bogotá',
        direccion: address,
        indicacionesEspeciales: '',
        latitud: latitude,
        longitud: longitude,
      ),
    );

    User updateUser = widget.logedUserController.user.copyWith(
      clinicaVeterinaria: veterinary,
    );

    veterinaryRegistrationRepository.createVeterinary(context, veterinary);

    userRegistrationRepository.updateUser(
      context,
      userId,
      updateUser,
    );

    widget.logedUserController.user = updateUser;

    if (areAllFieldsFilled()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelectionUserScreen(
            logedUserController: widget.logedUserController,
          ), // La siguiente pantalla
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Completa todos los campos'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }

  bool areAllFieldsFilled() {
    return address.isNotEmpty && name.isNotEmpty && phoneNumber.isNotEmpty;
  }

  void getSuggestions() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$address&key=AIzaSyCW7oQvJj05PXKlLMoZ_3QJHiFSfavbC4c',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          // Procesa las sugerencias y muestra las opciones al usuario
          final predictions = data['predictions'] as List<dynamic>;
          final suggestionList = predictions.map<String>((prediction) {
            return prediction['description'];
          }).toList();
          setState(() {
            suggestions = suggestionList;
          });
        }
      } else {
        throw Exception('Error al obtener sugerencias de direcciones');
      }
    } catch (e) {
      print('Error al obtener sugerencias de direcciones: $e');
    }
  }
}

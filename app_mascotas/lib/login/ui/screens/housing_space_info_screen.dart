import 'dart:convert';

import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/controller/map_controller.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/localization_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/login/repository/accommodation_registration_repository.dart';
import 'package:app_mascotas/login/repository/user_registration_repository.dart';
import 'package:app_mascotas/login/ui/screens/selection_user_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:app_mascotas/widgets/textFields/registration_text_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'package:image/image.dart' as img;

class HousingSpaceInfo extends StatefulWidget {
  final User user;
  final LogedUserController logedUserController;

  const HousingSpaceInfo({
    super.key,
    required this.user,
    required this.logedUserController,
  });
  @override
  _HousingSpaceInfoState createState() => _HousingSpaceInfoState();
}

class _HousingSpaceInfoState extends State<HousingSpaceInfo> {
  // Variables para almacenar la información del alojamiento
  List<String> accommodationImages = []; // Lista de rutas de imágenes
  String address = '';
  String description = '';
  bool offerNightService = false;
  bool offerHourlyService = false;
  double pricePerNight = 0.0;
  double pricePerHour = 0.0;
  String errorMessage = '';
  List<String> suggestions = [];

  // Controladores para los campos de entrada de texto
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final pricePerNightController = TextEditingController();
  final pricePerHourController = TextEditingController();

  final UserRegistrationRepository userRegistrationRepository =
      UserRegistrationRepository();
  final AccommodationsRegistrationRepository
      accommodationsRegistrationRepository =
      AccommodationsRegistrationRepository();
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarDug(
          homeScreen: false,
          barContent: Text(
            'Información de alojamiento',
            style: TextStyle(
              fontSize: context.text.size.md,
              fontWeight: FontWeight.bold,
            ),
          ), 
          logedUserController: widget.logedUserController,
        ),
        backgroundColor: DugColors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.spacing.md),
            Text(
              'Información de alojamiento',
              style: TextStyle(
                  fontSize: context.text.size.md,
                  fontWeight: FontWeight.bold,
                  color: DugColors.blue),
            ),
            SizedBox(height: context.spacing.xxl),
            RegistrationTextBox(
              title: 'Fotos del Alojamiento',
              textBox: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: DugColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.radius.xxxl),
                  ),
                ),
                onPressed: () async {
                  final pickedImages =
                      await pickImages(); // Implementa la lógica para seleccionar imágenes
                  setState(() {
                    accommodationImages.addAll(pickedImages);
                  });
                },
                child: Text(
                  'Subir Imágenes de Alojamiento',
                  style: TextStyle(fontSize: context.text.size.sm),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            buildSelectedImages(),
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
                        .map((suggestion) => ListTile(
                              title: Text(suggestion),
                              onTap: () {
                                addressController.text = suggestion;
                                setState(() {
                                  address = suggestion;
                                  suggestions = [];
                                });
                              },
                            ))
                        .toList(),
                  ),
              ],
            ),
            SizedBox(height: 16.0),
            RegistrationTextBox(
              title: 'Descripción del Espacio',
              textBox: TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Escribe una descripción del espacio...',
                  hintText: 'Escribe una descripción del espacio...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radius.xxxl),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
            ),
            SizedBox(height: 16.0),
            RegistrationTextBox(
              title: 'Servicios Ofrecidos',
              textBox: Column(
                children: [
                  CheckboxListTile(
                    title: Text('Noche'),
                    value: offerNightService,
                    onChanged: (value) {
                      setState(() {
                        offerNightService = value!;
                        if (!value) {
                          pricePerNight = 0.0;
                        }
                      });
                    },
                  ),
                  if (offerNightService)
                    TextField(
                      controller: pricePerNightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Precio por Noche',
                        hintText: 'Precio por noche en USD',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(context.radius.xxxl),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          pricePerNight = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                  CheckboxListTile(
                    title: Text('Hora'),
                    value: offerHourlyService,
                    onChanged: (value) {
                      setState(() {
                        offerHourlyService = value!;
                        if (!value) {
                          pricePerHour = 0.0;
                        }
                      });
                    },
                  ),
                  if (offerHourlyService)
                    TextField(
                      controller: pricePerHourController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Precio por Hora',
                        hintText: 'Precio por hora en USD',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(context.radius.xxxl),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          pricePerHour = double.tryParse(value) ?? 0.0;
                        });
                      },
                    ),
                ],
              ),
            ),
            SizedBox(height: 80.0),
            PrincipalButton(
              onPressed: () {
                onTapAccomodationButton(context);
              },
              text: 'Enviar Alojamiento',
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  Future<List<String>> pickImages() async {
    final picker = ImagePicker();
    List<String> imagePaths = [];

    try {
      final pickedImages = await picker.pickMultiImage();

      for (final pickedImage in pickedImages) {
        final imagePath = pickedImage.path;
        imagePaths.add(imagePath);
      }
        } catch (e) {
      print('Error al seleccionar imágenes: $e');
    }

    return imagePaths;
  }

  Widget buildSelectedImages() {
    return ListView.builder(
      itemCount: accommodationImages.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final imagePath = accommodationImages[index];
        return Stack(
          children: [
            Image.file(
              File(imagePath),
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    accommodationImages.removeAt(index);
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  color: DugColors.orange, // Color para el botón de eliminar
                  child: Icon(
                    Icons.close,
                    color: DugColors.white,
                    size: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
          ],
        );
      },
    );
  }

  Future<void> onTapAccomodationButton(BuildContext context) async {
    final geocodedData = await mapController.geocodeAddress(address);
    final double latitude = mapController.getLatitude(geocodedData);
    final double longitude = mapController.getLongitude(geocodedData);
    String userId = widget.user.id ?? '${widget.user.pais}${widget.user.documento}';
    String accommodationId = '${userId}_Accommodation';

    List<String> newAccommodationImages = [];
    for (String accommodationImage  in accommodationImages) {
      final File imageFile = File(accommodationImage);
      List<int> imageBytes = imageFile.readAsBytesSync();

      img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;

      img.Image compressedImage = img.copyResize(image, width: 200);

      List<int> compressedBytes = img.encodePng(compressedImage);

      final String base64Image = base64Encode(compressedBytes);
      newAccommodationImages.add(base64Image);
    }


    Accommodation accommodation = Accommodation(
      id: accommodationId,
      photos: newAccommodationImages,
      ubicacion: Localization(
        ciudad: 'Bogotá',
        direccion: address,
        indicacionesEspeciales: '',
        latitud: latitude,
        longitud: longitude,
      ),
      descripcionEspacio: description,
      precioPorNoche: pricePerNight,
      precioPorHora: pricePerHour,
      idUser: userId,
      tipoDeServicio: getTipeOfService(),
      diaInicioDisponibilidad: DateTime.now(),
      diaFinDisponibilidad: DateTime.now(),
      horaFinDisponibilidad: 0,
      horaInicioDisponibilidad: 0,
    );

    await accommodationsRegistrationRepository.registerAccommodations(
      context,
      accommodation,
    );


    User updateUser = widget.user.copyWith(
        alojamiento: await accommodationsRegistrationRepository.getAccommodationById(accommodationId),
      );

   
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
    return accommodationImages.isNotEmpty &&
        address.isNotEmpty &&
        description.isNotEmpty &&
        (offerNightService || offerHourlyService) &&
        (pricePerNight > 0 || pricePerHour > 0);
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
  
  String getTipeOfService() {
    String tipoDeServicio = '';

    if(offerNightService){
      tipoDeServicio = 'Fecha';
    }
    if(offerHourlyService){
      tipoDeServicio = 'Hora';
    }
    if(offerNightService && offerHourlyService){
      tipoDeServicio = 'Ambos';
    }

    return tipoDeServicio;
  }
}

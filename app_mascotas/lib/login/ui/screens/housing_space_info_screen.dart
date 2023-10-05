import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/ui/screens/housing_profile_creation_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:app_mascotas/widgets/textFields/registration_text_box.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HousingSpaceInfo extends StatefulWidget {
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

  // Controladores para los campos de entrada de texto
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final pricePerNightController = TextEditingController();
  final pricePerHourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarDug(
          homeScreen: false,
          barContent: Text(
            'Información de alojamient',
            style: TextStyle(
              fontSize: context.text.size.md,
              fontWeight: FontWeight.bold,
            ),
          ),
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
            RegistrationTextBox(
              title: 'Dirección',
              textBox: TextField(
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
                  });
                },
              ),
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
                            borderRadius: BorderRadius.circular(context.radius.xxxl),
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
                            borderRadius: BorderRadius.circular(context.radius.xxxl),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            pricePerHour = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                  ],
                )),
            SizedBox(height: 80.0),
            PrincipalButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        HousingProfileCreationScreen(), // La siguiente pantalla
                  ),
                );
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

      if (pickedImages != null) {
        for (final pickedImage in pickedImages) {
          final imagePath = pickedImage.path;
          imagePaths.add(imagePath);
        }
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
}

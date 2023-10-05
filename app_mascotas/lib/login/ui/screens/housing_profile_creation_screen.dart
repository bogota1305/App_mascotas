import 'dart:io';

import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/screens/principal_screen.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HousingProfileCreationScreen extends StatefulWidget {
  @override
  _HousingProfileCreationScreenState createState() =>
      _HousingProfileCreationScreenState();
}

class _HousingProfileCreationScreenState
    extends State<HousingProfileCreationScreen> {
  // Variables para almacenar la información del perfil
  List<String> profileImages = []; // Lista de rutas de imágenes
  String description = '';
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    // Liberar controladores cuando la página se cierre
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarDug(
          homeScreen: false,
          barContent: Text(
            'Creación de Perfil',
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
              'Fotos de perfil',
              style: TextStyle(
                fontSize: context.text.size.md,
                fontWeight: FontWeight.bold,
                color: DugColors.blue,
              ),
            ),
            SizedBox(height: context.spacing.md),
            // Implementa la carga de imágenes aquí
            Text(
              'Sugerencias para las Fotos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.spacing.xxs),
            Text('1. Sube fotos donde estés sonriendo y amigable.'),
            Text('2. Incluye al menos una foto de cuerpo completo.'),
            Text('3. Agrega fotos con mascotas si es relevante.'),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: DugColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.radius.xxxl),
                ),
              ),
              onPressed: () async {
                final pickedImages = await ImagePicker()
                    .pickMultiImage(); // Abre el selector de imágenes
                if (pickedImages != null) {
                  setState(() {
                    profileImages.addAll(pickedImages.map((image) => image
                        .path)); // Agrega las rutas de imágenes seleccionadas a la lista
                  });
                }
              },
              child: Text('Subir fotos de perfil',
                  style: TextStyle(fontSize: context.text.size.sm)),
            ),
            Row(
              children: [
                for (int i = 0; i < profileImages.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: FileImage(File(profileImages[i])),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                profileImages.removeAt(
                                    i); // Elimina la imagen seleccionada
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: DugColors.orange,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: context.spacing.xxxl),
            Text(
              'Descripción del perfil',
              style: TextStyle(
                fontSize: context.text.size.md,
                fontWeight: FontWeight.bold,
                color: DugColors.blue,
              ),
            ),
            SizedBox(height: context.spacing.md),
            Text(
              'Sugerencias para la Descripción:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.spacing.xxs),
            Text('1. Habla sobre tus intereses y tu amor por las mascotas.'),
            Text('2. Describe tu experiencia cuidando mascotas.'),
            Text('3. Menciona cualquier habilidad especial que tengas.'),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Descripción del Perfil',
                hintText: 'Escribe una descripción amigable..',
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
            SizedBox(height: 80.0),
            PrincipalButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        PrincipalScreen(), // La siguiente pantalla
                  ),
                );
              },
              text: 'Guardar perfil',
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}

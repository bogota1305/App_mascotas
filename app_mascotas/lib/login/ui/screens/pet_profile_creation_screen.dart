import 'dart:io';

import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/screens/principal_screen.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/dog_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/login/repository/dog_registration_repository.dart';
import 'package:app_mascotas/login/repository/user_registration_repository.dart';
import 'package:app_mascotas/login/ui/screens/pet_info_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PetProfileCreationScreen extends StatefulWidget {
  final User user;
  final Dog dog;
  final LogedUserController logedUserController;

  const PetProfileCreationScreen({
    super.key,
    required this.user,
    required this.dog,
    required this.logedUserController,
  });
  @override
  _PetProfileCreationScreenState createState() =>
      _PetProfileCreationScreenState();
}

class _PetProfileCreationScreenState extends State<PetProfileCreationScreen> {
  // Variables para almacenar la información del perfil
  List<String> profileImages = []; // Lista de rutas de imágenes
  String description = '';
  final descriptionController = TextEditingController();
  final UserRegistrationRepository userRegistrationRepository =
      UserRegistrationRepository();
  final DogRegistrationRepository dogRegistrationRepository =
      DogRegistrationRepository();
  final List<Dog> dogs = [];

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
            'Creación de Perfil - Mascota',
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
              'Fotos de mascota',
              style: TextStyle(
                fontSize: context.text.size.md,
                fontWeight: FontWeight.bold,
                color: DugColors.green,
              ),
            ),
            SizedBox(height: context.spacing.md),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: DugColors.green,
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
              child: Text('Subir fotos de mascota',
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
              'Descripción de la mascota',
              style: TextStyle(
                fontSize: context.text.size.md,
                fontWeight: FontWeight.bold,
                color: DugColors.green,
              ),
            ),
            SizedBox(height: context.spacing.md),
            Text(
              'Sugerencias para la Descripción:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.spacing.xxs),
            Text('Describe a tu mascota, queremos conocerla'),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Descripción de la mascota',
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
                onTapProfileButton(context);
              },
              text: 'Guardar perfil',
              backgroundColor: DugColors.green,
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  void onTapProfileButton(BuildContext context) {
    String userId = '${widget.user.pais}${widget.user.documento}';
    Dog dogUpdated =
        widget.dog.copyWith(personalidad: description, photos: profileImages);
    dogs.add(dogUpdated);
    User userUpdated = widget.user.copyWith(perros: dogs);

    userRegistrationRepository.updateUser(
      context,
      userId,
      userUpdated,
    );

    dogRegistrationRepository.registerDog(context, dogUpdated);

    widget.logedUserController.user = userUpdated;

    if (areAllFieldsFilled()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PrincipalScreen(
            housingUser: false,
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
    return description.isNotEmpty && profileImages.isNotEmpty;
  }
}

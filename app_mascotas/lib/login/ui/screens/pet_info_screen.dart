import 'dart:convert';

import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/dog_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/login/ui/screens/pet_profile_creation_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:app_mascotas/widgets/textFields/registration_text_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

class PetInfoScreen extends StatefulWidget {
  final User user;
  final LogedUserController logedUserController;

  const PetInfoScreen({
    super.key,
    required this.user,
    required this.logedUserController,
  });

  @override
  _PetInfoScreenState createState() => _PetInfoScreenState();
}

class _PetInfoScreenState extends State<PetInfoScreen> {
  // Variables para almacenar la información personal
  String firstName = '';
  DateTime? birthDate;
  String breed = '';
  String personalityBehavior = '';
  String gender = 'Masculino'; // Valor predeterminado
  List<String> imagePaths = []; // Lista de rutas de imágenes seleccionadas
  bool hasSpecialCares = false;
  String specialCares = '';

  // Controladores para los campos de entrada de texto
  final firstNameController = TextEditingController();
  final breedController = TextEditingController();
  final personalityBehaviorController = TextEditingController();
  final specialCaresController = TextEditingController();

  @override
  void dispose() {
    // Liberar controladores cuando la página se cierre
    firstNameController.dispose();
    breedController.dispose();
    personalityBehaviorController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != birthDate)
      setState(() {
        birthDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarDug(
          homeScreen: false,
          barContent: Text(
            'Registro de mascota',
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
        padding: EdgeInsets.all(context.spacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.spacing.md),
            Text(
              'Información Personal',
              style: TextStyle(
                fontSize: context.text.size.md,
                fontWeight: FontWeight.bold,
                color: DugColors.green,
              ),
            ),
            SizedBox(height: context.spacing.xxl),
            RegistrationTextBox(
              title: 'Nombre',
              textBox: TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radius.xxxl),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    firstName = value;
                  });
                },
              ),
            ),
            SizedBox(height: 16.0),
            RegistrationTextBox(
              title: 'Raza',
              textBox: TextField(
                controller: breedController,
                decoration: InputDecoration(
                  labelText: 'Raza',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radius.xxxl),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    breed = value;
                  });
                },
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: RegistrationTextBox(
                    title: 'Fecha de Nacimiento',
                    textBox: InkWell(
                      onTap: () =>
                          _selectDate(context), // Abre el selector de fecha
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Fecha de Nacimiento',
                          hintText: 'Selecciona una fecha',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(context.radius.xxxl),
                          ),
                        ),
                        child: birthDate == null
                            ? Text('')
                            : Text(
                                '${birthDate?.day}/${birthDate?.month}/${birthDate?.year}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: RegistrationTextBox(
                    title: 'Sexo',
                    textBox: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: DugColors.greyCard),
                        borderRadius:
                            BorderRadius.circular(context.radius.xxxl),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                            items: ['Masculino', 'Femenino', 'Otro']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            RegistrationTextBox(
              title: 'Personalidad/Comportamiento',
              textBox: TextField(
                controller: personalityBehaviorController,
                decoration: InputDecoration(
                  labelText: 'Personalidad/Comportamiento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radius.xxxl),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    personalityBehavior = value;
                  });
                },
              ),
            ),
            SizedBox(height: 16.0),
            RegistrationTextBox(
              title: 'Servicios especiales',
              textBox: Column(
                children: [
                  CheckboxListTile(
                    title: Text('Cuidados especiales'),
                    value: hasSpecialCares,
                    onChanged: (value) {
                      setState(() {
                        hasSpecialCares = value!;
                      });
                    },
                    activeColor: DugColors.green,
                  ),
                  if (hasSpecialCares)
                    TextField(
                      controller: specialCaresController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Cuidados especiales',
                        hintText: 'Cuidados especiales',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(context.radius.xxxl),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          specialCares = value;
                        });
                      },
                    ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
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
                setState(() {
                  imagePaths.addAll(pickedImages.map((image) => image
                      .path)); // Agrega las rutas de imágenes seleccionadas a la lista
                });
                            },
              child: Text(
                'Subir carnet de vacunación',
                style: TextStyle(fontSize: context.text.size.sm),
              ),
            ),
            Row(
              children: [
                for (int i = 0; i < imagePaths.length; i++)
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
                              image: FileImage(File(imagePaths[i])),
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
                                imagePaths.removeAt(i);
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
            SizedBox(height: 80.0),
            PrincipalButton(
              onPressed: () {
                if (areAllFieldsFilled()) {
                  onTapRegistrationButton(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Completa todos los campos del formulario'),
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
              },
              text: 'Enviar Registro',
              backgroundColor: DugColors.green,
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  void onTapRegistrationButton(BuildContext context) {
    String userId = widget.user.id ?? '${widget.user.pais}${widget.user.documento}';
    int dogNumber = (widget.user.perros?.length ?? 0) + 1;
    String dogId = '${userId}_Dog_$dogNumber';

    List<String> newImagePaths = [];
    for (String imagePath  in imagePaths) {
      final File imageFile = File(imagePath);
      List<int> imageBytes = imageFile.readAsBytesSync();

      // Decodifica la imagen
      img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;

      // Optimiza y comprime la imagen (ajusta la calidad según sea necesario)
      img.Image compressedImage = img.copyResize(image, width: 200);

      // Codifica la imagen comprimida a bytes
      List<int> compressedBytes = img.encodePng(compressedImage);

      // Convierte los bytes a base64
      final String base64Image = base64Encode(compressedBytes);
      newImagePaths.add(base64Image);
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PetProfileCreationScreen(
          user: widget.user,
          dog: Dog(
            id: dogId,
            nombre: firstName,
            fechaNacimiento: birthDate ?? DateTime.now(),
            raza: breed,
            personalidad: personalityBehavior,
            cuidadosEspeciales: specialCares,
            sexo: gender,
            idUser: userId,
            photos: newImagePaths,
          ),
          logedUserController: widget.logedUserController,
        ), // La siguiente pantalla
      ),
    );
  }

  bool areAllFieldsFilled() {
    return firstName.isNotEmpty &&
        birthDate != null &&
        breed.isNotEmpty &&
        personalityBehavior.isNotEmpty &&
        gender.isNotEmpty &&
        imagePaths.isNotEmpty;
  }
}

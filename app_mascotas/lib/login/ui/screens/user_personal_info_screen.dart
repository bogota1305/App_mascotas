import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/ui/screens/housing_space_info_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:app_mascotas/widgets/textFields/registration_text_box.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserPersonalInfoScreen extends StatefulWidget {
  @override
  _UserPersonalInfoScreenState createState() => _UserPersonalInfoScreenState();
}

class _UserPersonalInfoScreenState extends State<UserPersonalInfoScreen> {
  // Variables para almacenar la información personal
  String firstName = '';
  String lastName = ''; // Nuevo campo para apellidos
  DateTime? birthDate;
  String documentNumber = '';
  String email = '';
  String phone = '';
  String gender = 'Masculino'; // Valor predeterminado
  String prefixCellphone = '';
  String idType = 'C.C.'; // Valor predeterminado
  String idImage =
      ''; // Almacena la ruta de la imagen del documento de identidad
  List<String> imagePaths = []; // Lista de rutas de imágenes seleccionadas

  // Controladores para los campos de entrada de texto
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final documentNumberController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final prefixCellphoneController = TextEditingController();

  @override
  void dispose() {
    // Liberar controladores cuando la página se cierre
    firstNameController.dispose();
    lastNameController.dispose();
    documentNumberController.dispose();
    emailController.dispose();
    phoneController.dispose();
    prefixCellphoneController.dispose();
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
            'Registro de usuario',
            style: TextStyle(
              fontSize: context.text.size.md,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: DugColors.blue,
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
                  color: DugColors.blue),
            ),
            SizedBox(height: context.spacing.xxl),
            Row(
              children: [
                Expanded(
                  child: RegistrationTextBox(
                    title: 'Nombre',
                    textBox: TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(context.radius.xxxl),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          firstName = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: RegistrationTextBox(
                    title: 'Apellidos',
                    textBox: TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Apellidos',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(context.radius.xxxl),
                        ),
                      ), // Nuevo campo para apellidos
                      onChanged: (value) {
                        setState(() {
                          lastName = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            RegistrationTextBox(
              title: 'Correo',
              textBox: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radius.xxxl),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    email = value;
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
              title: 'Teléfono',
              textBox: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radius.xxxl),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: RegistrationTextBox(
                    title: 'Tipo de documento',
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
                            value: idType,
                            onChanged: (value) {
                              setState(() {
                                idType = value!;
                              });
                            },
                            items: ['C.C.', 'C.E.', 'Pasaporte']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            underline:
                                Container(), // Elimina la línea por defecto del DropdownButton
                            style: TextStyle(
                                color: Colors
                                    .black), // Cambia el color del texto del botón
                            icon: Icon(Icons
                                .arrow_drop_down), // Agrega un ícono de flecha hacia abajo
                            iconSize: 36.0, // Ajusta el tamaño del ícono
                            elevation:
                                16, // Cambia la elevación de la lista desplegable
                            isExpanded:
                                true, // Permite que la lista desplegable ocupe todo el ancho
                            dropdownColor: Colors
                                .white, // Cambia el color del fondo de la lista desplegable
                            // Agrega bordes redondeados al campo de selección de tipo de documento
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: RegistrationTextBox(
                    title: 'Documento',
                    textBox: TextField(
                      controller: documentNumberController,
                      decoration: InputDecoration(
                        labelText: 'Documento',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(context.radius.xxxl),
                        ),
                      ), // Nuevo campo para apellidos
                      onChanged: (value) {
                        setState(() {
                          documentNumber = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
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
                    imagePaths.addAll(pickedImages.map((image) => image
                        .path)); // Agrega las rutas de imágenes seleccionadas a la lista
                  });
                }
              },
              child: Text('Subir Documento de Identidad',
                  style: TextStyle(fontSize: context.text.size.sm)),
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
                                imagePaths.removeAt(
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
            SizedBox(height: 80.0),
            PrincipalButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        HousingSpaceInfo(), // La siguiente pantalla
                  ),
                );
              },
              text: 'Enviar Registro',
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}
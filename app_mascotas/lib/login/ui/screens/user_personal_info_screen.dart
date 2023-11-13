import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/login/models/accomodation_model.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:app_mascotas/login/repository/user_registration_repository.dart';
import 'package:app_mascotas/login/ui/screens/housing_profile_creation_screen.dart';
import 'package:app_mascotas/login/ui/screens/housing_space_info_screen.dart';
import 'package:app_mascotas/login/ui/screens/owner_profile_creation_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:app_mascotas/widgets/textFields/registration_text_box.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

enum UserTipe { housing, owner }

class UserPersonalInfoScreen extends StatefulWidget {
  final UserTipe userTipe;
  final LogedUserController logedUserController;

  const UserPersonalInfoScreen({
    super.key,
    required this.userTipe,
    required this.logedUserController,
  });

  @override
  _UserPersonalInfoScreenState createState() => _UserPersonalInfoScreenState();
}

class _UserPersonalInfoScreenState extends State<UserPersonalInfoScreen> {
  String firstName = '';
  String lastName = '';
  DateTime? birthDate;
  String documentNumber = '';
  String email = '';
  String phone = '';
  String gender = 'Masculino';
  String prefixCellphone = '';
  String idType = 'C.C.';
  List<String> imagePaths = [];
  String password = '';
  String repeatPassword = '';

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final documentNumberController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final prefixCellphoneController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final UserRegistrationRepository userRegistrationRepository =
      UserRegistrationRepository();

  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool arePasswordsMatching = true;
  bool isPhoneValid = true;

  @override
  void dispose() {
    // Liberar controladores cuando la página se cierre
    firstNameController.dispose();
    lastNameController.dispose();
    documentNumberController.dispose();
    emailController.dispose();
    phoneController.dispose();
    prefixCellphoneController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
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
            widget.userTipe == UserTipe.housing
                ? 'Registro de usuario - Cuidador'
                : 'Registro de usuario - Dueño',
            style: TextStyle(
              fontSize: context.text.size.md,
              fontWeight: FontWeight.bold,
            ),
          ),
          logedUserController: widget.logedUserController,
        ),
        backgroundColor: widget.userTipe == UserTipe.housing
            ? DugColors.blue
            : DugColors.purple,
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
                color: widget.userTipe == UserTipe.housing
                    ? DugColors.blue
                    : DugColors.purple,
              ),
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
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radius.xxxl),
                  ),
                  errorText: !isEmailValid
                      ? 'El formato de correo no es valido'
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
            ),
            SizedBox(height: 16.0),
            RegistrationTextBox(
              title: 'Contraseña',
              textBox: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radius.xxxl),
                  ),
                  errorText: !isPasswordValid
                      ? 'La contraseña debe tener al menos 8 caracteres\ny contener al menos una letra mayúscula,\nuna letra minúscula y un número'
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
            ),
            SizedBox(height: 16.0),
            RegistrationTextBox(
              title: 'Repetir Contraseña',
              textBox: TextField(
                controller: repeatPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Repetir Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radius.xxxl),
                  ),
                  errorText: password != repeatPassword
                      ? 'Las contraseñas no coinciden'
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    repeatPassword = value;
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
              title: 'Número celular',
              textBox: TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Número celular',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.radius.xxxl),
                  ),
                  errorText: !isPhoneValid
                      ? 'El teléfono solo puede contener caracteres numericos'
                      : null,
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
                primary: widget.userTipe == UserTipe.housing
                    ? DugColors.blue
                    : DugColors.purple,
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
                if (validateForm()) {
                  if (areAllFieldsFilled()) {
                    onTapRegistrationButton(context);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content:
                            Text('Completa todos los campos del formulario'),
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
              },
              text: 'Enviar Registro',
              backgroundColor: widget.userTipe == UserTipe.housing
                  ? DugColors.blue
                  : DugColors.purple,
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  Future<void> onTapRegistrationButton(BuildContext context) async {
    User user = User(
      nombre: firstName,
      apellidos: lastName,
      fotos: [],
      descripcion: '',
      contrasena: '',
      fechaNacimiento: birthDate ?? DateTime.now(),
      correo: email,
      tipo: '',
      sexo: gender,
      prefijoTelefono: prefixCellphone,
      telefono: phone,
      tipoDocumento: idType,
      documento: documentNumber,
      pais: 'Colombia',
      fotosDocumento: imagePaths,
      calificaciones: [],
      calificacionPromedio: 0,
      solicitudesCreadas: [],
      solicitudesRecibidas: [],
    );

    final bool succes = await userRegistrationRepository.registerUser(
      context,
      user,
    );

    widget.logedUserController.user = user; 

    if (succes) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => widget.userTipe == UserTipe.housing
              ? HousingProfileCreationScreen(user: user, logedUserController: widget.logedUserController,)
              : OwnerProfileCreationScreen(user: user, logedUserController: widget.logedUserController,),
        ),
      );
    }
  }

  bool validateForm() {
    // Realiza validaciones aquí y actualiza las variables de validación
    bool isFormValid = true;

    // Validación de correo electrónico
    isEmailValid = isValidEmail(email);

    // Validación de contraseñas
    isPasswordValid = isValidPassword(password);

    // Verifica si las contraseñas coinciden
    arePasswordsMatching = (password == repeatPassword);

    isPhoneValid = validatePhone(phone);

    // Verifica si todos los campos están llenos
    isFormValid =
        isEmailValid && isPasswordValid && arePasswordsMatching && isPhoneValid;

    // Actualiza el estado
    setState(() {
      isEmailValid = isEmailValid;
      isPasswordValid = isPasswordValid;
      arePasswordsMatching = arePasswordsMatching;
      isFormValid = isFormValid;
      isPhoneValid = isPhoneValid;
    });

    return isFormValid;
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );

    return emailRegExp.hasMatch(email);
  }

  bool isValidPassword(String password) {
    // La contraseña debe tener al menos 8 caracteres y contener al menos una letra mayúscula, una letra minúscula y un número.
    final passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$',
    );

    return passwordRegExp.hasMatch(password);
  }

  bool validatePhone(String value) {
    final validCharacters = RegExp(r'^[0-9]+$');

    return validCharacters.hasMatch(value);
  }

  bool areAllFieldsFilled() {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        repeatPassword.isNotEmpty &&
        birthDate != null &&
        documentNumber.isNotEmpty &&
        phone.isNotEmpty &&
        gender.isNotEmpty &&
        //prefixCellphone.isNotEmpty &&
        imagePaths.isNotEmpty;
  }
}

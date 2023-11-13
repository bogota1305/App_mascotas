import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {

  final LogedUserController logedUserController;

  const ChatScreen({super.key, required this.logedUserController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarDug(
          homeScreen: false,
          barContent: Row(
            children: [
              CircleAvatar(
                 backgroundImage: NetworkImage(
                    'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                  ),
                radius: 20,
              ),
              SizedBox(width: context.spacing.xxs,),
              Text(
                'David',
                style: TextStyle(
                  fontSize: context.text.size.md,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          logedUserController: logedUserController,
        ),
        backgroundColor: DugColors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
              child: ListView(
                children: [
                  SizedBox(height: context.spacing.md,),
                  // Mensaje recibido
                  ReceivedMessage(
                    message: 'Hola, ¿cómo estás?',
                    time: '10:00 AM',
                  ),
                  // Mensaje enviado
                  SentMessage(
                    message: 'Hola, estoy bien. ¿Y tú?',
                    time: '10:05 AM',
                  ),
                  // Mensaje recibido
                  ReceivedMessage(
                    message: 'Bien, gracias.',
                    time: '10:10 AM',
                  ),
                  // Mensaje enviado
                  SentMessage(
                    message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    time: '10:15 AM',
                  ),
                ],
              ),
            ),
          ),
          // Barra inferior
          ChatInputBar(),
        ],
      ),
    );
  }
}

class ReceivedMessage extends StatelessWidget {
  final String message;
  final String time;

  ReceivedMessage({
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.spacing.xxs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: context.spacing.xxs),
            child: CircleAvatar(
                 backgroundImage: NetworkImage(
                        'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                      ),
                radius: 20,
              ),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: DugColors.greyInactive.withOpacity(0.5),
                    ),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.6, // Ancho máximo permitido
                    child: Text(
                      message,
                      style: TextStyle(
                        color: DugColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: TextStyle(
                  color: DugColors.blue,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SentMessage extends StatelessWidget {
  final String message;
  final String time;

  SentMessage({
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.spacing.xxs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: DugColors.blue.withOpacity(0.1),
                    ),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.6, // Ancho máximo permitido
                    child: Text(
                      message,
                      style: TextStyle(
                        color: DugColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: TextStyle(
                  color: DugColors.blue,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
          Padding(
            padding: EdgeInsets.only(bottom: context.spacing.xxs),
            child: CircleAvatar(
                 backgroundImage: NetworkImage(
                        'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                      ),
                radius: 20,
              ),
          ),
        ],
      ),
    );
  }
}

class ChatInputBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.spacing.xs),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.radius.xl),
          topRight: Radius.circular(context.radius.xl),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey, // Color de la sombra
            spreadRadius: 3, // Cuán extendida estará la sombra
            blurRadius: 5, // Cuán desenfocada estará la sombra
            offset: const Offset(5, 3), // Offset de la sombra (horizontal, vertical)
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file),
            color: DugColors.blue,
            onPressed: () {
              // Acción al adjuntar archivo
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: DugColors.greyInactive.withOpacity(0.5),
              ),
              child: Padding(
                padding: EdgeInsets.all(context.spacing.xs),
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Escribe un mensaje...',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: context.spacing.xs,
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: DugColors.blue,
            ),
            child: IconButton(
              icon: Icon(Icons.send),
              color: DugColors.white,
              onPressed: () {
                // Acción al enviar mensaje
              },
            ),
          ),
        ],
      ),
    );
  }
}

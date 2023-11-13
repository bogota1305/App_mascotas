import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_mascotas/login/ui/screens/selection_user_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:app_mascotas/widgets/buttons/principal_button.dart';
import 'package:dots_indicator/dots_indicator.dart';

class PrincipalFuctionsScreen extends StatefulWidget {

  final LogedUserController logedUserController;

  const PrincipalFuctionsScreen({super.key, required this.logedUserController});
  
  @override
  _PrincipalFuctionsScreenState createState() =>
      _PrincipalFuctionsScreenState();
}

class _PrincipalFuctionsScreenState extends State<PrincipalFuctionsScreen> {
  bool showCarousel = false;
  int currentCarouselIndex = 0;
  bool enableButton = false;

  final List<String> imageDescriptions = [
    'Busca y encuentra alternativas de\nalojamiento para tu mascota',
    'Registra tu domicilio, conviertete en\ncuidador y genera ingresos',
    'Chat 24/7 con tu cuidador para estar\npendiente de tu mascota',
    // Agrega más descripciones según tus imágenes
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: DugColors.blue, // Cambia este color al que desees
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 100),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Dug',
                    style: TextStyle(
                      color: DugColors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Spacer(),
              showCarousel
                  ? Column(
                      children: [
                        CarouselSlider(
                          items: [
                            Image.asset(
                                'assets/images/login/Tutorial - Página de inicio.png'),
                            Image.asset(
                                'assets/images/login/Tutorial - Perfil Host.png'),
                            Image.asset(
                                'assets/images/login/Tutorial - Chat.png'),
                            // Añade más imágenes según tus necesidades
                          ],
                          options: CarouselOptions(
                            height: 500,
                            autoPlay: false,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentCarouselIndex = index;
                                if(!enableButton && index == imageDescriptions.length-1){
                                  enableButton = true;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          imageDescriptions[currentCarouselIndex],
                          style: TextStyle(
                            color: DugColors.white,
                            fontSize: context.text.size.lg,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.0),
                        DotsIndicator(
                          dotsCount: imageDescriptions.length,
                          position: currentCarouselIndex.toInt(),
                          decorator: DotsDecorator(
                            size: const Size.square(9.0),
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            activeColor: DugColors.white,
                            color: DugColors.greyInactive.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        PrincipalButton(
                          textColor: enableButton ? DugColors.blue : DugColors.white.withOpacity(0.2),
                          backgroundColor: enableButton ? DugColors.white : DugColors.greyInactive.withOpacity(0.2),
                          onPressed: () {
                            if (enableButton) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SelectionUserScreen(logedUserController: widget.logedUserController,),
                                ),
                              );
                            }
                          },
                          text: 'Continuar',
                        ),
                        SizedBox(height: 30.0),
                      ],
                    )
                  : Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 180),
                          child: Container(
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(150),
                                topRight: Radius.circular(150),
                              ),
                              color: DugColors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 380),
                          child: Container(
                            height: 300,
                            color: DugColors.white,
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: DugColors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            'assets/images/login/start_dogs.png',
                            width: 320,
                            height: 320,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 350),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Tu mejor amigo se',
                                  style: TextStyle(
                                    color: DugColors.black,
                                    fontSize: context.text.size.xxl,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'sentirá como en casa',
                                  style: TextStyle(
                                    color: DugColors.orange,
                                    fontSize: context.text.size.xxl,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: context.spacing.lg,
                                ),
                                Text(
                                  'Busca y encuentra alternativas de',
                                  style: TextStyle(
                                    color: DugColors.greyCard,
                                    fontSize: context.text.size.lg,
                                  ),
                                ),
                                Text(
                                  'alojamiento para tu mascota',
                                  style: TextStyle(
                                    color: DugColors.greyCard,
                                    fontSize: context.text.size.lg,
                                  ),
                                ),
                                SizedBox(
                                  height: context.spacing.xxxl,
                                ),
                                PrincipalButton(
                                  onPressed: () {
                                    setState(() {
                                      showCarousel =
                                          true; 
                                    });
                                  },
                                  text: 'Empezar',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}

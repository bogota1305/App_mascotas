import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/screens/favorites_screen.dart';
import 'package:app_mascotas/home/ui/screens/home_screen.dart';
import 'package:app_mascotas/messages/ui/screens/message_screen.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/profile/ui/screens/guest/guest_profile_screen.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationEvent { home, pet, favorite, message, profile }

class NavigationBloc extends Bloc<NavigationEvent, int> {
  NavigationBloc() : super(0);

  @override
  Stream<int> mapEventToState(NavigationEvent event) async* {
    if (event == NavigationEvent.home) {
      yield 0;
    } else if (event == NavigationEvent.favorite) {
      yield 1;
    } else if (event == NavigationEvent.message) {
      yield 2;
    }
  }
}

class PrincipalScreen extends StatefulWidget {
  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    FavoritesScreen(),
    MessageScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_currentIndex == 0 ? 120 : 80),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: AppBarDug(
            homeScreen: _currentIndex == 0,
            barContent: _currentIndex != 0
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _currentIndex == 1 ? 'Favoritos' : 'Mensajes',
                        style: TextStyle(
                          fontSize: context.text.size.lg,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: context.spacing.xxxs,
                      ),
                      Icon(_currentIndex == 1 ? Icons.favorite : Icons.message),
                      Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => GuestProfileScreen()));
            },
            child: Row(
              children: [
                Text(
                  'Perfil',
                  style: TextStyle(
                    fontSize: context.text.size.xs,
                    fontWeight: FontWeight.bold,
                    color: DugColors.white,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://media.istockphoto.com/id/1200677760/es/foto/retrato-de-apuesto-joven-sonriente-con-los-brazos-cruzados.jpg?b=1&s=612x612&w=0&k=20&c=3OB0hSUgwzlzUh8ek-6Z2z_XwFKnRE7IOHb1oWvoMZ4=',
                  ),
                  radius: 30,
                ),
              ],
            ),
          ),
                    ],
                  )
                : null,
          ),
          shape: ShapeBorder.lerp(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.radius.xl),
            ),
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.radius.xl),
            ),
            1.0,
          ),
          toolbarHeight: 120,
          backgroundColor: DugColors.blue,
        ),
      ),
      backgroundColor: DugColors.white,
      body: _pages[_currentIndex], // Contenido de la página actual
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index; // Cambia la página actual al hacer clic
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            label: 'Home',
            activeIcon: Icon(
              Icons.home,
              size: 35,
              color: DugColors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 35,
            ),
            label: 'Favoritos',
            activeIcon: Icon(
              Icons.favorite,
              size: 35,
              color: DugColors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 35,
            ),
            label: 'Mensages',
            activeIcon: Icon(
              Icons.message,
              size: 35,
              color: DugColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
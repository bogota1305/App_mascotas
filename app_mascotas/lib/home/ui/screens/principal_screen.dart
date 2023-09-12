import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/ui/screens/favorites_screen.dart';
import 'package:app_mascotas/home/ui/screens/home_screen.dart';
import 'package:app_mascotas/home/ui/screens/message_screen.dart';
import 'package:app_mascotas/home/ui/screens/pets_screen.dart';
import 'package:app_mascotas/home/ui/screens/guest_profile_screen.dart';
import 'package:app_mascotas/home/ui/widgets/app_bar_dug.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
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
    } else if (event == NavigationEvent.pet) {
      yield 2;
    } else if (event == NavigationEvent.message) {
      yield 3;
    } else if (event == NavigationEvent.profile) {
      yield 4;
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
    PetScreen(),
    MessageScreen(),
    GuestProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          title: AppBarDug(
            homeScreen: true,
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
          /*BottomNavigationBarItem(
            icon: Icon(
              Icons.pets,
              size: 35,
            ),
            label: 'Mascotas',
            activeIcon: Icon(
              Icons.pets,
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
          ),*/
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 35,
            ),
            label: 'Configuración',
            activeIcon: Icon(
              Icons.settings,
              size: 35,
              color: DugColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
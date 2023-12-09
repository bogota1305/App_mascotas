import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/extensions/radius_extension.dart';
import 'package:app_mascotas/home/controller/request_housing_users_controller.dart';
import 'package:app_mascotas/home/controller/search_controller.dart';
import 'package:app_mascotas/home/ui/screens/favorites_screen.dart';
import 'package:app_mascotas/home/ui/screens/home_screen.dart';
import 'package:app_mascotas/login/controller/loged_user_controller.dart';
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
  final bool housingUser;
  final LogedUserController logedUserController;

  const PrincipalScreen({
    super.key,
    required this.housingUser,
    required this.logedUserController, 
  });

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  int _currentIndex = 0;
  SearchDateController searchController = SearchDateController();
  RequestsHousingUsersController requestsHousingUsersController =
      RequestsHousingUsersController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(
        housingUser: widget.housingUser,
        searchController: searchController,
        logedUserController: widget.logedUserController,
        requestsHousingUsersController: requestsHousingUsersController,
      ),
      FavoritesScreen(
        housingUser: widget.housingUser,
        logedUserController: widget.logedUserController,
        favoritos: widget.logedUserController.favoritos,
      ),
      MessageScreen(
        logedUserController: widget.logedUserController,
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_currentIndex == 0 ? 120 : 80),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: AppBarDug(
            homeScreen: _currentIndex == 0,
            barContent: _currentIndex != 0
                ? AppBarNotPrincipalScreen(
                    currentIndex: _currentIndex,
                    logedUserController: widget.logedUserController,
                    housingUser: widget.housingUser)
                : null,
            housingUser: widget.housingUser,
            searchController: searchController,
            logedUserController: widget.logedUserController,
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
          backgroundColor:
              widget.housingUser ? DugColors.orange : DugColors.blue,
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
        items: [
          const BottomNavigationBarItem(
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
              widget.housingUser ? Icons.timelapse_rounded : Icons.favorite,
              size: 35,
            ),
            label: widget.housingUser ? 'Disponibilidad' : 'Favoritos',
            activeIcon: Icon(
              widget.housingUser ? Icons.timelapse_rounded : Icons.favorite,
              size: 35,
              color: DugColors.blue,
            ),
          ),
          const BottomNavigationBarItem(
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

class AppBarNotPrincipalScreen extends StatelessWidget {
  final bool housingUser;
  final LogedUserController logedUserController;

  const AppBarNotPrincipalScreen({
    super.key,
    required int currentIndex,
    required this.logedUserController,
    required this.housingUser,
  }) : _currentIndex = currentIndex;

  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _currentIndex == 1
              ? housingUser
                  ? 'Disponibilidad'
                  : 'Favoritos'
              : 'Mensajes',
          style: TextStyle(
            fontSize: context.text.size.lg,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: context.spacing.xxxs,
        ),
        Icon(_currentIndex == 1
            ? housingUser
                ? Icons.timelapse_outlined
                : Icons.favorite
            : Icons.message),
        Spacer(),
        InkWell(
          onTap: () {
            if (logedUserController.user.id != 'Guest') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GuestProfileScreen(
                    ownProfile: true,
                    logedUserController: logedUserController,
                  ),
                ),
              );
            }
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
                backgroundImage: NetworkImage( logedUserController.user.fotos.first,),
                radius: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'dart:convert';
import 'package:app_mascotas/home/repository/user_home_repository.dart';
import 'package:app_mascotas/login/models/user_model.dart';
import 'package:http/http.dart' as http;

class UsersListController {
  
   Future<List<User>> getCuidadores() async {
    List<User> usersData = [];
    List<User> cuidadores = [];
    final userHomeRepository = UserHomeRepository();
    try {
      usersData = await userHomeRepository.getCuidadores();
      for(int i = 0; i < usersData.length; i++){
        if(usersData[i].tipo == 'Cuidador'){
          cuidadores.add(usersData[i]);
        }
      }
      
    } catch (e) {
      print('Error al obtener cuidadores: $e');
    }

    return cuidadores;
  }

}

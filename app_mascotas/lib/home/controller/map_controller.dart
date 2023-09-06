import 'package:app_mascotas/home/model/map_model.dart';

class MapController {

  void setMapVisivility(MapModel map){
    map = map.copyWith(visibleMap: map.visibleMap ? false : true) ;
  }
  
}
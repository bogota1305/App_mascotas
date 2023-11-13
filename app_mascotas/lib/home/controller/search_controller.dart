import 'package:app_mascotas/home/model/search_model.dart';

class SearchController {
  late Search _search;

  SearchController() {
    _search = Search(
      tipoDeServicio: 'Fecha',
      fechaDeInicio: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      fechaDeFin: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+1, 23, 59, 59),
      horaDeInicio: 0,
      horaDeFin: 0,
      ordenamiento: '\$ Noche Bajo'
    );
  }

  Search get search => _search;

  set search(Search newSearch) {
    _search = newSearch;
  }

}

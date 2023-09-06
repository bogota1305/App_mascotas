import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

enum CarouselEvent { next, previous }

class CarouselBloc extends Bloc<CarouselEvent, int> {
  CarouselBloc() : super(0);

  @override
  Stream<int> mapEventToState(CarouselEvent event) async* {
    if (event == CarouselEvent.next) {
      yield state + 1;
    } else if (event == CarouselEvent.previous) {
      yield state - 1;
    }
  }
}

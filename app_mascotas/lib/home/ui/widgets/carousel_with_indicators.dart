import 'package:app_mascotas/home/bloc/carousel_bloc.dart';
import 'package:app_mascotas/home/ui/widgets/housing_or_request_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselWithIndicators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CarouselBloc, int>(
          builder: (context, currentIndex) {
            return CarouselSlider(
              items: _items.map((item) {
                return Column(
                  children: [
                    HousingOrRequestCard(
                      name: currentIndex == 0 ? item.name : _items2[2].name,
                      image: currentIndex == 0 ? item.image : _items2[2].image,
                      housing: currentIndex == 0 ? item.housing : _items2[2].housing,
                      color: currentIndex == 0 ? item.color : _items2[2].color,
                    ),
                    HousingOrRequestCard(
                      name: currentIndex == 0 ? _items2[1].name : _items2[3].name,
                      image: currentIndex == 0 ? _items2[1].image : _items2[3].image,
                      housing: currentIndex == 0 ? _items2[1].housing : _items2[3].housing,
                      color: currentIndex == 0 ? _items2[1].color : _items2[3].color,
                    ),
                  ],
                );
              }).toList(),
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  if (currentIndex < index) {
                    context.read<CarouselBloc>().add(CarouselEvent.next);
                  } else if (currentIndex > index) {
                    context.read<CarouselBloc>().add(CarouselEvent.previous);
                  }
                },
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                height: 270,
              ),
            );
          },
        ),
        BlocBuilder<CarouselBloc, int>(
          builder: (context, currentIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _items.map((item) {
                int index = _items.indexOf(item);
                return Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

List<HousingOrRequestCard> _items = [
  HousingOrRequestCard(
    name: 'Item 1',
    image: 'image_url_1',
    housing: true,
    color: DugColors.purple,
  ),
  HousingOrRequestCard(
    name: 'Item 2',
    image: 'image_url_2',
    housing: false,
    color: Colors.green,
  ),
];

List<HousingOrRequestCard> _items2 = [
  HousingOrRequestCard(
    name: 'Item 1',
    image: 'image_url_1',
    housing: true,
    color: DugColors.purple,
  ),
  HousingOrRequestCard(
    name: 'Item 2',
    image: 'image_url_2',
    housing: false,
    color: DugColors.orange,
  ),
  HousingOrRequestCard(
    name: 'Item 3',
    image: 'image_url_1',
    housing: true,
    color: DugColors.yellow,
  ),
  HousingOrRequestCard(
    name: 'Item 4',
    image: 'image_url_2',
    housing: false,
    color: DugColors.green,
  ),
];

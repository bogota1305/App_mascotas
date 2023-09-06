import 'package:app_mascotas/profile/ui/widget/housing/housing_or_request_card.dart';
import 'package:app_mascotas/theme/colors/dug_colors.dart';
import 'package:flutter/material.dart';

class HousingAvailable extends StatelessWidget {
  const HousingAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
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
        ],
      ),
    );
  }
}

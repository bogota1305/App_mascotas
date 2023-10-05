import 'package:app_mascotas/extensions/dimension_extension.dart';
import 'package:app_mascotas/theme/text/text_size.dart';
import 'package:flutter/material.dart';

class RegistrationTextBox extends StatelessWidget {
  final String title;
  final Widget textBox;

  const RegistrationTextBox({
    super.key,
    required this.title,
    required this.textBox,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: context.text.size.sm,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: context.spacing.xs),
        textBox,
      ],
    );
  }
}
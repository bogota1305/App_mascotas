import 'package:flutter/material.dart';

extension TextTheme on BuildContext {
  DugTextStyle get text => DugTextStyle(
        size: const TextSizes(),
      );
}

class DugTextStyle {
  final TextSizes size;

  DugTextStyle({
    required this.size,
  });
}

class TextSizes {
  ///12.0
  final double xxs;
  ///14.0
  final double xs;
  ///16.0
  final double sm;
  ///18.0
  final double md;
  ///20.0
  final double lg;
  ///24.0
  final double xl;
  ///28.0
  final double xxl;
  ///32.0
  final double xxxl;

  const TextSizes({
    this.xxs = 12.0,
    this.xs = 14.0,
    this.sm = 16.0,
    this.md = 18.0,
    this.lg = 20.0,
    this.xl = 24.0,
    this.xxl = 28.0,
    this.xxxl = 32.0,
  });
}

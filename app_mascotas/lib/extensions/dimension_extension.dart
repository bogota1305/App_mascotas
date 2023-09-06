import 'package:flutter/material.dart';

extension Spacing on BuildContext {
  Dimensions get spacing => const Dimensions();
}

class Dimensions {
  ///4.0
  final double xxxs;
  ///8.0
  final double xxs;
  ///12.0
  final double xs;
  ///16.0
  final double sm;
  ///20.0
  final double md;
  ///24.0
  final double lg;
  ///28.0
  final double xl;
  ///32.0
  final double xxl;
  ///36.0
  final double xxxl;

  const Dimensions({
    this.xxxs = 4.0,
    this.xxs = 8.0,
    this.xs = 12.0,
    this.sm = 16.0,
    this.md = 20.0,
    this.lg = 24.0,
    this.xl = 28.0,
    this.xxl = 32.0,
    this.xxxl = 36.0,
  });
}

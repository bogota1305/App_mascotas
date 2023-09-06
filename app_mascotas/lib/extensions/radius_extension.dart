import 'package:flutter/material.dart';

extension SumerRadius on BuildContext {
  RadiusValues get radius => const RadiusValues();
}

class RadiusValues {
  ///4.0
  final double xs;
  ///8.0
  final double sm;
  ///12.0
  final double md;
  ///16.0
  final double lg;
  ///20.0
  final double xl;
  ///40.0
  final double xxxl;

  const RadiusValues({
    this.xs = 4.0,
    this.sm = 8.0,
    this.md = 12.0,
    this.lg = 16.0,
    this.xl = 20.0,
    this.xxxl = 40.0,
  });
}

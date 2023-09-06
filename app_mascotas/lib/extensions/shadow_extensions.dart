import 'package:flutter/material.dart';

extension ShadowExtension on BuildContext {
  List<BoxShadow>? get containerShadow => [
    const BoxShadow(
      color: Color.fromRGBO(53, 53, 53, 0.04),
      blurRadius: 10,
      offset: Offset(2, 4),
    ),
    const BoxShadow(
      color: Color.fromRGBO(180, 180, 180, 0.18),
      spreadRadius: -4,
      blurRadius: 13,
      offset: Offset(3, 4),
    ),
  ];
}
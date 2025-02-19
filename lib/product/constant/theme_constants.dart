// Create a theme constants class with singleton method

import 'package:flutter/material.dart';

class ThemeConstants {
  static final ThemeConstants _singleton = ThemeConstants._internal();

  factory ThemeConstants() {
    return _singleton;
  }

  ThemeConstants._internal();

  Gradient get getBackgroundLinearGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff14133c),
          Color(0xff000000),
          Color(0xff000000),
        ],
        stops: [0.0, 0.5, 1.0],
      );

  Gradient get getLottieBackgroundLinearGradient => LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          const Color(0xff391f67).withOpacity(0.5),
          const Color(0xff441b60).withOpacity(0.9),
          const Color(0xff4c1350).withOpacity(0.8),
          const Color(0xff3e1b51).withOpacity(0),
          const Color(0xff3e1b51).withOpacity(0),
          const Color(0xff3e1b51).withOpacity(0),
        ],
        stops: const [0.05, 0.2, 0.3, 0.65, 0.7, 1],
      );
}

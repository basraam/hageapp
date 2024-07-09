import 'package:flutter/material.dart';

class BColors {
  BColors._();

  static const Color primaryColor = Color(0xFF76B852);
  static const Color secondaryColor = Color(0xFF8DC26F);

  //create a gradient color from primary and secondary color
  static const LinearGradient gradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, secondaryColor],
  );
  //create 2 color primary and secondary colors for text
  static const Color primaryTextColor = Color(0xFF212121);
  static const Color secondaryTextColor = Color(0xFF757575);

  static const Color white = Color(0xFFFFFFFF);
  static const Color light = Color(0xFFF5FFFA);
  static const Color dark = Color(0xFF212121);
  static const Color darkgrey = Color(0xFF3A3838);

  //create a color for background
  static const Color backgroundColor = Color(0xFFFAFAFA);

  //create a color for error
  static const Color errorColor = Color(0xFFD32F2F);

  //create a color for success
  static const Color successColor = Color(0xFF388E3C);

  //create a color for warning
  static const Color warningColor = Color(0xFFFFA000);

  //create a color for info
  static const Color infoColor = Color(0xFF1976D2);
}

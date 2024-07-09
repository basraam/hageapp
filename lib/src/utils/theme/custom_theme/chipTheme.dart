import 'package:flutter/material.dart';

import '../../constants/Colors.dart';

class BChipTheme {
  BChipTheme._();

  //light theme
  static ChipThemeData lightChipTheme = ChipThemeData(
      disabledColor: Colors.grey.withOpacity(0.4),
      labelStyle: const TextStyle(color: Colors.black),
      selectedColor: BColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      brightness: Brightness.light,
      checkmarkColor: Colors.white);

  //dark theme
  static ChipThemeData darkChipTheme = ChipThemeData(
      disabledColor: Colors.grey.withOpacity(0.4),
      labelStyle: const TextStyle(color: Colors.white),
      selectedColor:   BColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      brightness: Brightness.dark,
      checkmarkColor: Colors.white);
}

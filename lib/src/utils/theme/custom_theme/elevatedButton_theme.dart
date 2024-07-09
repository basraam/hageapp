import 'package:flutter/material.dart';
import '../../constants/Colors.dart';

class BElevatedButtonTheme {
  BElevatedButtonTheme._();

  //light theme

  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor:BColors.primaryColor,
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.grey,
        side: const BorderSide(color: BColors.secondaryColor),
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        textStyle: const TextStyle(
          fontFamily: 'Tw Cen MT',
            fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        )),
  );

  //dark theme

  static ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: BColors.primaryColor,
        disabledForegroundColor: Colors.grey,
        disabledBackgroundColor: Colors.grey,
        side: const BorderSide(color: BColors.secondaryColor),
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        textStyle: const TextStyle(
            fontFamily: 'Tw Cen MT',
            fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        )),
  );
}

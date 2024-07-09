import 'package:flutter/material.dart';

import '../../constants/Colors.dart';

class BOutlinedButtonTheme {
  BOutlinedButtonTheme._();

  //light theme
  static OutlinedButtonThemeData lightOutlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.black,
        side: const BorderSide(color: BColors.primaryColor),
        textStyle: const TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'Tw Cen MT',),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        )),
  );

  //dark theme
  static OutlinedButtonThemeData darkOutlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        side: const BorderSide(color: BColors.primaryColor),
        textStyle: const TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Tw Cen MT',),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        )),
  );
}

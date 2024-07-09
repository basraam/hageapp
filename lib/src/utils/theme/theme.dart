import 'package:flutter/material.dart';
import 'package:hage_mobile_app/src/utils/theme/custom_theme/AppBar_theme.dart';
import 'package:hage_mobile_app/src/utils/theme/custom_theme/Textfield_theme.dart';
import 'package:hage_mobile_app/src/utils/theme/custom_theme/bottomSheet_theme.dart';
import 'package:hage_mobile_app/src/utils/theme/custom_theme/checkBoxTheme.dart';
import 'package:hage_mobile_app/src/utils/theme/custom_theme/chipTheme.dart';
import 'package:hage_mobile_app/src/utils/theme/custom_theme/elevatedButton_theme.dart';
import 'package:hage_mobile_app/src/utils/theme/custom_theme/outlinedButton_theme.dart';
import 'package:hage_mobile_app/src/utils/theme/custom_theme/textTheme.dart';

import '../constants/Colors.dart';

class BAppTheme {
  BAppTheme._();

//light theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Tw Cen MT',
    brightness: Brightness.light,
    primaryColor: BColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: BTextTheme.lightTextTheme,
    chipTheme: BChipTheme.lightChipTheme,
    appBarTheme: BAppbarTheme.lightAppBarTheme,
    checkboxTheme: BCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: BBottomsheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: BElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: BOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: BTextfieldTheme.lightTextfieldTheme,
  );

//dark theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Tw Cen MT',
    brightness: Brightness.dark,
    primaryColor: BColors.primaryColor,
    scaffoldBackgroundColor: Colors.black,
    textTheme: BTextTheme.darkTextTheme,
    chipTheme: BChipTheme.darkChipTheme,
    appBarTheme: BAppbarTheme.darkAppBarTheme,
    checkboxTheme: BCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: BBottomsheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: BElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: BOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: BTextfieldTheme.darkTextfieldTheme,
  );
}

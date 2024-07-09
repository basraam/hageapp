import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/bindings/bindings_controller.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/login/login.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/onBoarding/onBoarding.dart';
import 'package:hage_mobile_app/src/utils/constants/Colors.dart';
import 'package:hage_mobile_app/src/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: BAppTheme.lightTheme,
      darkTheme: BAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: GeneralBindings(),
      // Replace with your initial bindings if needed
      home: Scaffold(
        backgroundColor: BColors.primaryColor,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: BAppTheme.lightTheme,
//       darkTheme: BAppTheme.darkTheme,
//       themeMode: ThemeMode.system,
//       initialBinding: GeneralBindings(),
//       home: const Scaffold(backgroundColor: BColors.primaryColor, body: Center( child: CircularProgressIndicator(color: Colors.white,)),
//       ),
//     );
//   }
// }

  }
}

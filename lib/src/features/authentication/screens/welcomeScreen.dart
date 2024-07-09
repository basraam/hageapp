import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/Signup/signup.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/login/login.dart';
import 'package:hage_mobile_app/src/utils/constants/Colors.dart';
import '../../../utils/constants/BSizes.dart';
import '../../../utils/constants/Strings.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/helpers/helper_functions.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: BSizes.appBarHeight),

            ///Image:
            Image(
              image: const AssetImage(BImages.welcomeImage),
              width: BHelperFunctions.screenWidth(),
            ),

            ///Title & SubTitle:
            ///
             Text(BString.welcome,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Tw Cen MT',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: dark? Colors.white70:Colors.black38)),

            const SizedBox(height: BSizes.appBarHeight),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => (Get.to(() => const LoginScreen())),
                  child: const Text(BString.login),
                )),
          ],
        ),
      ),
    );
  }
}

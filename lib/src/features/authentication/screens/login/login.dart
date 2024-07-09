import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/common/styles/spacing_styles.dart';
import 'package:hage_mobile_app/src/common/widgets/login_signup/loginDevider.dart';
import 'package:hage_mobile_app/src/common/widgets/login_signup/loginFooter.dart';
import 'package:hage_mobile_app/src/features/authentication/controllers/login/login_controller.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/login/widgets/loginForm.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/login/widgets/loginHeader.dart';
import 'package:hage_mobile_app/src/utils/constants/BSizes.dart';
import 'package:hage_mobile_app/src/utils/constants/Strings.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: spacingStyles.paddingWithAppBarHeight,
          child: Column(children: [

            ///Header: logo, title, subtitle:
            const SizedBox(height: BSizes.appBarHeight),

            loginHeader(),

            ///Login Form:

            loginForm(),


            const SizedBox(height: BSizes.spaceBtwSections),


            ///Footer
              //loginFooter(),


          ]),
        ),
      ),
    );
  }
}




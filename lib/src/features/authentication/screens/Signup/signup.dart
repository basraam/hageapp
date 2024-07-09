import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/Signup/widgets/signupForm.dart';

import '../../../../common/widgets/login_signup/loginDevider.dart';
import '../../../../common/widgets/login_signup/loginFooter.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/BSizes.dart';
import '../../../../utils/constants/Strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class signupScreen extends StatelessWidget {
  const signupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(BSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ///Title:
              Text(
                BString.signUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: BSizes.spaceBtwSections),

              ///Signup Form:
              const signupForm(),

              // const SizedBox(height: BSizes.spaceBtwSections),

              // ///Devider
              // loginFormDevider(deviderText: BString.orSignInWith.capitalize!),
              //
              // const SizedBox(height: BSizes.spaceBtwSections),
              //
              // ///Google button
              // const loginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

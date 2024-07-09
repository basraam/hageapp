import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/authentication/controllers/forgot_password/forgotPassword_controller.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/login/login.dart';
import 'package:hage_mobile_app/src/utils/constants/BSizes.dart';
import 'package:hage_mobile_app/src/utils/constants/Strings.dart';
import 'package:hage_mobile_app/src/utils/constants/images.dart';

import '../../../../utils/helpers/helper_functions.dart';

class resetPassword extends StatelessWidget {
  const resetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(BSizes.spaceBtwInputFields),
        child: Column(
          children: [
            ///Image:
            Image(
              image: const AssetImage(BImages.received),
              width: BHelperFunctions.screenWidth() * 0.6,
            ),

            ///Title & SubTitle:
            Text(email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: BSizes.spaceBtwSections),
            Text(BString.resetPassTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: BSizes.spaceBtwItems),
            Text(BString.resetPassSubtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: BSizes.spaceBtwSections),

            ///continue button:
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.off(() => const LoginScreen()),
                    child: const Text(BString.hagaag))),
            const SizedBox(height: BSizes.spaceBtwItems),
            SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: ()=> ForgetPasswordController.instance.resendPasswordResetEmail(email), child: const Text(BString.resend))),
          ],
        ),
      ),
    );
  }
}

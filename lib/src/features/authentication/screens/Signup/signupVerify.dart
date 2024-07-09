import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/data/reposotories/Authentication/authentication_repository.dart';
import 'package:hage_mobile_app/src/utils/constants/Strings.dart';
import 'package:hage_mobile_app/src/utils/constants/images.dart';
import 'package:hage_mobile_app/src/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/BSizes.dart';
import '../../controllers/signup/verify_email_controller.dart';

class EmailVerifyScreen extends StatelessWidget {
  const EmailVerifyScreen({super.key, this.email});

  final String? email;
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BSizes.spaceBtwSections),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///Image:
              Image(
                image: const AssetImage(BImages.newMessage),
                width: BHelperFunctions.screenWidth() * 0.6,
              ),

              ///Title & SubTitle:
              ///
              const SizedBox(height: BSizes.spaceBtwSections),
              Text(
                BString.verifyTitle,
                style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: BSizes.spaceBtwItems),
              Text(
                  email??'',
                style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: BSizes.spaceBtwItems),
              Text(
                BString.verifyEmailBody,
                style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: BSizes.spaceBtwSections),

              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.checkEmailVerificationStatus(),
                      child: const Text(BString.siiWad))),
              const SizedBox(height: BSizes.spaceBtwItems),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.sendEmailVerification(), child: const Text(BString.resend))),
            ],
          ),
        ),
      ),
    );
  }
}

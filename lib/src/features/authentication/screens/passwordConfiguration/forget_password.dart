import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/passwordConfiguration/reset_password.dart';
import 'package:hage_mobile_app/src/utils/constants/BSizes.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/Strings.dart';
import '../../../../utils/validations/validators.dart';
import '../../controllers/forgot_password/forgotPassword_controller.dart';

class forgetPassword extends StatelessWidget {
  const forgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(BSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///Headings:
            const SizedBox(height: BSizes.spaceBtwSections),

            ///Forgot Title:
            Text(BString.forgotpassTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.start),

            const SizedBox(height: BSizes.spaceBtwItems),

            ///ForgotBody:
            Text(BString.forgotsubTitle,
                style: Theme.of(context).textTheme.labelLarge),

            const SizedBox(height: BSizes.spaceBtwSections * 2),

            ///Text field:
            Form(
              key: controller.forgetPasswordFormKey,
                child: TextFormField(
                    controller: controller.email,
                    validator: BValidator.validateEmail,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: BString.email))),

            const SizedBox(height: BSizes.spaceBtwSections),

            ///submit Button:
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.sendPasswordResetEmail(),
                    child: Text(
                      BString.submit,
                    ))),
          ],
        ),
      ),
    );
  }
}

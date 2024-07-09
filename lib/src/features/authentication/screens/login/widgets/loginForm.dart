import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/Signup/signup.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/passwordConfiguration/forget_password.dart';
import 'package:hage_mobile_app/src/utils/validations/validators.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../navigation_menu.dart';
import '../../../../../common/widgets/login_signup/loginDevider.dart';
import '../../../../../utils/constants/BSizes.dart';
import '../../../../../utils/constants/Strings.dart';
import '../../../controllers/login/login_controller.dart';

class loginForm extends StatelessWidget {
  const loginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.Login_FormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: BSizes.spaceBtwSections),
        child: Column(children: [
          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => BValidator.validateEmail(value),
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: BString.email),
          ),
          const SizedBox(height: BSizes.spaceBtwInputFields),

          /// Password
          Obx(
            () => TextFormField(
              validator: (value) =>
                  BValidator.validateEmptyText("Password", value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: BString.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                  onPressed: () {
                    controller.hidePassword.value =
                        !controller.hidePassword.value;
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: BSizes.spaceBtwInputFields / 2),

          /// Remember Me & Forget Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Remember Me
              Row(
                children: [
                  Obx(() => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) => controller.rememberMe.value =
                          !controller.rememberMe.value)),
                  const Text(BString.rememberMe),
                  //
                ],
              ),

              /// Forget Password
              TextButton(
                  onPressed: () => Get.to(() => const forgetPassword()),
                  child: const Text(BString.forgotpass)),
            ],
          ),

          const SizedBox(height: BSizes.spaceBtwSections),

          /// Sign In Button

          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.emailAndPasswordSignIn(),
                  child: const Text(BString.login))),

          const SizedBox(height: BSizes.spaceBtwItems),
          // Create Account Button
          ///Divider

          loginFormDevider(deviderText: BString.orSignInWith.capitalize!,),

          const SizedBox(height: BSizes.spaceBtwItems),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
                onPressed: () => Get.to(() => const signupScreen()),
                child: const Text(BString.createAccount)),
          ),
        ]),
      ),
    );
  }
}

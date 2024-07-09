import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/BSizes.dart';
import '../../../../../utils/constants/Strings.dart';
import '../../../../../utils/validations/validators.dart';
import '../../../controllers/signup/signup_controller.dart';
import '../signupVerify.dart';
import 'ROleDropDown_container.dart';
import 'TermsOfUse_checkbox.dart';

class signupForm extends StatelessWidget {
  const signupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signup_Formkey,

      child: Column(
        children: [
          Row(
            children: [
              ///fullname
              Expanded(
                child: TextFormField(
                  controller: controller.fullName,
                  validator: (value) => BValidator.validateEmptyText('Magacaaga oo saddexan', value),
                  expands: false,
                  decoration: const InputDecoration(labelText: BString.fullName, prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: BSizes.spaceBtwInputFields),

              ///username
              Expanded(
                child: TextFormField(
                  controller: controller.username,
                  validator: (value) => BValidator.validateEmptyText('Magacaaga oo saddexan', value),
                  expands: false,
                  decoration: const InputDecoration(labelText: BString.username, prefixIcon: Icon(Iconsax.user_edit)),
                ),
              ),
            ],
          ),

          const SizedBox(height: BSizes.spaceBtwInputFields),

          /// phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => BValidator.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(labelText: BString.phoneNumber, prefixIcon: Icon(Iconsax.call)
            ),
          ),
          const SizedBox(height: BSizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => BValidator.validateEmail(value),
            decoration: const InputDecoration(labelText: BString.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: BSizes.spaceBtwInputFields),

          ///Password
        Obx( () =>  TextFormField(
            validator: (value) => BValidator.validatePassword(value),
            controller: controller.password,
            obscureText: controller.hidePassword.value,
            decoration:  InputDecoration(
                labelText: BString.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                  onPressed: () {
                    controller.hidePassword.value = !controller.hidePassword.value;
                  },
                ),
            ),
          ),
    ),

          const SizedBox(height: BSizes.spaceBtwInputFields),

          ///Role
          RoleField(controller: controller),

          // ///education level
          // TextFormField(
          //   controller: controller.level,
          //   validator: (value) => BValidator.validateEmptyText('macalin, arday ama marti',value),
          //   expands: false,
          //   decoration: const InputDecoration(labelText: BString.level, prefixIcon: Icon(Iconsax.book)),
          // ),

          const SizedBox(height: BSizes.spaceBtwInputFields),

          const TermsOfUse(),
           const SizedBox(height: BSizes.spaceBtwSections),

          ///Sign up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(BString.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}

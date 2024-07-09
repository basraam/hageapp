import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../data/reposotories/Authentication/authentication_repository.dart';
import '../../../../../utils/constants/BSizes.dart';
import '../../../../../utils/constants/Strings.dart';
import '../../../../../utils/validations/validators.dart';
import '../../../../authentication/controllers/signup/signup_controller.dart';
import '../../../../authentication/screens/Signup/widgets/ROleDropDown_container.dart';
import '../../../controllers/user_controller.dart';

class EditUserForm extends StatelessWidget {
  const EditUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Form(
      //key: controller.Edituser_Formkey,
      child: Column(
        children: [
          const SizedBox(height: BSizes.spaceBtwInputFields),

          Row(
            children: [
              /// fullname
              Expanded(
                child: TextFormField(
                 // controller: controller.fullname,
                  validator: (value) => BValidator.validateEmptyText(
                      'Magacaaga oo saddexan', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: BString.fullName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: BSizes.spaceBtwInputFields),

              /// username
              Expanded(
                child: TextFormField(
                 // controller: controller.username,
                  validator: (value) => BValidator.validateEmptyText(
                      'Magacaaga oo saddexan', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: BString.username,
                      prefixIcon: Icon(Iconsax.user_edit)),
                ),
              ),
            ],
          ),

          const SizedBox(height: BSizes.spaceBtwInputFields),

          /// phone number
          TextFormField(
            //controller: controller.phone,
            validator: (value) => BValidator.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: BString.phoneNumber, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(height: BSizes.spaceBtwInputFields),

          /// email
          TextFormField(
            //controller: controller.email,
            validator: (value) => BValidator.validateEmail(value),
            decoration: const InputDecoration(
                labelText: BString.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: BSizes.spaceBtwInputFields),

          /// password
          // Obx(
          //       () => TextFormField(
          //     validator: (value) => BValidator.validatePassword(value),
          //     controller: controller.password,
          //     obscureText: controller.hidePassword.value,
          //     decoration: InputDecoration(
          //       labelText: BString.password,
          //       prefixIcon: const Icon(Iconsax.password_check),
          //       suffixIcon: IconButton(
          //         icon: Icon(
          //           controller.hidePassword.value
          //               ? Iconsax.eye_slash
          //               : Iconsax.eye,
          //         ),
          //         onPressed: () {
          //           controller.hidePassword.value =
          //           !controller.hidePassword.value;
          //         },
          //       ),
          //     ),
          //   ),
          // ),

          const SizedBox(height: BSizes.spaceBtwInputFields),

          /// Role
          // RoleField(
          //   controller: controller.level,
          // ),

          const SizedBox(height: BSizes.spaceBtwInputFields),

          /// Save Changes Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
               // controller.updateUserInfo();
              },
              child: const Text("Save Changes"),
            ),
          ),

          const SizedBox(height: BSizes.spaceBtwSections * 2),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 150,
                child: OutlinedButton(
                    onPressed: () =>
                        AuthenticationRepository.instance.logout(),
                    child: const Text(BString.logout)),
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom().copyWith(
                    backgroundColor:
                    const WidgetStatePropertyAll<Color>(Colors.red),
                  ),
                  onPressed: () =>
                      AuthenticationRepository.instance.logout(),
                  child: const Text("Delete Account"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
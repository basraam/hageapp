import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/utils/constants/Strings.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/BSizes.dart';
import '../../../../utils/validations/validators.dart';
import '../../controllers/user_controller.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User')),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BSizes.defaultSpace),
          child:
          Form(
            key:
            controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: BValidator.validateEmail,
                  decoration: const InputDecoration (
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: BString.email),
                ),
                const SizedBox (height: BSizes.spaceBtwInputFields),

                /// Password
                Obx(
                      () =>
                      TextFormField(
                        obscureText: controller.hidePassword.value,
                        controller: controller.verifyPassword,
                        validator: (value) =>
                            BValidator.validateEmptyText('Password', value),
                        decoration: InputDecoration(
                          labelText: BString.password,
                          prefixIcon: const Icon (Iconsax.password_check),
                          suffixIcon: IconButton(
                            onPressed: () =>
                            controller.hidePassword.value = !controller
                                .hidePassword.value,
                            icon: const Icon(Iconsax.eye_slash),
                          ), // IconButton
                        ), // InputDecoration
                      ), // TextFormField
                ), // Obx
                const SizedBox (height: BSizes.spaceBtwSections),

                /// LOGIN Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () =>
                      controller.reAuthenticateEmailAndPasswordUser(),
                      child: const Text('Verify')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
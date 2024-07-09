import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/AppBar/custom_AppBar.dart';
import '../../../../../../utils/constants/BSizes.dart';
import '../../../../../../utils/constants/Strings.dart';
import '../../../../../../utils/validations/validators.dart';
import '../../../../controllers/changingControllers/UpdateUsernameController.dart';

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUsernameController());
    return Scaffold(
      /// Custom Appbar
        appBar: BAppBar(
          showBackArrow: true,
          title: Text('Baddel naanaystaada', style: Theme.of(context).textTheme.headlineSmall),
        ),
// TAppBar
        body:
        Padding(
          padding: const EdgeInsets.all(BSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Headings
              Text(
                'ku buuxi naanaystaada, haday labo magac tahay ha u dhaxaysiin meel banaan ee isku dhaji.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
// Text
              const SizedBox (height: BSizes.spaceBtwSections),
              /// Text field and Button
              Form(
                key: controller.updateUserNameFormKey,
                child:
                TextFormField(
                  controller: controller.userName,
                  validator: (value) => BValidator.validateEmptyText('UserName', value),
                  expands: false,
                  decoration: const InputDecoration (labelText: BString.username, prefixIcon: Icon(Iconsax.user)),
                ), // TextFormField

// Column, Form
              ),
              const SizedBox (height: BSizes.spaceBtwSections),
              /// Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child: Text('Save'),
                ), // ElevatedButton
              ), // SizedBox
            ], // Column
          ), // Padding
        )// Scaffold
    );
  }
}
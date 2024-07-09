import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/personalization/controllers/changingControllers/updateBioController.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/AppBar/custom_AppBar.dart';
import '../../../../../../utils/constants/BSizes.dart';
import '../../../../../../utils/constants/Strings.dart';
import '../../../../../../utils/validations/validators.dart';
import '../../../../controllers/changingControllers/updateName_controller.dart';

class ChangeBio extends StatelessWidget {
  const ChangeBio({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateBioController());
    return Scaffold(
      /// Custom Appbar
        appBar: BAppBar(
          showBackArrow: true,
          title: Text('Change Bio', style: Theme.of(context).textTheme.headlineSmall),
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
                'Bio waa macluumaadka uu arki karo qof kasta oo soo gala ciwaankaada..',
                style: Theme.of(context).textTheme.labelMedium,
              ),
// Text
              const SizedBox (height: BSizes.spaceBtwSections),
              /// Text field and Button
              Form(
                key: controller.updateBioFormKey,
                child:
                TextFormField(
                  showCursor: true,
                  controller: controller.Bio,
                  validator: (value) => BValidator.validateEmptyText('Bio', value),
                  expands: false,
                  decoration: const InputDecoration (labelText:"Bio", prefixIcon: Icon(Iconsax.text)),
                ), // TextFormField

// Column, Form
              ),
              const SizedBox (height: BSizes.spaceBtwSections),
              /// Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.updateBio(),
                  child: Text('Save'),
                ), // ElevatedButton
              ), // SizedBox
            ], // Column
          ), // Padding
        )// Scaffold
    );
  }
}
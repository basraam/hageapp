import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/AppBar/custom_AppBar.dart';
import '../../../../../../utils/constants/BSizes.dart';
import '../../../../../../utils/constants/Strings.dart';
import '../../../../../../utils/validations/validators.dart';
import '../../../../controllers/changingControllers/updatePhoneNumberController.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneNumberController());
    return Scaffold(
      /// Custom Appbar
        appBar: BAppBar(
          showBackArrow: true,
          title: Text('Change PhoneNumber', style: Theme.of(context).textTheme.headlineSmall),
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
                'Isticmaal magacaaga oo saddexan.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
// Text
              const SizedBox (height: BSizes.spaceBtwSections),
              /// Text field and Button
              Form(
                key: controller.updatePhoneNumberFormKey,
                child:
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => BValidator.validatePhoneNumber(value),
                  expands: false,
                  decoration: const InputDecoration (labelText: BString.phoneNumber, prefixIcon: Icon(Iconsax.call)),
                ),
              ),
              const SizedBox (height: BSizes.spaceBtwSections),
              /// Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.updatephoneNumber(),
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        )
    );
  }
}
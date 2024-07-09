import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/AppBar/custom_AppBar.dart';
import '../../../../../../utils/constants/BSizes.dart';
import '../../../../../../utils/constants/Strings.dart';
import '../../../../../../utils/validations/validators.dart';
import '../../../../controllers/changingControllers/updateName_controller.dart';

class ChangeFullname extends StatelessWidget {
  const ChangeFullname({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
    /// Custom Appbar
    appBar: BAppBar(
      showBackArrow: true,
      title: Text('Badal magacaada oo dhamaystiran', style: Theme.of(context).textTheme.headlineSmall),
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
    key: controller.updateNameFormKey,
    child:
    TextFormField(
    controller: controller.fullName,
    validator: (value) => BValidator.validateEmptyText('FullName', value),
    expands: false,
    decoration: const InputDecoration (labelText: BString.fullName, prefixIcon: Icon(Iconsax.user)),
    ), // TextFormField

// Column, Form
    ),
    const SizedBox (height: BSizes.spaceBtwSections),
    /// Save Button
    SizedBox(
    width: double.infinity,
    child: ElevatedButton(
    onPressed: () => controller.updateUserName(),
    child: Text('Badal'),
    ), // ElevatedButton
    ), // SizedBox
    ], // Column
    ), // Padding
    )// Scaffold
    );
  }
  }
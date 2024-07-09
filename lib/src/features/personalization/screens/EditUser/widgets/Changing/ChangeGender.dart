import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/AppBar/custom_AppBar.dart';
import '../../../../../../utils/constants/BSizes.dart';
import '../../../../controllers/changingControllers/updategenderController.dart';
import '../../../../../../common/custom_shapes/containers/Female_OR_Male.dart';
class changeGender extends StatelessWidget {
  const changeGender({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateGenderController());
    return  Scaffold(
        appBar: BAppBar(
        showBackArrow: true,
        title: Text('Change FullName', style: Theme.of(context).textTheme.headlineSmall),
    ),
    body: Padding(
    padding: const EdgeInsets.all(BSizes.defaultSpace),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Fadlan dooro jinsigaada..',
    style: Theme.of(context).textTheme.labelMedium,
    ),
    const SizedBox(height: BSizes.spaceBtwSections),
      SexSelector(controller: Get.put(UpdateGenderController())),
      const SizedBox (height: BSizes.spaceBtwSections),
      /// Save Button
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => controller.updateGender(),
          child: Text('Save'),
        ), // ElevatedButton
      ),
    ],
    ),
    ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../utils/constants/BSizes.dart';
import '../../../../../utils/constants/Colors.dart';
import '../../../../../utils/constants/Strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/signup/signup_controller.dart';
class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {

    final controller= SignupController.instance;

    final dark = BHelperFunctions.isDarkMode(context);

    return Row(children: [
      SizedBox(
          width: 24,
          height: 24,
          child: Obx(()=> Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value))),
      const SizedBox(width: BSizes.spaceBtwItems),
      Text.rich(
        TextSpan(children: [
          TextSpan(
              text: '${BString.iAgree} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: '${BString.privacy} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? BColors.white : BColors.primaryColor,
                decoration: TextDecoration.underline,
                decorationColor:
                dark ? BColors.white : BColors.primaryColor,
              )), // TextSpan
          TextSpan(
              text: '${BString.and} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: BString.terms,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? BColors.white : BColors.primaryColor,
                decoration: TextDecoration.underline,
                decorationColor:
                dark ? BColors.white : BColors.primaryColor,
              )),
        ]),
      ),
    ]);
  }
}

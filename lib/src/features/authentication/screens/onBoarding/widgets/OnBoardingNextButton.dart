import 'package:flutter/material.dart';
import 'package:hage_mobile_app/src/features/authentication/controllers/onBoarding/OnBoarding_controller.dart';
import 'package:hage_mobile_app/src/utils/devices/device_utility.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/Colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    return Positioned(
      right: 24,
      bottom: BDeviceUtility.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () {
          onBoardingController.instance.nextPage();
        },
        style: ElevatedButton.styleFrom(shape: const CircleBorder(),
            backgroundColor: dark ? BColors.secondaryColor : BColors.primaryColor),
        child: const Icon (Iconsax.arrow_right_3, color: Colors.black,),
      ), // ElevatedButton
    ); // Positioned
  }
}

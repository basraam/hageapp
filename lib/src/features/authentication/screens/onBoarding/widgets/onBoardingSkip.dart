import 'package:flutter/material.dart';
import 'package:hage_mobile_app/src/features/authentication/controllers/onBoarding/OnBoarding_controller.dart';

import '../../../../../utils/constants/Colors.dart';
import '../../../../../utils/devices/device_utility.dart';

class onBoardingSkip extends StatelessWidget {
  const onBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: BDeviceUtility.getAppBarHeight(),
        right: 24,
        child: TextButton(
          onPressed: () {
            onBoardingController.instance.skipPage();
          },
          child: const Text("skip",
              style: TextStyle(
                  color: BColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ));
  }
}


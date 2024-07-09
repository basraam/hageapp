import 'package:flutter/material.dart';
import 'package:hage_mobile_app/src/features/authentication/controllers/onBoarding/OnBoarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../utils/constants/Colors.dart';
import '../../../../../utils/devices/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class onBoardingDotNavigation extends StatelessWidget {
  const onBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = onBoardingController.instance;
    final dark = BHelperFunctions.isDarkMode(context);
    //Color activeDotColor = dark ? Colors.white : BColors.primaryColor;

    return Positioned(

        bottom: BDeviceUtility.getBottomNavigationBarHeight()+25,
        left:24,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect( activeDotColor : dark ? Colors.white : BColors.primaryColor, dotHeight: 6),
        ));
  }
}

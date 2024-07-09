import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/authentication/controllers/onBoarding/OnBoarding_controller.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/onBoarding/widgets/OnBoardingNextButton.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/onBoarding/widgets/onBoardingDotNavigation.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/onBoarding/widgets/onBoardingSkip.dart';
import 'package:hage_mobile_app/src/features/authentication/screens/onBoarding/widgets/onBoarding_page.dart';
import '../../../../utils/constants/Strings.dart';
import '../../../../utils/constants/images.dart';

class onBoardingScreen extends StatelessWidget {
  const onBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(onBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          //onboarding screen
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              onBoardingPage(
                image: BImages.onBoarding1,
                title: BString.onBoardingTitle1,
                subtitle: BString.onBoardingDesc1,
              ),
              onBoardingPage(
                image: BImages.onBoarding2,
                title: BString.onBoardingTitle2,
                subtitle: BString.onBoardingDesc2,
              ),
              onBoardingPage(
                image: BImages.onBoarding3,
                title: BString.onBoardingTitle3,
                subtitle: BString.onBoardingDesc3,
              ),
            ],
          ),

          // skip button
          onBoardingSkip(),

          //Dot navigations
          onBoardingDotNavigation(),

          //next button
          OnBoardingNextButton(),

        ],
      ),
    );
  }
}

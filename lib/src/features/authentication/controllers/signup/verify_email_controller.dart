import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/utils/constants/Strings.dart';
import 'package:hage_mobile_app/src/utils/constants/images.dart';

import '../../../../common/widgets/success_screen/successScreen.dart';
import '../../../../data/reposotories/Authentication/authentication_repository.dart';
import '../../../../utils/popups/loaders.dart';

class VerifyEmailController extends GetxController{

  static VerifyEmailController get instance => Get.find();

  /// send email when ever verify email screen appears, & set timer for auto redirect

  @override
  void onInit() {
    sendEmailVerification();
    super.onInit();
  }

  /// send email verification link
  sendEmailVerification(){
    try {
      AuthenticationRepository.instance.sendEmailVerification();
      BLoaders.successSnackBar(title: 'Email sent', message: 'Please check your email inbox to verify your account');
    } catch (e) {
      BLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  /// Timer to automatically redirect on Email Verification
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration (seconds: 1),
          (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
        () => successScreen(
        image: BImages.successAnim,
        title: BString.SuccessTitle,
        subtitle: BString.verifSuccessBody,
        onpressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
        );
        }
      },
    );
  }
  /// Manually Check if Email Verified
  checkEmailVerificationStatus() async {
    print('Checking email verification status...');
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      print('Current user is not null.');
      await currentUser.reload();
      if (currentUser.emailVerified) {
        print('Email is verified. Navigating to success screen...');
        Get.off(() => successScreen(
          image: BImages.successAnim,
          title: BString.SuccessTitle,
          subtitle: BString.verifSuccessBody,
          onpressed: () =>
              AuthenticationRepository.instance.screenRedirect(),
        ),
        );
      } else {
        print('Email is not verified.');
      }
    } else {
      print('Current user is null.');
    }
  }
}

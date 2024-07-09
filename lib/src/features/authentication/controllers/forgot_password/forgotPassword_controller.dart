import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/data/reposotories/Authentication/authentication_repository.dart';
import 'package:hage_mobile_app/src/utils/constants/images.dart';
import 'package:hage_mobile_app/src/utils/network_manager/network_manager.dart';
import 'package:hage_mobile_app/src/utils/popups/full_screen_loader.dart';
import 'package:hage_mobile_app/src/utils/popups/loaders.dart';

import '../../screens/passwordConfiguration/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();
  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  /// Send Reset Password EMail
  sendPasswordResetEmail() async {
    try {
      //start l;oading:
      BFullScreenLoader.openLoadingDialog("Loading...", BImages.docerAnimation);

      //check internet connection
      final isconnected =await NetworkManager.instance.isConnected();
      if(!isconnected){
        BFullScreenLoader.stopLoading();
        return;
      }
      //validate form
      if (!forgetPasswordFormKey.currentState!.validate()) {
        BFullScreenLoader.stopLoading();
        return;
      }
      //send password reset email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //stop loading
      BFullScreenLoader.stopLoading();

      //show success message
      BLoaders.successSnackBar(title: "Success", message: "Password reset email sent successfully".tr);
      
      //Redirect to reset password screen
      Get.to(() => resetPassword(email: email.text.trim()));
      
    } catch (e) {
      BFullScreenLoader.stopLoading();
      BLoaders.errorSnackBar(title: "Error", message: e.toString());
    }

  }
  resendPasswordResetEmail(String email) async {
    try {
      //start loading:
      BFullScreenLoader.openLoadingDialog("Loading...", BImages.docerAnimation);

      //check internet connection
      final isconnected =await NetworkManager.instance.isConnected();
      if(!isconnected){
        BFullScreenLoader.stopLoading();
        return;
      }

      //send password reset email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //stop loading
      BFullScreenLoader.stopLoading();

      //show success message
      BLoaders.successSnackBar(title: "Email sent", message: "Password reset email sent successfully".tr);

    } catch (e) {
      BFullScreenLoader.stopLoading();
      BLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}
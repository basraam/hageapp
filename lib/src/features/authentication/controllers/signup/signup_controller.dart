import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/data/reposotories/Authentication/authentication_repository.dart';
import 'package:hage_mobile_app/src/data/reposotories/user/user_Repository.dart';
import 'package:hage_mobile_app/src/utils/constants/images.dart';
import 'package:hage_mobile_app/src/utils/popups/full_screen_loader.dart';
import 'package:hage_mobile_app/src/utils/popups/loaders.dart';
import '../../../../data/models/user_model.dart';
import '../../../../utils/network_manager/network_manager.dart';
import '../../screens/Signup/signupVerify.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs; // observable for hiding/showing password
  final privacyPolicy = true.obs; // observable for hiding/showing password
  final email = TextEditingController(); // Controller for email input
  final fullName = TextEditingController(); // Controller for last name input
  final username = TextEditingController(); // Controller for username input
  final password = TextEditingController(); // Controller for password input
  final level = TextEditingController(); // Controller for first name input
  final phoneNumber = TextEditingController(); // Controller for phone number input

  GlobalKey<FormState> signup_Formkey = GlobalKey<FormState>(); // Form key for form validation

  /// -- SIGNUP
  Future<void> signup() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BLoaders.errorSnackBar(title: 'No Internet', message: 'Check your internet connection');
        return;
      }

      // Form Validation
      if (!signup_Formkey.currentState!.validate()) {
        BLoaders.errorSnackBar(title: 'Validation Error', message: 'Please fill out the form correctly');
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        BLoaders.warningSnackBar(
            title: "Accept Privacy Policy",
            message: "si aad ciwaan u abuurato waa inaad aqbashaa shuruucda appka"
        );
        return;
      }
      // Start Loading
      BFullScreenLoader.openLoadingDialog('wax yar sug', BImages.docerAnimation);

      // Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        fullName: fullName.text.trim(),
        username: username.text.trim(),
        password: password.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        level: level.text.trim(),
        profilePic: '',
        bio: '',
        bod: DateTime.now(),
        sex: '',
        isOnline: true,
        lastSeen: DateTime.now(),
        signedAt: Timestamp.now(),
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Show Success Message
      BLoaders.successSnackBar(
          title: "Hambalyo",
          message: "Waad ku guulaysatay abuurashada ciwaan cusub. Xaqiiji si aad gudaha ugu gasho!"
      );

      // Move to Verify Email Screen
      Get.to(() =>  EmailVerifyScreen(email: email.text.trim()));

    } catch (e) {
      BFullScreenLoader.stopLoading();

      BLoaders.errorSnackBar(title: 'oh snap!!', message: e.toString());
    }
  }

}

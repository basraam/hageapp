import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/personalization/controllers/user_controller.dart';

import '../../../../data/reposotories/user/user_Repository.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/network_manager/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/EditUser/EditUser_Page.dart';

class UpdateGenderController extends GetxController {
  final sex = TextEditingController();

  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateGenderFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    GenderRecord();
    super.onInit();
  }

  /// Fetch user record
  Future<void> GenderRecord() async {
    sex.text = userController.user.value.sex;
  }
  Future<void> updateGender() async {
    try {
      // Start Loading
      BFullScreenLoader.openLoadingDialog(
          'We are updating your information...', BImages.docerAnimation);
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!updateGenderFormKey.currentState!.validate()) {
        BFullScreenLoader.stopLoading();
        return;
      }
      // Update user's gender in the Firebase Firestore
      Map<String, dynamic> gender = {'sex': sex.text.trim()};
      await userRepository.updateSingleField(gender);

      // Update the Rx User value
      userController.user.value.sex = sex.text.trim();
      // Remove Loader
      BFullScreenLoader.stopLoading();
      // Show Success Message
      BLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your gender has been updated.');

      // Move to previous screen.
      Get.offAll(() => const EditUserPage());
    } catch (e) {
      BFullScreenLoader.stopLoading();
      BLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

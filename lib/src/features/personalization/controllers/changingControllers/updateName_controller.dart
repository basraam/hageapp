import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/personalization/controllers/user_controller.dart';

import '../../../../data/reposotories/user/user_Repository.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/network_manager/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/EditUser/EditUser_Page.dart';

/// Controller to manage user-related functionality.
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();
  final fullName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeNames() async {
    fullName.text = userController.user.value.fullName;
  }

  Future<void> updateUserName() async {
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
      if (!updateNameFormKey.currentState!.validate()) {
        BFullScreenLoader.stopLoading();
        return;
      }
// Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> name = {'FullName': fullName.text.trim()};
      await userRepository.updateSingleField(name);

// Update the Rx User value
      userController.user.value.fullName = fullName.text.trim();
// Remove Loader
      BFullScreenLoader.stopLoading();
// Show Success Message
      BLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your Name has been updated.');
// Move to previous screen.
      Get.off(() => const EditUserPage());
    } catch (e) {
      BFullScreenLoader.stopLoading();
      BLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
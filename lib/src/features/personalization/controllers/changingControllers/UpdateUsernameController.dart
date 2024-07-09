import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/reposotories/user/user_Repository.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/network_manager/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/EditUser/EditUser_Page.dart';
import '../user_controller.dart';

class UpdateUsernameController extends GetxController {
  static UpdateUsernameController get instance => Get.find();
  final userName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    initializeUserName();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeUserName() async {
    userName.text = userController.user.value.username;
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
      if (!updateUserNameFormKey.currentState!.validate()) {
        BFullScreenLoader.stopLoading();
        return;
      }
// Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> name = {'username': userName.text.trim()};
      await userRepository.updateSingleField(name);

// Update the Rx User value
      userController.user.value.username = userName.text.trim();
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

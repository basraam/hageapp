import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/reposotories/Authentication/authentication_repository.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/network_manager/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> Login_FormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
    // Check if Remember Me is selected
    if (localStorage.read('REMEMBER_ME_EMAIL') != null) {
      email.text = localStorage.read('REMEMBER_ME_EMAIL');
      rememberMe.value = true;
    }
  }

  /// -- Email and Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    print("=== signing innnn ========");
    try {
      // Start Loading
      BFullScreenLoader.openLoadingDialog( 'Logging you in...', BImages.docerAnimation);

// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BFullScreenLoader.stopLoading();
        return;
      }
// Form Validation
      if (!Login_FormKey.currentState!.validate()) {
        BFullScreenLoader.stopLoading();
        return;
      }
// Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
// Login user using EMail & Password Authentication
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
// Remove Loader
      BFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      BFullScreenLoader.stopLoading();

      BLoaders.errorSnackBar(title: 'oh snap!!', message: e.toString());
    }
  }
}
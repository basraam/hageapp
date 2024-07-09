import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/loaders/animation_loader.dart';
import '../constants/Colors.dart';
import '../helpers/helper_functions.dart';

/// A utility class for managing a full-screen loading dialog.
class BFullScreenLoader {
  /// Open a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.
  ///
  ///Parameters:
  ///text: The text to be displayed in the loading dialog.
//animation: The Lottie animation to be shown.

  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: BHelperFunctions.isDarkMode(Get.context!)
              ? BColors.dark
              : BColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(children: [
            const SizedBox(height: 250),
            BAnimationLoaderWidget(
              text: text,
              animation: animation,
            ),
          ]),
        ),
      ),
    );
  }
  /// Stop the currently open loading dialog.
  /// This method doesn't return anything.
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop(); // Close the dialog using the Navigator
  }

}



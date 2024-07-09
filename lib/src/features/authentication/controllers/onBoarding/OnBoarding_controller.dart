import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../screens/welcomeScreen.dart';

class onBoardingController extends GetxController {
  static onBoardingController instance = Get.find();
  //variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  //update current index when page scrolled
  void updatePageIndicator(index) {
    //update current index
    currentPageIndex.value=index;

  }

  // dots indicator
  void dotNavigationClick(index) {
    //update current index
    currentPageIndex.value=index;
    pageController.jumpTo(index);
  }

  //update Current Page Index
void nextPage() {
    //go to next index
  if(currentPageIndex.value==2){
    final storage = GetStorage();

    if(kDebugMode){
      print('================== GET STORAGE next Button ====================');
      print(storage.read('IsFirstTime'));
    }

    storage.write('IsFirstTime', false);

    if(kDebugMode){
      print('================== GET STORAGE auth Rep ====================');
      print(storage.read('IsFirstTime'));
    }

    Get.offAll(const welcomeScreen());
  }
  else
    {
      int page = currentPageIndex.value+1;
      pageController.jumpToPage(page);
    }
  }

  //skip onboarding
void skipPage() {
    //skip to last index
  currentPageIndex.value=2;
  pageController.jumpToPage(2);
  }

  //get started
}

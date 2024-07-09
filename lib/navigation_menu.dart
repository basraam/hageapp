import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Chats/chatsTap.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Groups/groups.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Home/home.dart';
import 'package:hage_mobile_app/src/features/personalization/screens/Profile/my_profile.dart';
import 'package:hage_mobile_app/src/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class NavigationController extends GetxController {
  final String userId;

  final Rx<int> selectedIndex = 0.obs;
  late final List<Widget> screens;

  NavigationController({required this.userId,}) {
    screens = [
      homeScreen(userId: userId,),
      groups(UserId: userId), // Pass userId to groups screen
      MessagesPage(userId: userId,),
      MyProfilePage(userId: userId, ),
    ];
  }
}

class NavigationMenu extends StatefulWidget {
  final String userId;


  const NavigationMenu({Key? key, required this.userId, }) : super(key: key);

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  late final NavigationController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NavigationController(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          backgroundColor: dark ? Colors.black38 : Colors.white,
          indicatorColor: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.people), label: 'Groups'),
            NavigationDestination(icon: Icon(Iconsax.message), label: 'Chats'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

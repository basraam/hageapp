import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/personalization/screens/EditUser/EditUser_Page.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/AppBar/custom_AppBar.dart';
import '../../../../../common/widgets/Notifications/notificationCounter.dart';
import '../../../../../utils/constants/Colors.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../Notifications/Activities.dart';

class BHomeAppBar extends StatelessWidget {
  final String username;
  final String userId;
  const BHomeAppBar({
    super.key, required this.username, required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BAppBar(
      leadingIcon: Iconsax.user_edit,
      leadingOnPressed: () => Get.to(() => const EditUserPage()),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage(BImages.homePageHeader))
        ],
      ),
      showBackArrow: false,
      actions: [
        BNotificationsCounter(onPressed: () => Get.to(() => Activities()), iconColor: BColors.white),
      ],
    );
  }
}

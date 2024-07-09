import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hage_mobile_app/src/common/styles/shimmers.dart';
import 'package:hage_mobile_app/src/utils/constants/Colors.dart';

import '../../../../../common/custom_shapes/containers/ProfileImage_container.dart';
import '../../../../../common/widgets/userProfile/profileImage.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../Taps/controllers/PostsController/PostsController.dart';
import '../../../controllers/user_controller.dart';

class BuildProfileHeader extends StatelessWidget {
  final String userId;
  final String username;
  const BuildProfileHeader({super.key, required this.userId, required this.username});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final postController = Get.find<PostController>();
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserId != null) {
      // Load user profile and check if the profile belongs to the current user
      userController.loadUserProfile(userId).then((_) {
        postController.fetchUserPosts(currentUserId);
      });
    }

    return SizedBox(
      child: Column(
        children: [
          // Profile Image
          Obx(() {
            if (userController.profileLoading.value) {
              return const BShimmerEffect(width: 50, height: 50);
            } else {
              return BProfileImage(
                image: userController.user.value.profilePic.isNotEmpty
                    ? userController.user.value.profilePic
                    : BImages.greenBackground,
                width: 50,
                height: 50,
                isNetworkImage: userController.user.value.profilePic.isNotEmpty,
              );
            }
          }),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                if (userController.profileLoading.value) {
                  return const BShimmerEffect(width: 50, height: 15);
                } else {
                  return Text(
                    userController.user.value.fullName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              }),
              const SizedBox(width: 5),
              Obx(() {
                return Text(
                  '. ${userController.user.value.level}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                );
              }),
            ],
          ),
          // Username
          Obx(() {
            if (userController.profileLoading.value) {
              return const BShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                '@${username}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              );
            }
          }),
          const SizedBox(height: 5),
          // User Bio
          Obx(() {
            if (userController.profileLoading.value) {
              return const BShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                userController.user.value.bio,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              );
            }
          }),
          // Friends Count Button
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: BColors.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const SizedBox(
              width: 120,
              child: Row(
                children: [
                  Icon(
                    Icons.people,
                    color: BColors.primaryTextColor,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '850 Asxaab', // Adjust this to show the actual friends count
                    style: TextStyle(
                      color: BColors.primaryTextColor,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Tw Cen MT',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

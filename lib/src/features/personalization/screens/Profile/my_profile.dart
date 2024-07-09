import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/utils/firebase.dart';
import 'package:hage_mobile_app/src/features/personalization/controllers/user_controller.dart';
import 'package:hage_mobile_app/src/features/personalization/screens/Profile/widgets/profileHeader.dart';
import 'package:hage_mobile_app/src/utils/constants/Colors.dart';
import '../../../../utils/constants/BSizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../Taps/controllers/PostsController/PostsController.dart';
import '../../../Taps/screens/Home/Posts/post.dart';

class MyProfilePage extends StatelessWidget {
  final String userId;
  const MyProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    final postController = Get.put(PostController());
    final userController = Get.put(UserController());

    postController.fetchUserPosts(userId);

    return Scaffold(
      backgroundColor: dark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: BColors.primaryColor,
            fontFamily: 'Tw Cen MT',
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            BuildProfileHeader(
              userId: userId,
              username: userController.user.value.username,
            ),
            const SizedBox(height: BSizes.spaceBtwSections),
            // User's Posts
            Obx(() {
              if (postController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (postController.postLists.isEmpty) {
                return const Center(child: Text('No posts available'));
              } else {
                return Column(
                  children: postController.postLists.map((post) {
                    return PostContainer(
                      userId: userId,
                      id: post.id,
                      fullName: post.fullName,
                      username: post.username,
                      postTime: post.createdDate,
                      content: post.content,
                      postImage: post.postImage,
                      postVideo: post.postVideo,
                      likes: post.likes.toString(),
                      profilePicture: post.profilePic,
                        isLiked: postController.PostisLikedByCurrentUser(post.id),
                        onLike: ()=> postController.togglepostLike(post.id)
                    );
                  }).toList(),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

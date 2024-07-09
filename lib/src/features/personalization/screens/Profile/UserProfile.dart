import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/personalization/screens/Profile/widgets/profileHeader.dart'; // Importing profile header widget
import 'package:hage_mobile_app/src/features/personalization/screens/Profile/widgets/userCommunicationButtons.dart'; // Importing user communication buttons widget
import 'package:hage_mobile_app/src/utils/constants/Colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../Taps/controllers/PostsController/PostsController.dart';
import '../../../Taps/screens/Home/Posts/post.dart';
import '../../../Taps/screens/Home/Posts/widgets/UserPosts_container.dart';
import '../../controllers/user_controller.dart';

class UserProfilePage extends StatelessWidget {

  final String userId;
  final String username;
  UserProfilePage({super.key, required this.userId, required this.username,});
  final RxBool isMe = false.obs;

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    final PostController postController = Get.put(PostController());
    final UserController userController = Get.put(UserController());


    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    userController.loadUserProfile(currentUserId!).then((_) {
      FirebaseAuth.instance.currentUser!.uid == currentUserId ? isMe.value = true : isMe.value = false;
      postController.fetchUserPosts(currentUserId);
    });

    return Obx(() {
      return Scaffold(
        backgroundColor: dark ? Colors.grey[900] : Colors.grey[100], // Set background color based on the dark mode
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(
                color: BColors.primaryColor,
                fontFamily: 'Tw Cen MT',
                fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BuildProfileHeader(userId: userId, username: username,), // Display profile header
              const SizedBox(height: 10),
              if (!isMe.value) const communicButtons(), // Show communication buttons if it's not the current user's profile

              // Display posts section
              Obx(() {
                if (postController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator()); // Show loading indicator
                } else if (postController.postsList.isEmpty) {
                  return const Center(child: Text('No posts available')); // Show message if no posts are available
                } else {
                    return Column(
                      children: postController.postsList.map((post) {
                        return PostContainer(
                          userId: userId,
                          id: post.id,
                          fullName: userController.user.value.fullName,
                          username: userController.user.value.username,
                          postTime: post.createdDate,
                          content: post.content,
                          postImage: post.postImage,
                          postVideo: post.postVideo,
                          likes: post.likes.toString(),
                          profilePicture: userController.user.value.profilePic,
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
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Home/widgets/AddPost_container.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Home/widgets/homeAppBar.dart';
import 'package:hage_mobile_app/src/utils/helpers/helper_functions.dart';
import '../../../../common/custom_shapes/containers/HomePageHeader.dart';
import '../../../../common/custom_shapes/containers/SearchBar_container.dart';
import '../../../../utils/constants/BSizes.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../controllers/PostsController/PostsController.dart';
import 'Posts/post.dart';

class homeScreen extends StatelessWidget {
  final String userId;

  const homeScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    final postController = Get.put(PostController());
    final userController = Get.put(UserController());

    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final String username = userController.user.value.username;

    // Fetch posts when the screen is initialized
    postController.fetchUsersPosts();

    return Scaffold(
      backgroundColor: dark ? Colors.grey[900] : Colors.grey[100],
      body: Column(
        children: [
          /// App Header
          HomePageHeader(
            child: Column(
              children: [
                /// App Bar of the home Screen
                BHomeAppBar(
                  userId: userId,
                  username: username,
                ),
                const SizedBox(height: BSizes.defaultSpace / 2),

                /// Search Bar of the home Screen
                BSearchBar(
                  userId: userId,
                ),
                const SizedBox(height: BSizes.spaceBtwSections / 2),

                /// Add post container
                const AddPostContainer(),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              if (postController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (postController.postsList.isEmpty) {
                return const Center(child: Text('No posts available'));
              } else {
                return RefreshIndicator(
                  onRefresh: postController.fetchUsersPosts,
                  child: ListView.builder(
                    itemCount: postController.postsList.length,
                    itemBuilder: (context, index) {
                      final post = postController.postsList[index];
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
                    },
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

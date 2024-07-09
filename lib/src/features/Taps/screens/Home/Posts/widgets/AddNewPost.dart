import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/navigation_menu.dart';
import 'package:hage_mobile_app/src/utils/constants/BSizes.dart';
import '../../../../../../common/custom_shapes/containers/ProfileImage_container.dart';
import '../../../../../../common/styles/shimmers.dart';
import '../../../../../../utils/constants/Colors.dart';
import '../../../../../../utils/constants/images.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../personalization/controllers/user_controller.dart';
import '../../../../controllers/PostsController/addPost_controller.dart';

class AddNewPostPage extends StatelessWidget {

  const AddNewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final postController = Get.put(AddPostController());

    final dark = BHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Abuur post cusub"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BSizes.spaceBtwItems),
          child: Container(
            padding: const EdgeInsets.all(BSizes.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(BSizes.cardRadiusLg),
              border: Border.all(color: Colors.grey[300]!),
              color: dark ? BColors.dark : BColors.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Obx(() {
                      final networkImage = userController.user.value.profilePic;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : BImages.greenBackground;
                      return userController.imageUploading.value
                          ? const BShimmerEffect(width: 25, height: 25, radius: 25)
                          : BProfileImage(
                          image: image,
                          width: 25,
                          height: 25,
                          isNetworkImage: networkImage.isNotEmpty);
                    }),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: TextField(
                        controller: postController.postContent,
                        maxLines: 10,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.edit, color: Colors.grey[500]),
                          hintText: "Halkan ku qor fikirkaaga...",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 16.0, color: Colors.grey),
                Obx(() {
                  return Column(
                    children: [
                      if (postController.pickedImage.value != null)
                        Image.file(
                          File(postController.pickedImage.value!.path),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      if (postController.pickedVideo.value != null)
                        Container(
                          width: double.infinity,
                          height: 200,
                          child: Text('Video selected: ${postController.pickedVideo.value!.name}'),
                        ),
                    ],
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: postController.pickImage,
                          icon: const Icon(Icons.photo_library, color: Colors.green),
                        ),
                        IconButton(
                          onPressed: postController.pickVideo,
                          icon: const Icon(Icons.videocam, color: Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: BSizes.buttonHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        ),
                        onPressed: () {
                          postController.createPost(FirebaseAuth.instance.currentUser!.uid);
                          Get.to(()=> NavigationMenu(userId: userController.user.value.id,));
                        },
                        child: const Text(
                          "Dhig",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

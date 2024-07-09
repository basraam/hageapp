import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/data/reposotories/Posts/posts_repository.dart';
import 'package:hage_mobile_app/src/data/reposotories/user/user_Repository.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Home/home.dart';
import 'package:hage_mobile_app/src/features/personalization/controllers/user_controller.dart';
import 'package:hage_mobile_app/src/utils/constants/images.dart';
import 'package:hage_mobile_app/src/utils/popups/full_screen_loader.dart';
import 'package:hage_mobile_app/src/utils/popups/loaders.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/post_model.dart';

class AddPostController extends GetxController {
  final PostsRepository _repository = PostsRepository();
  final postContent = TextEditingController();
  var pickedImage = Rx<XFile?>(null);
  var pickedVideo = Rx<XFile?>(null);
  RxBool isLoading= false.obs;

  final ImagePicker _picker = ImagePicker();
  final UserController userController = Get.find<UserController>();
  final UserRepository userRepository = Get.find<UserRepository>();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = image;
    }
  }

  Future<void> pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      pickedVideo.value = video;
    }
  }


  Future<void> createPost(String userId) async {
    final content = postContent.text.trim();
    if (content.isEmpty && pickedImage.value == null && pickedVideo.value == null) {
      Get.snackbar("Error", "Post content cannot be empty");
      return;
    }

    String? imageUrl;
    String? videoUrl;

    if (pickedImage.value != null) {
      imageUrl = await userRepository.uploadImage('Users/Posts/images/', pickedImage.value!);
    }

    if (pickedVideo.value != null) {
      videoUrl = await userRepository.uploadVideo('Users/Posts/videos/', pickedVideo.value!);
    }

    final post = PostsModel(
      id: '',
      fullName: userController.user.value.fullName,
      username: userController.user.value.username,
      profilePic: userController.user.value.profilePic,
      content: content,
      postImage: imageUrl ?? '',
      postVideo: videoUrl ?? '',
      createdDate: DateTime.now(),
      likes: 0,
      likedBy: []
    );

    try {
      await _repository.addPost(post, userId);
      isLoading.value = true;
      BFullScreenLoader.openLoadingDialog("Wax yar sug, xoogaa waqti ayey qaadanaysaa", BImages.docerAnimation);
      isLoading.value=false;
      BLoaders.successSnackBar(title: "Hambalyo", message: "Postigaadii waaa la dhigay");
      postContent.clear();
      pickedImage.value = null;
      pickedVideo.value = null;
    } catch (e) {
      Get.snackbar("Error", "Failed to create post: $e");
    }
  }

}

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/personalization/controllers/profile_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/user_model.dart';
import '../../../data/reposotories/Authentication/authentication_repository.dart';
import '../../../data/reposotories/user/user_Repository.dart';
import '../../../utils/constants/BSizes.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/exceptions/firebaseAuth_exception.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/format_exception.dart';
import '../../../utils/exceptions/platform_exception.dart';
import '../../../utils/network_manager/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/screens/login/login.dart';
import '../screens/EditUser/reAuthenticate_user_login.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  final imageUploading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  final profile = Get.put(ProfileController());
  final searchResults = <UserModel>[].obs; // Add this line
  final searchLoading = false.obs;  // Add this line to show a loader during search

  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord(AuthenticationRepository.instance.authUser!.uid);
  }

  // Function to fetch user data from Firestore
  Future<void> fetchUserRecord(String userId) async {
    try {
      DocumentSnapshot doc = await _db.collection("users").doc(userId).get();
      if (doc.exists) {
        user.value = UserModel.fromSnapshot(doc);
      } else {
        throw 'User not found';
      }
    } on FirebaseAuthException catch (e) {
      throw BFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw BFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const BFormatException();
    } on PlatformException catch (e) {
      throw BPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to fetch current user's data

  // Future<UserModel> fetchCurrentUser() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   try {
  //     User? user = auth.currentUser;
  //     if (user != null) {
  //       DocumentSnapshot<Map<String, dynamic>> snapshot =
  //       await firestore.collection('users').doc(user.uid).get();
  //
  //       UserModel currentUser = UserModel.fromSnapshot(snapshot);
  //       return currentUser;
  //     } else {
  //       throw Exception('User not signed in');
  //     }
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

  // /// Fetch user record
  // Future<void> fetchUserRecord() async {
  //   try {
  //     profileLoading.value = true;
  //     final fetchedUser = await UserRepository.instance.fetchUserDetails();
  //     user(fetchedUser);
  //   } catch (e) {
  //     user(UserModel.empty());
  //   } finally {
  //     profileLoading.value = false;
  //   }
  // }

  Future<void> loadUserProfile(String userId) async {
    try {
      profileLoading.value = true;
      final fetchedUser = await ProfileController().loadUserProfile(userId);
      user(fetchedUser);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Future<void> loadOtherUserProfile(String userId) async {
  //   try {
  //     profileLoading.value = true;
  //     final fetchedUser = await UserRepository.instance.fetchOtherUserDetails(
  //         userId);
  //     otherUser(fetchedUser);
  //   } catch (e) {
  //     otherUser(UserModel.empty());
  //   } finally {
  //     profileLoading.value = false;
  //   }
  // }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // First Update Rx User and then check if user data is already stored. If not store new data
      await fetchUserRecord(user.value.id);

      // If no record already stored.

      if (user.value.id.isEmpty) {
        if (userCredentials != null) {

          // Convert Name to First and Last Name
          //final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');

          // Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            fullName: userCredentials.user!.displayName ?? '',
            username: '',
            email: userCredentials.user!.email ?? '',
            password: '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePic: userCredentials.user!.photoURL ?? '',
            level: '',
            bio: '',
            bod: DateTime.now(),
            isOnline: false,
            lastSeen: DateTime.now(),
            signedAt: Timestamp.now(),
            sex: '',
          );
          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      BLoaders.warningSnackBar(
        title: 'Xogtaada lama xareyn!',
        message:
        'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(BSizes.md),
      title: 'Delete Account',
      middleText:
      'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: BSizes.lg),
            child: Text('Delete')),
      ),
      // ElevatedButton
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ), // OutlinedButton
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      BFullScreenLoader.openLoadingDialog('Processing', BImages.docerAnimation);

      /// First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
// Re Verify Auth Email
        if (provider == 'password') {
          BFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      } else {
        BFullScreenLoader.stopLoading();
        BLoaders.warningSnackBar(
          title: 'Oh Snap!',
          message:
          'You are not authorized to delete your account. Please contact support for assistance.',
        );
      }
    } catch (e) {
      BFullScreenLoader.stopLoading();
      BLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  ///-- RE-AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      BFullScreenLoader.openLoadingDialog('Processing', BImages.docerAnimation);
//Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BFullScreenLoader.stopLoading();
        return;
      }
      if (!reAuthFormKey.currentState!.validate()) {
        BFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      BFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      BFullScreenLoader.stopLoading();
      BLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Upload Profile Image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;

// Upload Image
        final imageUrl =
        await userRepository.uploadImage('Users/Images/Profile/', image);
// Update User Image Record
        Map<String, dynamic> json = {'profilePic': imageUrl};
        await userRepository.updateSingleField(json);
        user.value.profilePic = imageUrl;
        user.refresh();
        BLoaders.successSnackBar(
            title: 'Hambalyo',
            message: 'Sawirkaadi profile-ka waa la badalay!');
      }
    } catch (e) {
      BLoaders.errorSnackBar(
          title: 'OhSnap', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }

  /// Function to search users

  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }
    try {
      searchLoading.value = true;
      final results = await UserRepository.instance.searchUsers(query);
      searchResults.value = results;
      searchResults(results);
    } catch (e) {
      searchResults.clear();
      print('Error: $e');
    } finally {
      searchLoading.value = false;
    }
  }
}

  // Future<void> searchUsers(String query) async {
  //   if (query.isEmpty) {
  //     searchResults.clear();
  //     return;
  //   }
  //   try {
  //     searchLoading.value = true;
  //     final results = await UserRepository.instance.searchUsers(query);
  //     searchResults.value = results;
  //     searchResults(results);
  //   } catch (e) {
  //     searchResults.clear();
  //   } finally {
  //     searchLoading.value = false;
  //   }
  // }



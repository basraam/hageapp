// Repository class for user-related operations.
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/data/reposotories/Authentication/authentication_repository.dart';
import 'package:hage_mobile_app/src/utils/exceptions/platform_exception.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/exceptions/firebaseAuth_exception.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/format_exception.dart';
import '../../models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user data to Firestore.
  // Future<void> saveUserRecord(UserModel user) async {
  //   try {
  //     await _db.collection("users").doc(user.id).set(user.toJson());
  //   } on FirebaseAuthException catch (e) {
  //     throw BFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw BFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const BFormatException();
  //   } on PlatformException catch (e) {
  //     throw BPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }


  Future<bool> UsernameTaken(String username) async {
  try {
  final querySnapshot = await _db
      .collection('users')
      .where('username', isEqualTo: username)
      .get();

  return querySnapshot.docs.isNotEmpty;
  } catch (e) {
  print('Error checking username availability: $e');
  return false;
  }
  }

  Future<void> saveUserRecord(UserModel user) async {
  try {
  final isUsernameTaken = await UsernameTaken(user.username);

  if (isUsernameTaken) {
  throw Exception('Username ${user.username} is already taken.');
  }

  await _db.collection('users').doc(user.id).set(user.toJson());
  } catch (e) {
  print('Error saving user record: $e');
  throw e;
  }
  }


  Future<UserModel> fetchOtherUserDetails(String userId) async {
    try {
      final doc = await _db.collection("users").doc(userId).get();
      if (doc.exists) {
        return UserModel.fromSnapshot(doc);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  /// Function to fetch user details based on user ID.
  Future<UserModel> fetchUserDetails() async {
    try {
      final doc = await _db
          .collection("users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (doc.exists) {
        return UserModel.fromSnapshot(doc);
      } else {
        return UserModel.empty();
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

  /// Function to update user data in Firestore.
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection("users")
          .doc(updateUser.id)
          .update(updateUser.toJson());
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

  /// Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
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

  /// Function to remove user data from Firestore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("users").doc(userId).delete();
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

  /// Upload any Image to Firebase Storage

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
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

  ///upload any video to firebase storage
  Future<String> uploadVideo(String path, XFile video) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(video.name);
      await ref.putFile(File(video.path));
      final url = await ref.getDownloadURL();
      return url;
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


  /// Function to search users by full name.
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      final usersQuery = await _db
          .collection('users')
          .where('fullName', isGreaterThanOrEqualTo: query)
          .where('fullName', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      print('Query: $query');
      print('Documents fetched: ${usersQuery.docs.length}');

      return usersQuery.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

/// Function to search users by name

  // Future<List<UserModel>> searchUsers(String query) async {
  //   try {
  //     final usersQuery = await _db
  //         .collection('users')
  //         .where('fullName', isGreaterThanOrEqualTo: query)
  //         .where('fullName', isLessThanOrEqualTo: query + '\uf8ff')
  //         .get();
  //
  //     print('Query: $query');
  //     print('Documents fetched: ${usersQuery.docs.length}');
  //
  //     return usersQuery.docs.map((doc) {
  //       final data = doc.data();
  //       return UserModel(
  //         id: doc.id,
  //         fullName: data['fullName'] ?? '',
  //         username: data['username'] ?? '',
  //         email: data['email'] ?? '',
  //         phoneNumber: data['phoneNumber'] ?? '',
  //         level: data['level'] ?? '',
  //         profilePic: data['profilePicture'] ?? '',
  //         password: data['password'] ?? '',
  //         bio: data['bio'] ?? '',
  //         bod: data['dob'] ?? '',
  //         sex: data['sex'] ?? '',
  //         isOnline: true,
  //         lastSeen: DateTime.now(),
  //         signedAt: Timestamp.now(),
  //       );
  //     }).toList();
  //   } catch (e) {
  //     print('Error: $e');
  //     return [];
  //   }
  // }
}

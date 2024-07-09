import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/reposotories/user/user_Repository.dart';

class ProfileController extends GetxController {
  final UserRepository userRepository = UserRepository();

  Future<bool> isCurrentUser(String userId) async {
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return currentUserId == userId;
  }

  Future<UserModel> loadUserProfile(String userId) async {
    if (await isCurrentUser(userId)) {
      // Fetch current user's data

      return await userRepository.fetchUserDetails();
    } else {
      // Fetch other user's data
      return await userRepository.fetchOtherUserDetails(userId);
    }
  }
}

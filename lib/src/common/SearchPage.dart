import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../features/personalization/controllers/user_controller.dart';
import '../features/personalization/screens/Profile/UserProfile.dart';
import '../features/personalization/screens/Profile/my_profile.dart';
import '../utils/constants/BSizes.dart';
import '../utils/helpers/helper_functions.dart';

class SearchPage extends StatelessWidget {
  final String userId;
   SearchPage({super.key, required this.userId,});

  RxBool isMe = false.obs;

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    final UserController userController = Get.find();

    final String username = userController.user.value.username;

    void navigateToUserProfile(BuildContext context) {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId != null) {
        if (username.isNotEmpty) {
          // Navigate to user profile based on username
          if (userId == currentUserId) {
            // Navigate to current user's profile
            Get.to(() => MyProfilePage(userId: userId));
          } else {
            // Navigate to selected user's profile based on username
            Get.to(() => UserProfilePage(userId: userId,username: username,));
          }
        }
      }
    }
    return Scaffold(
      backgroundColor: dark ? Colors.grey[900] : Colors.grey[100],
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: BSizes.appBarHeight + 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                cursorColor: dark ? Colors.white : Colors.black,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 149, 57),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF8DC26F),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  fillColor: const Color.fromARGB(245, 243, 245, 244),
                  filled: true,
                  hintText: "Raadi..",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                style: const TextStyle(fontSize: 16),
                onChanged: (query) {
                  userController.searchUsers(query);
                },
              ),
            ),
            const SizedBox(height: BSizes.defaultSpace),
            Obx(() {
              if (userController.searchLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (userController.searchResults.isEmpty) {
                return const Center(child: Text('No users found'));
              }
              return Expanded(
                child: GestureDetector(
                  onTap: (){
                    navigateToUserProfile(context);
                  },
                  child: ListView.builder(
                    itemCount: userController.searchResults.length,
                    itemBuilder: (context, index) {
                      final user = userController.searchResults[index];
                      return ListTile(
                        leading: user.profilePic.isNotEmpty
                            ? CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePic),
                        )
                            : const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(user.fullName),
                        subtitle: Text(user.username),
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

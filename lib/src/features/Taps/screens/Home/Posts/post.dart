import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Home/Posts/widgets/Comments.dart';
import 'package:hage_mobile_app/src/features/personalization/screens/Profile/UserProfile.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../common/custom_shapes/containers/ProfileImage_container.dart';
import '../../../../../common/styles/shimmers.dart';
import '../../../../../utils/constants/Colors.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../../../../personalization/screens/Profile/my_profile.dart';
import '../../../controllers/PostsController/PostsController.dart';

class PostContainer extends StatelessWidget {
  final String userId;
  final String id;
  final String fullName;
  String username;
  final DateTime postTime;
  final String content;
  final String postImage;
  final String likes;
  final String profilePicture;
  final String postVideo;
  final Function() onLike;
  final bool isLiked;

  PostContainer({
    required this.userId,
    required this.id,
    required this.fullName,
    required this.username,
    required this.postTime,
    required this.content,
    required this.postImage,
    required this.likes,
    required this.profilePicture,
    required this.postVideo,
    required this.onLike,
  required this.isLiked,
    super.key,
  });

  _navigateToUserProfile() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (userDoc.exists) {

        String username1 = userDoc.data()?['username'];
        username = username1;
        // Use the username as needed
        Get.to(() => UserProfilePage(userId: userId,username: username,));


      } else {
        // Handle the case where the document does not exist
        Get.to(() => MyProfilePage(userId: userId,));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
      child: Card(
        color: BColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () => _navigateToUserProfile(),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profilePicture),
                ),
              ),
              title: GestureDetector(
                onTap: () => _navigateToUserProfile(),
                child: Row(
                  children: [
                    Text(fullName),
                    const SizedBox(width: 5),
                    Text('@${username}', style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ),
              subtitle: Text(
                timeago.format(postTime),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            Text(
              content,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10),
            postImage.isNotEmpty
                ? SizedBox(
              width: 370,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  postImage,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                  const Text('Failed to load image'),
                ),
              ),
            )
                : postVideo.isNotEmpty
                ? SizedBox(
              width: 300,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Chewie(
                    controller: ChewieController(
                      videoPlayerController:
                      VideoPlayerController.network(postVideo),
                      autoPlay: false,
                      looping: false,
                    ),
                  ),
                ),
              ),
            )
                : const SizedBox(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        size: 20,
                        color: isLiked ? Colors.green : Colors.grey,
                      ),
                      onPressed: onLike,
                    ),
                    Text(likes),
                    Text(
                      likes.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(
                        Icons.message,
                        color: Colors.grey,
                      ),
                      onPressed: () => Get.to(() => CommentScreen(postId: id)),
                    ),
                    const Text(
                      "comments",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.grey),
                  onPressed: () {
                    // Handle share
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:chewie/chewie.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hage_mobile_app/src/features/Taps/screens/Home/Posts/widgets/Comments.dart';
// import 'package:hage_mobile_app/src/features/personalization/screens/Profile/UserProfile.dart';
// import 'package:video_player/video_player.dart';
// import 'package:timeago/timeago.dart' as timeago;
//
// import '../../../../../../utils/constants/Colors.dart';
// import '../../../../../personalization/controllers/user_controller.dart';
// import '../../../../controllers/PostsController/PostsController.dart';
//
// class PostContainer extends StatelessWidget {
//   final String id;
//   final String username;
//   final DateTime postTime;
//   final String content;
//   final String postImage;
//   final String likes;
//   final String profilePicture;
//   final String postVideo;
//
//   const PostContainer({
//     required this.id,
//     required this.username,
//     required this.postTime,
//     required this.content,
//     required this.postImage,
//     required this.likes,
//     required this.profilePicture,
//     required this.postVideo,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
//       child: Card(
//         color: BColors.white,
//         child: Container(
//           padding: const EdgeInsets.all(8),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               ListTile(
//                 leading: GestureDetector(
//                   onTap: () => Get.to(()=> UserProfilePage()),
//                   child: CircleAvatar(
//                     backgroundImage: NetworkImage(profilePicture),
//                   ),
//                 ),
//                 title: GestureDetector( onTap:()=> Get.to(()=> UserProfilePage()), child: Text(username)),
//                 subtitle: Text(
//                   timeago.format(postTime, locale: 'Somali'),
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               ),
//               Text(
//                 content,
//                 style: const TextStyle(fontSize: 18),
//                 textAlign: TextAlign.start,
//               ),
//               const SizedBox(height: 10),
//               postImage.isNotEmpty
//                   ? SizedBox(
//                 width: 370,
//                 height: 300,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(15),
//                   child: Image.network(
//                     postImage,
//                     fit: BoxFit.fill,
//                     errorBuilder: (context, error, stackTrace) =>
//                     const Text('Failed to load image'),
//                   ),
//                 ),
//               )
//                   : postVideo.isNotEmpty
//                   ? SizedBox(
//                   width: 370,
//                   height: 300,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: AspectRatio(
//                       aspectRatio: 16 / 9,
//                       child: Chewie(
//                         controller: ChewieController(
//                           videoPlayerController:
//                           VideoPlayerController.networkUrl(
//                               Uri.parse(postVideo)),
//                           autoPlay: false,
//                           looping: false,
//                         ),
//                       ),
//                     ),
//                   ))
//                   : const SizedBox(),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(
//                           Icons.favorite,
//                           color: BColors.primaryColor,
//                         ),
//                         onPressed: () {},
//                       ),
//                       Text(
//                         likes.toString(),
//                         style: const TextStyle(fontSize: 18),
//                       ),
//                       const SizedBox(width: 10),
//                       IconButton(
//                         icon: const Icon(
//                           Icons.message,
//                           color: BColors.primaryColor,
//                         ),
//                         onPressed: () => Get.to(
//                               () => CommentScreen(
//                             postId: id,
//                           ),
//                         ),
//                       ),
//                       const Text(
//                         "comments",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ],
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.share, color: Colors.grey),
//                     onPressed: () {
//                       // Handle share
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
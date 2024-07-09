// import 'package:flutter/material.dart';
//
// import '../../../../models/comments_model.dart';
//
// class UserPostContainer extends StatelessWidget {
//   final String username;
//   final DateTime postTime;
//   final String content;
//   final String? postImage;
//   final int likes;
//   final String profilePicture;
//   final String? postVideo;
//
//   const UserPostContainer({
//     required this.username,
//     required this.postTime,
//     required this.content,
//     this.postImage,
//     required this.likes,
//     required this.profilePicture,
//     this.postVideo,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           ListTile(
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(profilePicture),
//             ),
//             title: Text(username),
//             subtitle: Text(postTime.toString()),
//           ),
//           Text(content),
//           if (postImage != null) Image.network(postImage!),
//           if (postVideo != null) // Display video widget
//           // Add video widget here
//             Text('Video content here'),
//           Row(
//             children: [
//               Text('Likes: $likes'),
//               Text('Comments: $comments'),
//             ],
//           ),
//           // Display comments
//           Column(
//             children: commentList.map((comment) {
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(comment.authorProfilePicture),
//                 ),
//                 title: Text(comment.authorName),
//                 subtitle: Text(comment.content),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

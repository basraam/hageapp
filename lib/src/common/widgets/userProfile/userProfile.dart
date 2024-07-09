// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hage_mobile_app/src/common/widgets/userProfile/profileImage.dart';
//
// import '../../../features/Taps/screens/Home/Posts/post.dart';
// import '../../../features/personalization/screens/Profile/my_profile.dart';
// import '../../../utils/constants/images.dart';
// class userProfile extends StatelessWidget {
//   const userProfile({
//     super.key,
//     required this.widget,
//     required this.profilePic
//   });
//
//   final PostContainer widget;
//   final String profilePic;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: ()=>Get.to(()=> MyProfilePage()),
//       child: Row(
//         children: [
//            profileImage(img:profilePic, radius: 20, width: 42, height: 42,),
//           const SizedBox(width: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.username,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               Text(
//                 widget.postTime.toString(),
//                 style: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

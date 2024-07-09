// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hage_mobile_app/src/utils/constants/BSizes.dart';
// import 'package:hage_mobile_app/src/utils/constants/images.dart';
//
// import 'package:hage_mobile_app/src/data/models/singleChat_model.dart'; // Assuming this is where SMessage is imported from
// import 'package:hage_mobile_app/src/utils/constants/Colors.dart';
// import '../../../../../../utils/firebase.dart';
// import 'messeges.dart';
// import 'chatBubble.dart';
//
// class ChatPage extends StatelessWidget {
//   final List<SMessage> messages = [
//     SMessage(
//       id: '1',
//       userRef: firebaseAuth.currentUser!.uid,
//       contentText: "Hello, how are you?",
//       contentImage: '',
//       contentVideo: '',
//       contentDocument: '',
//       timestamp: DateTime.now(),
//     ),
//     SMessage(
//       id: '2',
//       userRef: 'some_other_user_id',
//       contentText: "I'm fine, thanks!",
//       contentImage: '',
//       contentVideo: '',
//       contentDocument: '',
//       timestamp: DateTime.now(),
//     ),
//     // Add more messages as needed
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF7F7F7),
//       appBar: AppBar(
//         backgroundColor: Color(0xFFF7F7F7),
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.green),
//           onPressed: () => Get.back(),
//         ),
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: AssetImage(BImages.profilePicture), // Replace with your image asset
//             ),
//             SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Asia Hassan',
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 Text(
//                   'Online',
//                   style: TextStyle(color: Colors.green, fontSize: 12),
//                 ),
//               ],
//             )
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.videocam, color: Colors.green),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.call, color: Colors.green),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: BSizes.sm),
//           Center(
//             child: Text(
//               "maanta",
//               style: TextStyle(color: BColors.secondaryColor),
//             ),
//           ),
//
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 return BChatBubble(message: message);
//               },
//             ),
//           ),
//
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.attach_file, color: Colors.black),
//                   onPressed: () {
//                     // Implement attachment handling
//                   },
//                 ),
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Type here.....',
//                       filled: true,
//                       fillColor: Colors.grey[300],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.mic, color: Colors.black),
//                   onPressed: () {
//                     // Implement voice message recording
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

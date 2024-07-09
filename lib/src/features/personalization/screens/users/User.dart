// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hage_mobile_app/src/utils/constants/images.dart';
// import '../Profile/my_profile.dart';
// import '../EditUser/EditUser_Page.dart';
//
// class UserInfoPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('User Info'),
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             const CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage(BImages.profilePicture),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Basra Abdulkadir',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const Text('@Basraam', style: TextStyle(color: Colors.grey)),
//             SizedBox(height: 16),
//             ListTile(
//               leading: Icon(Icons.person, color: Colors.green),
//               title: Text('Fiiri profile-ka'),
//               trailing: Icon(Icons.arrow_forward),
//               onTap: () {
//                 Get.to(()=> const ProfilePage());
//               },
//             ),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.settings, color: Colors.green),
//               title: Text('wax ka badal profile-ka'),
//               trailing: Icon(Icons.arrow_forward),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => EditUserPage()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
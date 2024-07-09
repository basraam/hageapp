// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../utils/constants/Colors.dart';
//
// // Models
//
// class Group {
//   final String id;
//   final String groupName;
//   final String groupTag;
//   final String description;
//   final String groupCoverImage;
//   final int membersCount;
//
//   Group({
//     required this.id,
//     required this.groupName,
//     required this.groupTag,
//     required this.description,
//     required this.groupCoverImage,
//     required this.membersCount,
//   });
//
//   factory Group.fromFirestore(DocumentSnapshot doc) {
//     var data = doc.data() as Map<String, dynamic>;
//     return Group(
//       id: doc.id,
//       groupName: data['groupName'] ?? '',
//       groupTag: data['groupTag'] ?? '',
//       description: data['description'] ?? '',
//       groupCoverImage: data['groupCoverImage'] ?? '',
//       membersCount: data['membersCount'] ?? 0,
//     );
//   }
// }
//
// class GroupChatMessage {
//   final String id;
//   final DocumentReference userId;
//   final String messageContent;
//   final Timestamp timestamp;
//
//   GroupChatMessage({
//     required this.id,
//     required this.userId,
//     required this.messageContent,
//     required this.timestamp,
//   });
//
//   factory GroupChatMessage.fromFirestore(DocumentSnapshot doc) {
//     var data = doc.data() as Map<String, dynamic>;
//     return GroupChatMessage(
//       id: doc.id,
//       userId: data['userId'],
//       messageContent: data['messageContent'] ?? '',
//       timestamp: data['timestamp'] ?? Timestamp.now(),
//     );
//   }
// }
//
// // Group Details Page
//
// class GroupDetailsPage extends StatelessWidget {
//   final String groupId;
//
//   GroupDetailsPage({required this.groupId});
//
//   Stream<Group> _getGroupDetails() {
//     return FirebaseFirestore.instance.collection('Groups').doc(groupId).snapshots().map(
//           (doc) => Group.fromFirestore(doc),
//     );
//   }
//
//   Stream<List<GroupMember>> _getGroupMembers() {
//     return FirebaseFirestore.instance
//         .collection('Groups')
//         .doc(groupId)
//         .collection('groupMembers')
//         .snapshots()
//         .map((snapshot) =>
//         snapshot.docs.map((doc) => GroupMember.fromFirestore(doc)).toList());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.green),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: StreamBuilder<Group>(
//           stream: _getGroupDetails(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return const CircularProgressIndicator();
//             }
//             var group = snapshot.data!;
//             return Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(group.groupCoverImage),
//                 ),
//                 const SizedBox(width: 10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       group.groupName,
//                       style: const TextStyle(color: Colors.black),
//                     ),
//                     Text(
//                       'Group · ${group.membersCount} members',
//                       style: const TextStyle(color: Colors.grey, fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               color: Colors.grey[200],
//               child: const ListTile(
//                 leading: Icon(Icons.photo, color: Colors.black),
//                 title: Text('Media, Links'),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: StreamBuilder<Group>(
//                 stream: _getGroupDetails(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return const Text(
//                       'Loading...',
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                     );
//                   }
//                   var group = snapshot.data!;
//                   return Text(
//                     '${group.membersCount} members',
//                     style: const TextStyle(color: Colors.black, fontSize: 16),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<List<GroupMember>>(
//               stream: _getGroupMembers(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 var members = snapshot.data!;
//                 return ListView.builder(
//                   itemCount: members.length,
//                   itemBuilder: (context, index) {
//                     final member = members[index];
//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(member.profilePicture),
//                       ),
//                       title: Text(member.name),
//                       subtitle: Text(member.id), // Adjust as per your data structure
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     // Add leave group functionality
//                   },
//                   style: TextButton.styleFrom(
//                     backgroundColor: BColors.errorColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: const SizedBox(
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.exit_to_app,
//                           color: BColors.white,
//                         ),
//                         SizedBox(width: 3),
//                         Text('Ka bax kooxda',
//                             style: TextStyle(
//                                 color: BColors.white,
//                                 fontWeight: FontWeight.w900,
//                                 fontFamily: 'Tw Cen MT',
//                                 fontSize: 14)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // Add report issue functionality
//                   },
//                   style: TextButton.styleFrom(
//                     backgroundColor: BColors.primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: const SizedBox(
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.report_problem,
//                           color: BColors.white,
//                         ),
//                         SizedBox(width: 3),
//                         Text('Ka warbixi dhibaato',
//                             style: TextStyle(
//                                 color: BColors.white,
//                                 fontWeight: FontWeight.w900,
//                                 fontFamily: 'Tw Cen MT',
//                                 fontSize: 14)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Group Chat Page
//
// class GroupChatPage extends StatelessWidget {
//   final Group group;
//
//   const GroupChatPage({required this.group});
//
//   Stream<List<GroupChatMessage>> _getMessages() {
//     return FirebaseFirestore.instance
//         .collection('Groups')
//         .doc(group.id)
//         .collection('GroupChat')
//         .orderBy('timestamp')
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//         .map((doc) => GroupChatMessage.fromFirestore(doc))
//         .toList());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF7F7F7),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.green),
//           onPressed: () => Get.back(),
//         ),
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(group.groupCoverImage),
//             ),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   group.groupName,
//                   style: const TextStyle(color: Colors.black, fontSize: 14),
//                 ),
//                 Text(
//                   '${group.membersCount} members',
//                   style: const TextStyle(color: Colors.green, fontSize: 12),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add_call, color: Colors.green),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.info_rounded, color: Colors.green),
//             onPressed: () => Get.to(() => GroupDetailsPage(groupId: group.id)),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<List<GroupChatMessage>>(
//               stream: _getMessages(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 var messages = snapshot.data!;
//                 return ListView.builder(
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var message = messages[index];
//                     return MessageBubble(
//                       sender: message.userId.id,  // You may need to fetch the sender's info using userId reference
//                       text: message.messageContent,
//                       isMe: message.userId.id == 'currentUserId',  // Replace with actual current user ID logic
//                       timestamp: message.timestamp,
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: MessageInputField(groupId: group.id),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MessageInputField extends StatelessWidget {
//   final String groupId;
//
//   const MessageInputField({required this.groupId});
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _controller = TextEditingController();
//
//     void _sendMessage() async {
//       if (_controller.text.isEmpty) return;
//
//       var message = GroupChatMessage(
//         id: '',  // Firestore will auto-generate this
//         userId: FirebaseFirestore.instance.collection('Users').doc('currentUserId'),  // Replace with actual current user ID logic
//         messageContent: _controller.text,
//         timestamp: Timestamp.now(),
//       );
//
//       await FirebaseFirestore.instance
//           .collection('Groups')
//           .doc(groupId)
//           .collection('GroupChat')
//           .add({
//         'userId': message.userId,
//         'messageContent': message.messageContent,
//         'timestamp': message.timestamp,
//       });
//
//       _controller.clear();
//     }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: 'Type a message...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send, color: Colors.green),
//             onPressed: _sendMessage,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // message_repository.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../features/Taps/screens/Groups/kooxahaaga/models/groupMessages_model.dart';
//
// class MessageRepository {
//   final CollectionReference groupCollection = FirebaseFirestore.instance.collection('groups');
//
//   Stream<List<Message>> getMessages(String groupId) {
//     return groupCollection.doc(groupId).collection('messages').orderBy('timestamp').snapshots().map((snapshot) =>
//         snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList());
//   }
//
//   Future<void> sendMessage(String groupId, Message message) async {
//     await groupCollection.doc(groupId).collection('messages').add(message.toMap());
//   }
//
// // Add other necessary methods like updating or deleting messages.
// }

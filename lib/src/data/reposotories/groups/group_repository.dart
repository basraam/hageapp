// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../models/groups_model.dart';
//
// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   // Create a new group
//   Future<void> createGroup(Group group) async {
//     await _db.collection('Groups').doc(group.id).set(group.to());
//   }
//
//   // Add a member to a group
//   Future<void> addMemberToGroup(String groupId, GroupMember member) async {
//     await _db
//         .collection('Groups')
//         .doc(groupId)
//         .collection('groupMembers')
//         .doc(member.id)
//         .set(member.toFirestore());
//   }
//
//   // Send a message in a group chat
//   Future<void> sendMessageToGroupChat(String groupId, GroupChatMessage message) async {
//     await _db
//         .collection('Groups')
//         .doc(groupId)
//         .collection('GroupChat')
//         .add(message.toFirestore());
//   }
//
//   // Stream group chat messages
//   Stream<List<GroupChatMessage>> getGroupChatMessages(String groupId) {
//     return _db
//         .collection('Groups')
//         .doc(groupId)
//         .collection('GroupChat')
//         .orderBy('timestamp')
//         .snapshots()
//         .map((query) =>
//         query.docs.map((doc) => GroupChatMessage.fromFirestore(doc)).toList());
//   }
// }

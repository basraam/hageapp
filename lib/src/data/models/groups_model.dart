import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  final String id;
  final String groupName;
  final String groupTag;
  final String description;
  final String groupCoverImage;
  final int membersCount;
  final String groupType;

  Group({
    required this.id,
    required this.groupName,
    required this.groupTag,
    required this.description,
    required this.groupCoverImage,
    required this.membersCount,
    required this.groupType,
  });

  factory Group.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Group(
      id: doc.id,
      groupName: data['groupName'] ?? '',
      groupTag: data['groupTag'] ?? '',
      description: data['description'] ?? '',
      groupCoverImage: data['groupCoverImage'] ?? '',
      membersCount: data['membersCount'] ?? 0,
      groupType: data['groupType'] ?? 'public',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'groupName': groupName,
      'groupTag': groupTag,
      'description': description,
      'groupCoverImage': groupCoverImage,
      'membersCount': membersCount,
      'groupType': groupType,
    };
  }

  Future<void> addMember(String userId) async {
    final groupRef = FirebaseFirestore.instance.collection('Groups').doc(id);
    final groupMembersRef = groupRef.collection('groupMembers');

    await groupMembersRef.doc(userId).set({
      'userId': userId,
      'joinedAt': Timestamp.now(),
      'memberType': 'member', // or 'admin' based on your requirement
    });

    await groupRef.update({
      'membersCount': FieldValue.increment(1),
    });
  }
}



class GroupChatMessage {
  final String id;
  final DocumentReference userId;
  final String messageContent;
  final Timestamp timestamp;

  GroupChatMessage({
    required this.id,
    required this.userId,
    required this.messageContent,
    required this.timestamp,
  });

  factory GroupChatMessage.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return GroupChatMessage(
      id: doc.id,
      userId: data['userId'],
      messageContent: data['messageContent'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
class GroupMember {
  final String id;
  final String userId;
  final String groupType;
  final String memberType;
  final String name;  // Assuming you have a field for member's name
  final String profilePicture;  // Assuming you have a field for member's profile picture

  GroupMember({
    required this.id,
    required this.userId,
    required this.groupType,
    required this.memberType,
    required this.name,
    required this.profilePicture,
  });

  factory GroupMember.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return GroupMember(
      id: doc.id,
      userId: data['userId'] ?? '',
      groupType: data['groupType'] ?? '',
      memberType: data['memberType'] ?? '',
      name: data['name'] ?? '',
      profilePicture: data['profilePicture'] ?? '',
    );
  }
}

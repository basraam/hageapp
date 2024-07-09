import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String id;
  DocumentReference friendId;
  DocumentReference userId;

  Chat({
    required this.id,
    required this.friendId,
    required this.userId,
  });

  factory Chat.fromSnapshot(DocumentSnapshot doc) {
    return Chat(
      id: doc.id,
      friendId: doc['friendId'],
      userId: doc['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'friendId': friendId,
      'userId': userId,
    };
  }
}

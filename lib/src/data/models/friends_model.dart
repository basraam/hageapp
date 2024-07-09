import 'package:cloud_firestore/cloud_firestore.dart';

class Friend {
  String id;
  DocumentReference userId;

  Friend({
    required this.id,
    required this.userId,
  });

  factory Friend.fromSnapshot(DocumentSnapshot doc) {
    return Friend(
      id: doc.id,
      userId: doc['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }
}

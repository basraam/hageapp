import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final DocumentReference userRef;
  final String username;
  final String userDp;
  final String postId;
  final String type; // 'message', 'friend_request', 'post_reaction', 'comment'
  final Timestamp timestamp;

  NotificationModel({
    required this.id,
    required this.userRef,
    required this.username,
    required this.userDp,
    required this.postId,
    required this.type,
    required this.timestamp,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userRef: json['userRef'],
      username: json['username'],
      userDp: json['userDp'],
      postId: json['postId'],
      type: json['type'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userRef': userRef,
      'username': username,
      'userDp': userDp,
      'postId': postId,
      'type': type,
      'timestamp': timestamp,
    };
  }
}

void addNotification(NotificationModel notification) async {
  await FirebaseFirestore.instance
      .collection('notifications')
      .doc(notification.userRef.id)
      .collection('userNotifications')
      .doc(notification.id)
      .set(notification.toJson());
}

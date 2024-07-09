import 'package:flutter/material.dart';
import '../../data/models/notification_model.dart';

class ViewNotificationDetails extends StatelessWidget {
  final NotificationModel notification;

  ViewNotificationDetails({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.type == 'message'
                  ? 'Message from ${notification.username}'
                  : notification.type == 'friend_request'
                  ? 'Friend Request from ${notification.username}'
                  : notification.type == 'post_reaction'
                  ? 'Post Reaction from ${notification.username}'
                  : notification.type == 'comment'
                  ? 'Comment from ${notification.username}'
                  : 'Notification from ${notification.username}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            notification.userDp.isNotEmpty
                ? Image.network(notification.userDp)
                : Container(),
            SizedBox(height: 16.0),
            Text(
              'Timestamp: ${notification.timestamp.toDate()}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}

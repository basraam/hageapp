import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample notifications
    final notifications = [
      'You have a new friend request',
      'Your post received a new like',
      'Someone commented on your post',
      'You have a new follower',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notifications, color: Colors.green),
            title: Text(notifications[index]),
            onTap: () {
              // Handle notification tap if needed
            },
          );
        },
      ),
    );
  }
}

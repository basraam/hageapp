import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Notification_items.dart';
import 'Notification_widget.dart';
import '../../data/models/notification_model.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  String currentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Notifications'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: deleteAllItems,
              child: Text(
                'CLEAR',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [getActivities()],
      ),
    );
  }

  Widget getActivities() {
    return NotificationStreamWrapper(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      stream: FirebaseFirestore.instance
          .collection('notifications')
          .doc(currentUserId())
          .collection('userNotifications')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      itemBuilder: (context, doc) {
        NotificationModel notification =
        NotificationModel.fromJson(doc.data() as Map<String, dynamic>);
        return NotificationItem(notification: notification);
      },
    );
  }

  void deleteAllItems() async {
    final batch = FirebaseFirestore.instance.batch();
    var querySnapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .doc(currentUserId())
        .collection('userNotifications')
        .get();
    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}

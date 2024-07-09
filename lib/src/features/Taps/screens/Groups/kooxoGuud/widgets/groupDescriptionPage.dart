import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../../../data/models/groups_model.dart';
import '../../groupChats/groupChat_page.dart';

class GroupDescriptionPage extends StatelessWidget {
  final Group group;
  final String userId;

  const GroupDescriptionPage({required this.group, required this.userId});

  Future<void> _joinGroup(BuildContext context) async {
    try {
      // Add user to group members subcollection
      await FirebaseFirestore.instance
          .collection('Groups')
          .doc(group.id)
          .collection('groupMembers')
          .doc(userId)
          .set({
        'userId': userId,
        'groupType': 'general', // Example field, adjust based on your data model
        'memberType': 'member', // Example field, adjust based on your data model
      });

      // Optionally, update the group's member count
      await FirebaseFirestore.instance
          .collection('Groups')
          .doc(group.id)
          .update({
        'membersCount': FieldValue.increment(1),
      });

      print('User successfully joined the group');

      // Navigate to GroupChatPage if logged in
      Get.off(() => GroupChatPage(group: group)); // Replace with your navigation logic
    } catch (e) {
      print('Failed to join the group: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if user is logged in (replace with your actual login check)
    bool isLoggedIn = true; // Example: Replace with your actual login check

    if (isLoggedIn) {
      // If logged in, navigate to GroupChatPage
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Get.off(() => GroupChatPage(group: group)); // Replace with your navigation logic
      });

      // Return an empty container while navigating
      return  Container();
    }

    // If not logged in, show GroupDescriptionPage
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Profile'),
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  group.groupCoverImage,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.groupName,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      group.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.group, size: 16, color: Colors.grey[700]),
                        SizedBox(width: 4),
                        Text(
                          '${group.membersCount} members',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => _joinGroup(context),
                        child: Text('Join'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

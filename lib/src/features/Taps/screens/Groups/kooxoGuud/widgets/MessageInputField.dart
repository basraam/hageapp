import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/groups_model.dart';

class MessageInputField extends StatelessWidget {
  final String groupId;

  const MessageInputField({required this.groupId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    void _sendMessage() async {
      if (_controller.text.isEmpty) return;

      var message = GroupChatMessage(
        id: '',  // Firestore will auto-generate this
        userId: FirebaseFirestore.instance.collection('users').doc('currentUserId'),  // Replace with actual current user ID logic
        messageContent: _controller.text,
        timestamp: Timestamp.now(),
      );

      await FirebaseFirestore.instance
          .collection('Groups')
          .doc(groupId)
          .collection('GroupChat')
          .add({
        'userId': message.userId,
        'messageContent': message.messageContent,
        'timestamp': message.timestamp,
      });

      _controller.clear();
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.green),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

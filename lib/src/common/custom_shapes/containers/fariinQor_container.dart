import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FariinQorContainer extends StatefulWidget {
  final String groupId;

  const FariinQorContainer({super.key, required this.groupId});

  @override
  _FariinQorContainerState createState() => _FariinQorContainerState();
}

class _FariinQorContainerState extends State<FariinQorContainer> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('Groups')
          .doc(widget.groupId)
          .collection('GroupChat')
          .add({
        'userId': 'YOUR_USER_ID',  // Replace with the current user's ID
        'messageContent': _controller.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

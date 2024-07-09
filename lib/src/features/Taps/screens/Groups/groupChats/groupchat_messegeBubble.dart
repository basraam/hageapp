import 'package:flutter/material.dart';

import '../../../../../utils/helpers/helper_functions.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;
  final String time;
  final bool isMe;

  const MessageBubble({
    required this.sender,
    required this.message,
    required this.time,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              color: dark ? (isMe ? Colors.white : Colors.white) : (isMe ? Colors.grey[700] : Colors.grey[800]),

              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(16) : Radius.circular(0),
              topRight: isMe ? Radius.circular(0) : Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: isMe ? Colors.green : Colors.white,
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 2),
          Text(
            time,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}


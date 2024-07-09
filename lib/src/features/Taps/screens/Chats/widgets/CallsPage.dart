import 'package:flutter/material.dart';

import '../../../../../utils/constants/images.dart';

class CallsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Replace with the number of calls
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(BImages.newMessage), // Replace with your image asset
          ),
          title: Text('Caller Name ${index + 1}'),
          subtitle: Text('0123456789'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.call, color: Colors.green),
                onPressed: () {
                  // TODO: Implement voice call functionality
                },
              ),
              IconButton(
                icon: Icon(Icons.videocam, color: Colors.green),
                onPressed: () {
                  // TODO: Implement video call functionality
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

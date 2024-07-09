import 'package:flutter/material.dart';

import '../../../../../data/models/friends_model.dart';
import '../../../../../data/reposotories/chats/chat_repository.dart';
import 'chat_view.dart';

class FriendsView extends StatefulWidget {
  final String userId;

  FriendsView({required this.userId});

  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {
  final ChatFirestoreRepository _repository = ChatFirestoreRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body: StreamBuilder<List<Friend>>(
        stream: _repository.getFriends(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Friend friend = snapshot.data![index];
              return ListTile(
                title: Text(friend.userId.id), // Fetch user data if needed
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatsView(userId: widget.userId, friendId: friend.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

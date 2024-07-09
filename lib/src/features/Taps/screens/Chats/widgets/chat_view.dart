import 'package:flutter/material.dart';
import '../../../../../data/models/chat_model.dart';
import '../../../../../data/reposotories/chats/chat_repository.dart';
import 'message_view.dart';

class ChatsView extends StatefulWidget {
  final String userId;
  final String friendId;

  ChatsView({required this.userId, required this.friendId});

  @override
  _ChatsViewState createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  final ChatFirestoreRepository _repository = ChatFirestoreRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: StreamBuilder<List<Chat>>(
        stream: _repository.getChats(widget.userId),
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
              Chat chat = snapshot.data![index];
              return ListTile(
                title: Text(chat.friendId.id), // Fetch friend data if needed
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(),
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

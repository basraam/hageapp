import 'package:flutter/material.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Chats/widgets/CallsPage.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Chats/widgets/ChatsPage.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Chats/widgets/freinds_view.dart';

import '../../../../utils/constants/Colors.dart';
class MessagesPage extends StatelessWidget {
  final String userId;

  const MessagesPage({super.key, required this.userId});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Wada sheekaysiyo',
            style: TextStyle(color: Colors.green),
          ),
          centerTitle: true,
          backgroundColor: BColors.backgroundColor,
          bottom: TabBar(
            labelColor: BColors.primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.green,
            tabs: [
              Tab(icon: Icon(Icons.group), text: 'Asxaab'),
              Tab(icon: Icon(Icons.chat), text: 'wada sheekaysi'),
              Tab(icon: Icon(Icons.call), text: 'wicitaano'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FriendsView(userId: userId),
            ChatScreen(friendId: "friendId", chatId: "chatId"),
            CallsPage(),
          ],
        ),
      ),
    );
  }
}
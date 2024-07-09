import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;

class SingleCommentContainer extends StatelessWidget {
  final String username;
  final String profilePicture;
  final DateTime postTime;
  final String commentContent;
  final int likes;
  final String commentId; // Add this field for comment ID
  final Function() onLike;
  final bool isLiked;

  const SingleCommentContainer({
    Key? key,
    required this.username,
    required this.profilePicture,
    required this.postTime,
    required this.commentContent,
    required this.likes,
    required this.commentId,
    required this.onLike,
    required this.isLiked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(profilePicture),
            ),
            title: Text(username),
            subtitle: Text(
              timeago.format(postTime, locale: 'en_short'),
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Text(commentContent),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  size: 20,
                  color: isLiked ? Colors.green : Colors.grey,
                ),
                onPressed: onLike,
              ),
              Text('$likes'),
            ],
          ),
        ],
      ),
    );
  }
}

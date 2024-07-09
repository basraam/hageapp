import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {

  const CommentWidget(
      {super.key,
      required this.author,
      required this.timeAgo,
      required this.comment,
      required this.numberOfLikes,
      required this.numberOfReplies});

  final String author;
  final String timeAgo;
  final String comment;
  final int numberOfLikes;
  final int numberOfReplies;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Text(author[0].toUpperCase()),
          ),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              author,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              timeAgo,
              style: const TextStyle(color: Colors.grey),
            ),
          ]),
        ]),
        const SizedBox(height: 8),
        Text(comment, textAlign: TextAlign.justify),
        Row(children: [
          IconButton(
            icon: const Icon(Icons.thumb_up),
            onPressed: () {
              // Handle like functionality
            },
          ),
          Text('$numberOfLikes'),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.reply),
            onPressed: () {
              // Handle reply functionality
            },
          ),
          Text('$numberOfReplies'),
        ]),
      ]),
    );
  }
}

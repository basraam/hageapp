import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Home/widgets/homeAppBar.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../data/models/notification_model.dart';
import 'NotificationDetails.dart';

class NotificationItem extends StatefulWidget {
  final NotificationModel notification;

  NotificationItem({required this.notification});

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(widget.notification),
      background: stackBehindDismiss(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        delete();
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (_) => widget.notification.type == "friend_request"
                  ? BHomeAppBar(username: widget.notification.username, userId: widget.notification.userRef.id)
                  : ViewNotificationDetails(notification: widget.notification),
            ),
          );
        },
        leading: widget.notification.userDp.isEmpty
            ? CircleAvatar(
          radius: 20.0,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Center(
            child: Text(
              widget.notification.username[0].toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
            : CircleAvatar(
          radius: 20.0,
          backgroundImage: CachedNetworkImageProvider(
            widget.notification.userDp,
          ),
        ),
        title: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
            children: [
              TextSpan(
                text: '${widget.notification.username} ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              TextSpan(
                text: buildTextConfiguration(),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
        subtitle: Text(
          timeago.format(widget.notification.timestamp.toDate()),
        ),
        trailing: previewConfiguration(),
      ),
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Theme.of(context).colorScheme.secondary,
      child: Icon(
        CupertinoIcons.delete,
        color: Colors.white,
      ),
    );
  }

  void delete() {
    FirebaseFirestore.instance
        .collection('notifications')
        .doc(widget.notification.userRef.id)
        .collection('userNotifications')
        .doc(widget.notification.id)
        .delete();
  }

  String buildTextConfiguration() {
    switch (widget.notification.type) {
      case 'message':
        return 'sent you a message.';
      case 'friend_request':
        return 'sent you a friend request.';
      case 'post_reaction':
        return 'reacted to your post.';
      case 'comment':
        return 'commented on your post.';
      default:
        return 'has a new activity.';
    }
  }

  Widget? previewConfiguration() {
    if (widget.notification.type == 'post_reaction' ||
        widget.notification.type == 'comment') {
      return Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: 50.0,
            width: 50.0,
            child: widget.notification.userDp.isNotEmpty
                ? Image(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                widget.notification.userDp,
              ),
            )
                : Container(),
          ),
        ),
      );
    } else {
      return null;
    }
  }
}

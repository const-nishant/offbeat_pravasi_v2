import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:offbeat_pravasi_v2/modules/home/data/dataexports.dart';
import 'package:provider/provider.dart';

class NotificationTile extends StatelessWidget {
  final String username;
  final String message;
  final String messageId;
  final String timeAgo;
  final String avatarUrl;
  final String senderId;

  const NotificationTile({
    super.key,
    required this.username,
    required this.message,
    required this.timeAgo,
    this.avatarUrl = "",
    required this.messageId,
    required this.senderId,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            label: 'Accept',
            backgroundColor: Colors.green,
            icon: Icons.check,
            onPressed: (context) {
              Provider.of<HomeServices>(context, listen: false)
                  .acceptFriendRequest(messageId, senderId);
            },
            autoClose: true,
          ),
          SlidableAction(
            label: 'Decline',
            backgroundColor: Colors.red,
            icon: Icons.close,
            onPressed: (context) {
              Provider.of<HomeServices>(context, listen: false)
                  .declineFriendRequest(messageId);
            },
            autoClose: true,
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey[300],
          backgroundImage:
              avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
          child: avatarUrl.isEmpty
              ? Icon(Icons.person, color: Theme.of(context).colorScheme.primary)
              : null,
        ),
        title: Text(
          "$username $message",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          timeAgo,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

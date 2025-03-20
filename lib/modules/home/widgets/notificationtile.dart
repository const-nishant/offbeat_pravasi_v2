import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationTile extends StatelessWidget {
  final String username;
  final String message;
  final String messageId;
  final String timeAgo;
  final String avatarUrl;

  const NotificationTile({
    super.key,
    required this.username,
    required this.message,
    required this.timeAgo,
    this.avatarUrl = "",
    required this.messageId, // Default empty for placeholder
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),
            icon: Icons.delete,
            onPressed: (context) {
              // Handle delete notification action here
            },
            autoClose: true,
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey[300], // Placeholder color
          backgroundImage:
              avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
          child: avatarUrl.isEmpty
              ? Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                )
              : null,
        ),
        title: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 14),
            children: [
              TextSpan(
                text: "$username ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: message,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        subtitle: Text(
          timeAgo,
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

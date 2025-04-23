import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String uid;
  final String username;
  final String comment;
  final String? userimage;
  final String time;

  const CommentCard({
    super.key,
    required this.username,
    required this.comment,
    required this.userimage,
    required this.time,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: userimage != null
          ? CircleAvatar(
              radius: 18,
              backgroundImage: CachedNetworkImageProvider(userimage!),
            )
          : const CircleAvatar(
              radius: 18,
              child: Icon(Icons.person_2_outlined),
            ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            username,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
      subtitle: Text(
        comment,
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

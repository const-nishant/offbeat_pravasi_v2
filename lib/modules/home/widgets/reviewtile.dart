import 'package:flutter/material.dart';

class ReviewTile extends StatelessWidget {
  final String username;
  final String profileImage;
  final double rating;
  final String review;

  const ReviewTile({
    super.key,
    required this.username,
    required this.profileImage,
    required this.rating,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      leading: profileImage.isNotEmpty
          ? CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(profileImage),
            )
          : const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
      title: Row(
        children: [
          Text(
            username,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      subtitle: Text(
        review,
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}

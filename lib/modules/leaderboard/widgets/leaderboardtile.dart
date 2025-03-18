import 'package:flutter/material.dart';

class LeaderboardTile extends StatelessWidget {
  final String userId;
  final int rank;
  final String username;
  final int points;
  final void Function()? onTap;
  final String imageUrl; // User profile image

  const LeaderboardTile({
    super.key,
    required this.rank,
    required this.username,
    required this.points,
    this.imageUrl = "",
    required this.userId,
    this.onTap, // Default empty
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: onTap,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 26,
              child: Text(
                rank.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center, // Center align the text
              ),
            ),
            const SizedBox(width: 16), // Spacing
            CircleAvatar(
              radius: 24, // Adjust size
              backgroundColor: Colors.grey[300], // Placeholder color
              backgroundImage:
                  imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
              child: imageUrl.isEmpty
                  ? const Icon(Icons.person, color: Colors.white)
                  : null,
            ),
          ],
        ),
        title: Text(
          username,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        trailing: Text(
          "$points pts",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}

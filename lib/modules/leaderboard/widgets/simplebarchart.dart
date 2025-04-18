import 'package:flutter/material.dart';

import '../data/services/leaderboard_services.dart';

class SimpleBarChart extends StatelessWidget {
  final List<LeaderboardUser> topUsers;
  final double width;
  final double height;

  const SimpleBarChart({
    super.key,
    required this.width,
    required this.height,
    required this.topUsers,
  });

  @override
  Widget build(BuildContext context) {
    if (topUsers.length < 3) {
      return const Center(
          child: Text('Not enough users to display leaderboard.'));
    }

    // Display order: 2nd (left), 1st (center), 3rd (right)
    final sortedTopUsers = [topUsers[1], topUsers[0], topUsers[2]];

    final maxPoints =
        sortedTopUsers.map((u) => u.points).reduce((a, b) => a > b ? a : b);

    final multipliers = [0.85, 1.0, 0.75]; // 2nd, 1st, 3rd
    final heights = List.generate(3, (index) {
      final percentage = sortedTopUsers[index].points / maxPoints;
      return 80 + (percentage * 50 * multipliers[index]); // Scaled height
    });

    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: Theme.of(context).colorScheme.onInverseSurface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(3, (index) {
          final user = sortedTopUsers[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              Text(
                "${user.points} pts",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Text(
                  user.rank.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 70,
                height: heights[index],
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

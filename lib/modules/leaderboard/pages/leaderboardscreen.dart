import 'package:flutter/material.dart';

import '../exports.dart';

class Leaderboardscreen extends StatefulWidget {
  const Leaderboardscreen({super.key});

  @override
  State<Leaderboardscreen> createState() => _LeaderboardscreenState();
}

class _LeaderboardscreenState extends State<Leaderboardscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SimpleBarChart(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => LeaderboardTile(
                    userId: '',
                    points: 100,
                    rank: index + 1,
                    username: 'User ${index + 1}',
                    imageUrl: '',
                  ),
                  childCount: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

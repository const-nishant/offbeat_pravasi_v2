import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../module_exports.dart';

class Leaderboardscreen extends StatefulWidget {
  const Leaderboardscreen({super.key});

  @override
  State<Leaderboardscreen> createState() => _LeaderboardscreenState();
}

class _LeaderboardscreenState extends State<Leaderboardscreen> {
  @override
  void initState() {
    super.initState();
    // Fetch leaderboard data on screen load
    Future.microtask(() {
      Provider.of<LeaderboardServices>(context, listen: false)
          .fetchAndRankUsers();
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // SimpleBarChart (top 3 users display)
            SliverToBoxAdapter(
              child: Consumer<LeaderboardServices>(
                builder: (context, service, child) {
                  final top3 = service.users.take(3).toList();
                  return SimpleBarChart(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    topUsers: top3,
                  );
                },
              ),
            ),

            // Leaderboard List
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: Consumer<LeaderboardServices>(
                builder: (context, service, child) {
                  final users =
                      service.users.where((user) => user.rank > 3).toList();

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final user = users[index];
                        return LeaderboardTile(
                          rank: user.rank,
                          username: user.username,
                          name: user.name,
                          points: user.points,
                          imageUrl: user.profileImage,
                          onTap: () {
                            debugPrint(
                                'Tapped on ${user.username} UID: ${user.uid}');
                            // Handle user profile navigation
                            if (user.uid != _auth.currentUser!.uid) {
                              context.push('/other-user-profile',
                                  extra: user.uid);
                            }
                          },
                        );
                      },
                      childCount: users.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

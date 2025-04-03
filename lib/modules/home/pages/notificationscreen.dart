import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offbeat_pravasi_v2/modules/home/data/dataexports.dart';
import 'package:provider/provider.dart';
import 'package:offbeat_pravasi_v2/common/common_exitbutton.dart';
import 'package:offbeat_pravasi_v2/modules/home/widgets/notificationtile.dart';

class Notificationscreen extends StatelessWidget {
  const Notificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leadingWidth: 80,
        leading: CommonExitbutton(
          onPressed: () => context.pop(),
        ),
      ),
      body: Consumer<HomeServices>(
        builder: (context, provider, child) {
          if (provider.friendRequests.isEmpty) {
            return Center(child: Text("No new notifications"));
          }

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'New',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var doc = provider.friendRequests[index];
                      return NotificationTile(
                        senderId: doc['senderId'] ?? 'Unknown',
                        username: doc['username'] ?? 'User',
                        message: doc['message'] ?? 'New notification',
                        messageId: doc.id,
                        timeAgo: 'Just now', // You can format timestamp here
                        avatarUrl: doc['avatarUrl'] ?? '',
                      );
                    },
                    childCount: provider.friendRequests.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

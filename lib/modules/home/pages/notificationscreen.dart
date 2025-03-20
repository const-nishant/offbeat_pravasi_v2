import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offbeat_pravasi_v2/common/common_exitbutton.dart';
import 'package:offbeat_pravasi_v2/modules/home/widgets/notificationtile.dart';

class Notificationscreen extends StatefulWidget {
  const Notificationscreen({super.key});

  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
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
      body: CustomScrollView(
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
                (context, index) => NotificationTile(
                  username: 'User $index',
                  message: 'Notification $index',
                  messageId: 'ID $index',
                  timeAgo: '1h',
                  avatarUrl: '',
                ),
                childCount: 5,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Earlier',
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
                (context, index) => NotificationTile(
                  username: 'User $index',
                  message: 'Notification $index',
                  messageId: 'ID $index',
                  timeAgo: '1h',
                  avatarUrl: '',
                ),
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

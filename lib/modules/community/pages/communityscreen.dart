import 'package:flutter/material.dart';

import '../community_exports.dart';

class Communityscreen extends StatefulWidget {
  const Communityscreen({super.key});

  @override
  State<Communityscreen> createState() => _CommunityscreenState();
}

class _CommunityscreenState extends State<Communityscreen> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height * 0.07;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(size),
            child: AppBar(
              backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
              bottom: TabBar(
                tabAlignment: TabAlignment.center,
                dividerColor: Colors.transparent,
                indicatorColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Colors.grey.shade800,
                labelColor: Theme.of(context).colorScheme.primary,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.symmetric(horizontal: 28),
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
                tabs: [
                  Tab(
                    text: "Feed",
                  ),
                  Tab(
                    text: 'Events',
                  ),
                ],
              ),
            ),
          ),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Feedtab(),
              Eventtab(),
            ],
          ),
        ),
      ),
    );
  }
}

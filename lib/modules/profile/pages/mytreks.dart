import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/modules/profile/widgets/upcomingtreks.dart';

class MyTreks extends StatefulWidget {
  const MyTreks({super.key});

  @override
  State<MyTreks> createState() => _MyTreksState();
}

class _MyTreksState extends State<MyTreks> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'My Treks',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              style: ButtonStyle(
                side: WidgetStateProperty.all(
                  BorderSide(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    width: 2,
                  ),
                ),
                iconColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              icon: Icon(
                LucideIcons.chevronLeft,
                size: 20,
                color: Colors.black,
              ),
              onPressed: () {
                context.pop();
              },
            ),
            centerTitle: true,
            bottom: TabBar(
              tabAlignment: TabAlignment.center,
              dividerColor: Colors.transparent,
              indicatorColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey.shade500,
              labelColor: Theme.of(context).colorScheme.primary,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.symmetric(horizontal: 28),
              labelStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: "Upcoming Hikes"),
                Tab(text: "Past Hikes"),
              ],
            ),
          ),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: UpcomingTreks(),
              ),
              Center(
                  child: Text('Past Treks',
                      style: TextStyle(color: Colors.black))),
            ],
          ),
        ),
      ),
    );
  }
}

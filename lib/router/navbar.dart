import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../modules/module_exports.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  List<Widget> screens = [
    const HomePage(),
    const Communityscreen(), //community screen
    const Placeholder(), //leaderboard screen
    const Placeholder(), //profile screen
  ];
  int widgetIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[widgetIndex],
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(10),
        child: GNav(
          rippleColor: Theme.of(context).colorScheme.primary,
          hoverColor: Theme.of(context).colorScheme.primary,
          tabActiveBorder: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 1.0),
          tabBorder: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 1.0),
          gap: 8,
          activeColor: Theme.of(context).colorScheme.inversePrimary,
          color: Theme.of(context).colorScheme.primary,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: Theme.of(context).colorScheme.secondary,
          selectedIndex: widgetIndex,
          onTabChange: (index) {
            setState(() {
              widgetIndex = index;
            });
          },
          tabs: [
            GButton(
              icon: LucideIcons.globe,
              text: 'Explore',
              iconColor: Theme.of(context).colorScheme.primary,
              iconActiveColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            GButton(
              text: "Community",
              icon: LucideIcons.component,
              iconColor: Theme.of(context).colorScheme.primary,
              iconActiveColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            GButton(
              icon: LucideIcons.trophy,
              text: 'Leaderboard',
              iconColor: Theme.of(context).colorScheme.primary,
              iconActiveColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            GButton(
              text: "Profile",
              icon: LucideIcons.user,
              iconColor: Theme.of(context).colorScheme.primary,
              iconActiveColor: Theme.of(context).colorScheme.inversePrimary,
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: ptrek
//  states
//     trek
//        -trekid
//        -trekname 
//        -treklocation
//        -trekdate
//        -trekuploadtimestamp
//        -trekoverview
//        -trekimages(list of images)
//        -trekrating(starts and reviews)
//        -trekreviews
//        -trekaltitude(in ft)
//        -trekdifficulty
//        -trekduration
//        -trekdistance
//        -trekcost
//        -trekiterinary
//            -recommended gear list
//            -Recommended essentials
//        -trekorganizer
//        -trekorganizercontact


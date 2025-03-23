import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../profile_exports.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Background Banner
            Container(
              height: 460,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onInverseSurface,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
            ),

            // Points Earned Positioned Top-Right
            Positioned(
              top: 50,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    "Points Earned",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "106", // Replace with dynamic data if needed
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Main White Curved Container
            Container(
              margin: EdgeInsets.only(top: 180),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 40), // Space for profile avatar overlap

                  // Profile Name & Location
                  Text(
                    "Ansh Jadhav",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Mumbai, Maharashtra",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Stats Row (Km, Friends, Events, Treks)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStat("180+ Km"),
                      _buildDivider(),
                      _buildStat("192 Friends"),
                      _buildDivider(),
                      _buildStat("3 Events"),
                      _buildDivider(),
                      _buildStat("3 Treks"),
                    ],
                  ),

                  SizedBox(height: 15),

                  // Buttons (Add Story & Edit Profile)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Add Story Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            //temp
                            context.push("/addtreks");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(50), // More rounded
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, size: 18, color: Colors.white),
                              SizedBox(width: 1.5),
                              Text("Add Story",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12),

                      // Edit Profile Button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            context.push('/editprofilescreen');
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 17),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                size: 16,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              SizedBox(width: 1),
                              Text("Edit Profile",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 0),
                      OutlinedButton(
                        onPressed: () {
                          if (!mounted) return;
                          SettingsDrawer.show(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: CircleBorder(),
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2),
                          padding: EdgeInsets.all(12),
                          backgroundColor: Colors.white,
                        ),
                        child: Icon(Icons.more_horiz, color: Colors.black),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Overview Section (Achievements & Points)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Overview",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOutlineButton("Achievements", () {
                        context.push('/achivementscreen');
                      }),
                      SizedBox(width: 10),
                      _buildOutlineButton("Points", () {
                        context.push('/pointscreen');
                      }),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Your Posts Section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Your posts",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Post Input Row
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddPostStorySwitcher(),
                        ),
                      );
                      // context.push('/addposts');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.circleUserRound,
                            size: 54,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "What’s on your mind?",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                          Icon(LucideIcons.imageUp,
                              size: 24, color: Colors.black),
                        ],
                      ),
                    ),
                  ),

                  Divider(
                    color: Theme.of(context).colorScheme.tertiary,
                    thickness: 2.5,
                  ),

                  SizedBox(height: 10),
                ],
              ),
            ),

            // Profile Avatar (Overlapping)
            Positioned(
              top: 120,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: Icon(
                  LucideIcons.circleUserRound,
                  size: 100,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for each stat
  Widget _buildStat(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  // Small dot separator between stats
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text("•",
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.secondary,
          )),
    );
  }

  // Widget for Achievements & Points Buttons
  Widget _buildOutlineButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

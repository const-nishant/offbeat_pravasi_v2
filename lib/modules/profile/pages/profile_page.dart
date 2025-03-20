import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // Curved Container
                Container(
                  margin: EdgeInsets.only(top: 100),
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
                      SizedBox(height: 20), // Space for profile avatar

                      // Profile Name & Location
                      Text(
                        "Ansh Jadhav",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                              onPressed: () {},
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
                                  Icon(Icons.add,
                                      size: 18, color: Colors.white),
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
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.orange),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(50), // More rounded
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 17),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.edit,
                                      size: 16, color: Colors.orange),
                                  SizedBox(width: 1),
                                  Text("Edit Profile",
                                      style: TextStyle(color: Colors.orange)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 0),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                              side: BorderSide(color: Colors.orange, width: 2),
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildOutlineButton("Achievements"),
                          _buildOutlineButton("Points"),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Your Posts Section
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Your Posts",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),

                      // Post Input Field
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person, size: 30, color: Colors.grey),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "What's on your mind?",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Icon(Icons.image, color: Colors.orange),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),

                // Profile Avatar (Placed Above Curved Container)
                Positioned(
                  top: 50,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      LucideIcons.circleUserRound,
                      size: 80,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
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
      child: Text("•", style: TextStyle(fontSize: 18, color: Colors.orange)),
    );
  }

  // Widget for Achievements & Points Buttons
  Widget _buildOutlineButton(String text) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.orange),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.orange),
      ),
    );
  }
}

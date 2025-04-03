import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exitbutton.dart';
import 'package:provider/provider.dart';

import '../../module_exports.dart';

class OtherUserProfile extends StatefulWidget {
  final String userId;
  const OtherUserProfile({super.key, required this.userId});

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  late Future<void> _fetchData;

  @override
  void initState() {
    super.initState();
    _fetchData = _initializeProvider(); // Fetch data only once
  }

  Future<void> _initializeProvider() async {
    final profileService = Provider.of<ProfileService>(context, listen: false);

    try {
      await Future.wait([
        profileService.fetchotherUserData(widget.userId),
        profileService.fetchOtherUserPosts(widget.userId),
        profileService.fetchUserData(),
      ]);
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: _fetchData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child:
                        CircularProgressIndicator()); // Show loader while fetching
              } else if (snapshot.hasError) {
                return Center(child: Text("Error loading profile"));
              }

              final userProvider =
                  Provider.of<ProfileService>(context, listen: false);
              final user = userProvider.otherUserData;
              final post = userProvider.otherUserPosts;
              final currentUser = userProvider.userData;

              if (user == null) {
                return Center(child: Text("User data not found"));
              }

              return SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Background Banner
                    Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        image: user.bannerImage != null
                            ? DecorationImage(
                                image: NetworkImage(user.bannerImage!),
                                fit: BoxFit.cover,
                                opacity: 2.0,
                              )
                            : null,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                      ),
                    ),

                    //exit button
                    Positioned(
                      top: 4,
                      left: 0,
                      child: CommonExitbutton(
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ),

                    // Points Earned Positioned Top-Right
                    // Positioned(
                    //   top: 0,
                    //   right: 20,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       Text(
                    //         "Points Earned",
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //           fontWeight: FontWeight.w700,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       SizedBox(height: 4),
                    //       Text(
                    //         "${user.userPoints ?? 0}",
                    //         style: TextStyle(
                    //           fontSize: 15,
                    //           color: Theme.of(context).colorScheme.secondary,
                    //           fontWeight: FontWeight.w700,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // Main White Curved Container
                    Card(
                      margin: EdgeInsets.only(top: 180),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        child: Column(
                          children: [
                            SizedBox(
                                height: 40), // Space for profile avatar overlap

                            // Profile Name & Location
                            Text(
                              user.name ?? "User Name not found",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              user.location?.isNotEmpty == true
                                  ? user.location!
                                  : "Unknown Location",
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
                                _buildStat("${user.userDistanceTraveled}+ Km"),
                                _buildDivider(),
                                _buildStat(
                                    "${user.friendsIds!.length} Friends"),
                                _buildDivider(),
                                _buildStat(
                                    "${user.userEventsIds!.length} Events"),
                                _buildDivider(),
                                _buildStat("${user.userTrekIds!.length} Treks"),
                              ],
                            ),

                            SizedBox(height: 15),

                            // Follow Button
                            OutlinedButton(
                              onPressed: currentUser!.friendsIds!
                                      .contains(user.uid)
                                  ? null // Disable the button if already a friend
                                  : () async {
                                      final profileService =
                                          Provider.of<ProfileService>(context,
                                              listen: false);
                                      await profileService.sendFriendRequest(
                                          user.uid); // Send friend request
                                      setState(
                                          () {}); // Refresh the UI after adding a friend
                                    },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 100,
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                currentUser.friendsIds!.contains(user.uid)
                                    ? "Already a Friend" // Show this text if already a friend
                                    : "Add as a Friend", // Show this text otherwise
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Divider(
                              color: Theme.of(context).colorScheme.tertiary,
                              thickness: 2.5,
                            ),

                            // SizedBox(height: 10),
                            // Post list
                            post.isEmpty
                                ? Center(
                                    child: Text("No posts yet"),
                                  )
                                : SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      itemCount: post.length,
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Postcard(
                                            postId: post[index].postId,
                                            description: post[index].caption,
                                            imageUrl: post[index].imageUrl,
                                            time: post[index].uploadTimestamp,
                                            location:
                                                post[index].location.isEmpty
                                                    ? 'location not found'
                                                    : post[index].location,
                                            username: post[index].username,
                                            userImageUrl:
                                                post[index].userImageUrl,
                                            likes: post[index].likes,
                                            comments: post[index].comments,
                                            uid: post[index].userId,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),

                    // Profile Avatar (Overlapping)
                    Positioned(
                      top: 120,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: user.profileImage != null
                            ? NetworkImage(user.profileImage!)
                            : null,
                        child: user.profileImage == null
                            ? Icon(
                                LucideIcons.circleUserRound,
                                size: 100,
                                color: Colors.black,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _buildStat(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        "•",
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}

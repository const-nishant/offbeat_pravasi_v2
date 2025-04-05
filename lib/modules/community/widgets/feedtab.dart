import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/modules/community/community_exports.dart';
import 'package:provider/provider.dart';

class Feedtab extends StatefulWidget {
  const Feedtab({super.key});

  @override
  State<Feedtab> createState() => _FeedtabState();
}

class _FeedtabState extends State<Feedtab> {
  @override
  void initState() {
    super.initState();
    final storyProvider = Provider.of<Storyservices>(context, listen: false);
    final communityProvider =
        Provider.of<Communityservices>(context, listen: false);

    storyProvider.fetchUserData();
    storyProvider.fetchUserIds().then((_) {
      storyProvider.fetchStoriesForUserIds();
    });

    communityProvider.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 140,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onInverseSurface,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Consumer<Storyservices>(
                builder: (context, storyProvider, _) {
                  if (storyProvider.isLoading || storyProvider.users == null) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final userStories = storyProvider.stories;
                  final currentUser = storyProvider.users;

                  // Filter out current user's story (if needed)
                  final otherStories = userStories
                      .where((story) => story.uid != currentUser!.uid)
                      .toList();

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1 + otherStories.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return StoryCircle(
                          name: currentUser!.username ?? 'User',
                          isYourStory: true,
                          imageUrl: currentUser.profileImage ?? '',
                          storyId: currentUser.uid,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ViewStory(
                                  imageUrls: storyProvider.stories
                                      .map((s) => s.imageUrl)
                                      .toList(),
                                  username:
                                      storyProvider.users?.username ?? 'User',
                                ),
                              ),
                            );
                          },
                        );
                      }

                      final story = otherStories[index - 1];
                      return StoryCircle(
                        name: story.username,
                        isYourStory: false,
                        imageUrl: story.imageUrl,
                        storyId: story.uid,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ViewStory(
                                imageUrls: storyProvider.stories
                                    .map((s) => s.imageUrl)
                                    .toList(),
                                username:
                                    storyProvider.users?.username ?? 'User',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          Consumer<Communityservices>(
            builder: (context, communityProvider, child) {
              if (communityProvider.isLoading) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final posts = communityProvider.posts;

              if (posts.isEmpty) {
                return SliverFillRemaining(
                  child: Center(child: Text("No posts available")),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = posts[index];
                    return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 24.0,
                          top: 6.0,
                        ),
                        child: Postcard(
                          postId: post.postId,
                          description: post.caption,
                          imageUrl: post.imageUrl,
                          time: post.uploadTimestamp,
                          location: post.location.isEmpty
                              ? 'location not found'
                              : post.location,
                          username: post.username,
                          userImageUrl: post.userImageUrl,
                          comments: post.comments,
                          uid: post.userId,
                          likes: post.likes,
                        ));
                  },
                  childCount: posts.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

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
    Provider.of<Communityservices>(context, listen: false).fetchPosts();
    super.initState();
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => StoryCircle(
                  name: 'User $index',
                  isYourStory: index == 0,
                ),
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

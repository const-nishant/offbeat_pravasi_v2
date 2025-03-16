import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/modules/community/community_exports.dart';

class Feedtab extends StatefulWidget {
  const Feedtab({super.key});

  @override
  State<Feedtab> createState() => _FeedtabState();
}

class _FeedtabState extends State<Feedtab> {
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 24.0,
                  top: 6.0,
                ),
                child: Postcard(
                  index: index,
                  uid: 'uid $index',
                  title: 'Post $index',
                  description:
                      'After thorough testing, minor UI improvements were made, and performance was optimized by ensuring efficient API calls and memory management. #Flutter #Dart $index',
                  imageUrl:
                      'https://www.tothepoint.co.uk/wp-content/uploads/2015/11/temp-image.jpg',
                  time: DateTime.now().toString(),
                  location: 'location $index',
                  username: 'username $index',
                  userImageUrl:
                      'https://www.tothepoint.co.uk/wp-content/uploads/2015/11/temp-image.jpg',
                  comments: index + 1,
                  likes: index + 1,
                ),
              ),
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}

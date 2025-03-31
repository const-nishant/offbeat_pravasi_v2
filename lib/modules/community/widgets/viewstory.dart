import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../../../config/configs.dart';

class ViewStoryWidget extends StatefulWidget {
  const ViewStoryWidget({super.key});

  @override
  State<ViewStoryWidget> createState() => _ViewStoryWidgetState();
}

class _ViewStoryWidgetState extends State<ViewStoryWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StoryController _storyController = StoryController();
  List<StoryItem> _storyItems = [];

  @override
  void initState() {
    super.initState();
    _loadDummyStories();
  }

  void _loadDummyStories() {
    setState(() {
      _storyItems = [
        StoryItem.pageImage(
          imageFit: BoxFit.contain,
          loadingWidget: Center(
            child: CircularProgressIndicator(),
          ),
          url:
              "https://cloud.appwrite.io/v1/storage/buckets/${Configs.appWriteUserProfileStorageBucketId}/files/${_auth.currentUser!.uid}/view?project=${Configs.appWriteProjectId}&mode=admin",
          controller: _storyController,
          duration: Duration(seconds: 8),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _storyItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : StoryView(
              indicatorColor: Theme.of(context).colorScheme.onInverseSurface,
              indicatorForegroundColor: Theme.of(context).colorScheme.secondary,
              storyItems: _storyItems,
              controller: _storyController,
              repeat: false,
              onComplete: () {
                Navigator.pop(context);
              },
            ),
    );
  }
}

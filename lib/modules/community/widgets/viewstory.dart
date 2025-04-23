import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class ViewStory extends StatefulWidget {
  final List<String> imageUrls;
  final String username;

  const ViewStory({
    super.key,
    required this.imageUrls,
    required this.username,
  });

  @override
  State<ViewStory> createState() => _ViewStoryState();
}

class _ViewStoryState extends State<ViewStory> {
  final StoryController _storyController = StoryController();
  List<StoryItem> _storyItems = [];

  @override
  void initState() {
    super.initState();

    if (widget.imageUrls.isEmpty) {
      // Show snackbar and immediately pop this screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No stories found')),
        );
        Navigator.pop(context); // Exit without showing anything
      });
    } else {
      _storyItems = widget.imageUrls
          .map(
            (url) => StoryItem.pageImage(
              url: url,
              controller: _storyController,
              duration: const Duration(seconds: 6),
              imageFit: BoxFit.contain,
              caption: Text(widget.username),
              shown: false,
            ),
          )
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // If no stories, don't render anything (screen will pop immediately)
    if (widget.imageUrls.isEmpty) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: Colors.black,
      body: StoryView(
        storyItems: _storyItems,
        controller: _storyController,
        repeat: false,
        onComplete: () => Navigator.pop(context),
        onVerticalSwipeComplete: (_) => Navigator.pop(context),
        indicatorColor: Theme.of(context).colorScheme.onInverseSurface,
        indicatorForegroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

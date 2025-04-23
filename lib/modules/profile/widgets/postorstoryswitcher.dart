import 'package:flutter/material.dart';

import '../../module_exports.dart';

class AddPostStorySwitcher extends StatefulWidget {
  final bool startWithStory; // If true, load AddStory first

  const AddPostStorySwitcher({super.key, this.startWithStory = false});

  @override
  State<AddPostStorySwitcher> createState() => _AddPostStorySwitcherState();
}

class _AddPostStorySwitcherState extends State<AddPostStorySwitcher> {
  bool isStoryMode = false;

  @override
  void initState() {
    super.initState();
    isStoryMode = widget.startWithStory;
  }

  void _toggleMode(bool storySelected) {
    setState(() {
      isStoryMode = storySelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Show AddPost or AddStory based on toggle
          Positioned.fill(
            child: isStoryMode ? const AddStory() : const AddPost(),
          ),

          // Top Switcher Widget
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // POST Button
                    GestureDetector(
                      onTap: () => _toggleMode(false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isStoryMode
                              ? Colors.transparent
                              : Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'POST',
                          style: TextStyle(
                            color: isStoryMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    // STORY Button
                    GestureDetector(
                      onTap: () => _toggleMode(true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isStoryMode
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'STORY',
                          style: TextStyle(
                            color: isStoryMode ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

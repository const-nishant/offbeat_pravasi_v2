import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../profile/profile_exports.dart';

class StoryCircle extends StatelessWidget {
  final String name;
  final bool isYourStory;
  final String imageUrl;
  final String storyId;
  final VoidCallback onTap;

  const StoryCircle({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.storyId,
    required this.onTap,
    this.isYourStory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 12.0, top: 20.0),
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: onTap,
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: CircleAvatar(
                    radius: 34,
                    backgroundImage: CachedNetworkImageProvider(imageUrl),
                  ),
                ),
              ),
              if (isYourStory)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        // Add story
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPostStorySwitcher(
                              startWithStory: true,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            name.length > 10 ? '${name.substring(0, 9)}…' : name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

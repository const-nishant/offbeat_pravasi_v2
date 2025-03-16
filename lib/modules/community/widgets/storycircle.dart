import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/constants/images.dart';

class StoryCircle extends StatelessWidget {
  final String name;
  final bool isYourStory;

  const StoryCircle({
    super.key,
    required this.name,
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
              CircleAvatar(
                radius: 36,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: CircleAvatar(
                  radius: 34,
                  backgroundImage: AssetImage(Images.google_logo),
                ),
              ),
              if (isYourStory)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        // Handle add story functionality
                      },
                      icon: Icon(
                        Icons.add,
                        size: 14, // Adjust size for better fit
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      padding: EdgeInsets.zero, // Removes extra padding
                      constraints:
                          BoxConstraints(), // Ensures no extra constraints
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

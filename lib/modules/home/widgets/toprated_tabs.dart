import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TopratedTabs extends StatefulWidget {
  const TopratedTabs({super.key});

  @override
  State<TopratedTabs> createState() => _TopratedTabsState();
}

class _TopratedTabsState extends State<TopratedTabs> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, //chnage this when doing the back end
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(right: 12, top: 18),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 236, //change this to change the card width
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .onPrimary, // Placeholder background
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  // State Tag (Top-Left)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons
                                .bookmark, //also add logic to this to change the icon
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Maharashtra",
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Fort Name and Location (Bottom-Left)
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Raigad Fort",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary),
                            SizedBox(width: 4),
                            Text(
                              "Raigad, Maharashtra",
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Navigation Button (Bottom-Right)
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {}, // Add navigation logic here
                        icon: Icon(
                          LucideIcons.moveRight,
                          size: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

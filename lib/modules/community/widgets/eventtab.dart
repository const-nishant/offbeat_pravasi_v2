import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class Eventtab extends StatefulWidget {
  const Eventtab({super.key});

  @override
  State<Eventtab> createState() => _EventtabState();
}

class _EventtabState extends State<Eventtab> {
  List<Container> cards = [
    // Example card 1
    Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black54,
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.end, // 👈 Pushes content to bottom
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Raigad Fort",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),

            // Location
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.white70, size: 20),
                SizedBox(width: 6),
                Text(
                  "Raigad, Maharashtra",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Date and Time
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white70, size: 20),
                SizedBox(width: 6),
                Text(
                  "7:00 AM, Sep 14 - Sep 15, 2024",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Ratings & Altitude
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 22),
                SizedBox(width: 6),
                Text("4.8",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                SizedBox(width: 24),
                Icon(Icons.terrain, color: Colors.white, size: 22),
                SizedBox(width: 6),
                Text("449 ft",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
            SizedBox(height: 24),

            // Trek Info Block
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Distance
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("10",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text("Km", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                // Terrain
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hill",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text("Landscape", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                // Duration
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("4–5h",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text("Avg Time", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                // Difficulty
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Easy",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text("Level", style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    // Example card 2
    Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black54,
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.end, // 👈 Pushes content to bottom
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Raigad Fort",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),

            // Location
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.white70, size: 20),
                SizedBox(width: 6),
                Text(
                  "Raigad, Maharashtra",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Date and Time
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white70, size: 20),
                SizedBox(width: 6),
                Text(
                  "7:00 AM, Sep 14 - Sep 15, 2024",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Ratings & Altitude
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 22),
                SizedBox(width: 6),
                Text("4.8",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                SizedBox(width: 24),
                Icon(Icons.terrain, color: Colors.white, size: 22),
                SizedBox(width: 6),
                Text("449 ft",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
            SizedBox(height: 24),

            // Trek Info Block
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Distance
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("10",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text("Km", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                // Terrain
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hill",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text("Landscape", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                // Duration
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("4–5h",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text("Avg Time", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                // Difficulty
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Easy",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Text("Level", style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ];

  void bookmarkEvent(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Event bookmarked!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void notInterested(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Event not interested!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                spacing: 10,
                children: [
                  Text(
                    'Discover, Swipe, and Explore!',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Your Next Adventure Awaits You Swipe!',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //swipe card
          Flexible(
            child: CardSwiper(
              cardsCount: cards.length,
              cardBuilder:
                  (context, index, percentThresholdX, percentThresholdY) =>
                      cards[index],
              onSwipe: (previousIndex, currentIndex, direction) {
                if (direction == CardSwiperDirection.right) {
                  bookmarkEvent(previousIndex);
                } else if (direction == CardSwiperDirection.left) {
                  notInterested(previousIndex);
                } else if (direction == CardSwiperDirection.top) {
                  return false;
                } else if (direction == CardSwiperDirection.bottom) {
                  return false;
                }
                return true; // Return true to allow the swipe
              },
            ),
          ),
        ],
      ),
    );
  }
}

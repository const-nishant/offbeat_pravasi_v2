import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class Eventtab extends StatefulWidget {
  const Eventtab({super.key});

  @override
  State<Eventtab> createState() => _EventtabState();
}

class _EventtabState extends State<Eventtab> {
  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: const Text('1'),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.red,
      child: const Text('2'),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.purple,
      child: const Text('3'),
    )
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

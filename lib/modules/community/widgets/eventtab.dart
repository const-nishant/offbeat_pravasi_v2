import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:offbeat_pravasi_v2/modules/community/community_exports.dart';
import 'package:offbeat_pravasi_v2/modules/home/data/dataexports.dart';
import 'package:provider/provider.dart';
import '../../../helpers/helper_exports.dart';

class Eventtab extends StatefulWidget {
  const Eventtab({super.key});

  @override
  State<Eventtab> createState() => _EventtabState();
}

class _EventtabState extends State<Eventtab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      Provider.of<HomeServices>(context, listen: false).fetchFilteredTreks();
    });
  }

  void bookmarkEvent(int index) {
    final bookmarkservices =
        Provider.of<Bookmarkservices>(context, listen: false);
    final trek = Provider.of<HomeServices>(context, listen: false).treks[index];

    bookmarkservices.toggleBookmark(trek.trekId);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Event bookmarked!'),
        behavior: SnackBarBehavior.floating,
        duration: Durations.medium1,
      ),
    );
  }

  void notInterested(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Event not interested!'),
        behavior: SnackBarBehavior.floating,
        duration: Durations.medium1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trekProvider = Provider.of<HomeServices>(context);
    final helperservice = Provider.of<Helperservices>(context);
    final trekCards = trekProvider.treks.map((trek) {
      return TrekCard(
        trekId: trek.trekId,
        title: trek.trekName,
        location: trek.trekLocation,
        dateTime: helperservice.formatDate(trek.trekDate),
        imageUrl: trek.trekImages.isNotEmpty ? trek.trekImages[0] : '',
        rating: trek.trekRating,
        altitude: trek.trekAltitude.toString(),
        distance: trek.trekDistance.toString(),
        state: trek.trekStateLocation,
        duration: trek.trekDuration.toString(),
        difficulty: trek.trekDifficulty,
      );
    }).toList();

    return Scaffold(
      body: trekProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
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
                // Swipeable cards
                Flexible(
                  child: CardSwiper(
                    cardsCount: trekCards.length,
                    cardBuilder: (context, index, _, __) => trekCards[index],
                    onSwipe: (previousIndex, currentIndex, direction) {
                      if (direction == CardSwiperDirection.right) {
                        bookmarkEvent(previousIndex);
                      } else if (direction == CardSwiperDirection.left) {
                        notInterested(previousIndex);
                      }
                      return true;
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

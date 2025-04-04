import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offbeat_pravasi_v2/common/common_exitbutton.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:provider/provider.dart';

import '../home_exports.dart';

class Reviewscreen extends StatefulWidget {
  final String trekId;
  const Reviewscreen({super.key, required this.trekId});

  @override
  State<Reviewscreen> createState() => _ReviewscreenState();
}

class _ReviewscreenState extends State<Reviewscreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      Provider.of<ReviewServices>(context, listen: false)
          .fetchReviews(widget.trekId);
    });
  }

  Map<String, dynamic> calculateRatingStats(List<ReviewModel> reviews) {
    if (reviews.isEmpty) {
      return {
        'rating': 0.0,
        'totalReviews': 0,
        'ratingDistribution': List.filled(5, 0.0),
      };
    }

    double totalRating = reviews.fold(0, (sum, review) => sum + review.rating);
    List<int> starCounts = List.filled(5, 0);

    for (var review in reviews) {
      int star = review.rating.round().clamp(1, 5);
      starCounts[star - 1]++;
    }

    int totalReviews = reviews.length;
    double averageRating = totalRating / totalReviews;
    List<double> distribution =
        starCounts.map((count) => count / totalReviews).toList();

    return {
      'rating': double.parse(averageRating.toStringAsFixed(1)),
      'totalReviews': totalReviews,
      'ratingDistribution': distribution,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewServices>(builder: (context, reviewProvider, child) {
      if (reviewProvider.isLoading) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final reviews = reviewProvider.reviews;
      final stats = calculateRatingStats(reviews);

      // ignore: use_build_context_synchronously
      Provider.of<ReviewServices>(context, listen: false)
          .addreviewandratingtotrek(
              widget.trekId, stats['rating'], stats['totalReviews'].toString());

      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Reviews",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          leadingWidth: 80,
          leading: CommonExitbutton(onPressed: () => context.pop()),
          centerTitle: true,
        ),
        body: reviews.isEmpty
            ? const Center(child: Text("No reviews yet"))
            : CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(12.0),
                    sliver: SliverToBoxAdapter(
                      child: RatingCard(
                        rating: stats['rating'],
                        totalReviews: stats['totalReviews'],
                        ratingDistribution: stats['ratingDistribution'],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        "Reviews (${reviews.length})",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ReviewTile(
                          username: reviews[index].username,
                          profileImage: reviews[index].profileImage,
                          rating: reviews[index].rating,
                          review: reviews[index].review,
                        ),
                        childCount: reviews.length,
                      ),
                    ),
                  ),
                ],
              ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => Container(
                  height: MediaQuery.of(context).size.height * 0.36,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22.0),
                      topRight: Radius.circular(22.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Addreview(
                    trekId: widget.trekId,
                    userId: context.read<HomeServices>().userData!.uid,
                    username: context.read<HomeServices>().userData?.name ??
                        'Anonymous',
                    profileImage:
                        context.read<HomeServices>().userData?.profileImage ??
                            'https://example.com/default_profile_image.png',
                  ),
                ),
              );
            },
            child: Text(
              "Add Review",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
      );
    });
  }
}

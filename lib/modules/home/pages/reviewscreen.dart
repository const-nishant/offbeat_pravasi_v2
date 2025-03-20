import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offbeat_pravasi_v2/common/common_exitbutton.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';

import '../home_exports.dart';

class Reviewscreen extends StatefulWidget {
  const Reviewscreen({super.key});

  @override
  State<Reviewscreen> createState() => _ReviewscreenState();
}

class _ReviewscreenState extends State<Reviewscreen> {
  @override
  Widget build(BuildContext context) {
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
        leading: CommonExitbutton(
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(12.0),
            sliver: SliverToBoxAdapter(
              child: RatingCard(
                rating: 4.4,
                totalReviews: 532,
                ratingDistribution: [
                  0.1, // 1 star
                  0.05, // 2 stars
                  0.05, // 3 stars
                  0.3, // 4 stars
                  0.5, // 5 stars
                ], // Normalized values
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Reviews (553)",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ReviewTile(
                  username: 'User $index',
                  profileImage: '',
                  rating: 2.3,
                  review: 'Good place',
                ),
                childCount: 10,
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

              isScrollControlled: true, // Allows full-screen modal
              shape: RoundedRectangleBorder(
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
                child: Addreview(),
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
  }
}

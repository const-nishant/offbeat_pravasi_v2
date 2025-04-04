import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../module_exports.dart';

class Trekdetails extends StatefulWidget {
  final String trekId;
  const Trekdetails({
    super.key,
    required this.trekId,
  });

  @override
  State<Trekdetails> createState() => _TrekdetailsState();
}

class _TrekdetailsState extends State<Trekdetails> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      Provider.of<HomeServices>(context, listen: false)
          .fetchTrekById(widget.trekId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeServices>(
          builder: (context, trekProvider, child) {
            if (trekProvider.isSingleTrekLoading) {
              return Center(child: CircularProgressIndicator());
            }

            final trek = trekProvider.singleTrek;

            if (trek == null) {
              return Center(child: Text("Trek not found"));
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ImageSliderWithIndicators(
                        imageUrls: trek.trekImages.isNotEmpty
                            ? trek.trekImages
                            : [
                                'https://via.placeholder.com/236',
                              ],
                        title: trek.trekName,
                      ),
                      Positioned(
                        top: 8,
                        left: 6,
                        right: 6,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                style: ButtonStyle(
                                  side: WidgetStateProperty.all(
                                    BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onInverseSurface,
                                      width: 2,
                                    ),
                                  ),
                                  iconColor: WidgetStateProperty.all(
                                    Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.chevron_left_rounded,
                                  size: 28,
                                ),
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                              Text(
                                trek.trekName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  //bookmark action
                                },
                                icon: Icon(
                                  LucideIcons.bookmark,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        LucideIcons.star,
                                        size: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        trek.trekRating.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${trek.trekReviews} reviews",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                              IconButton(
                                onPressed: () => context.push('/reviewscreen'),
                                style: ButtonStyle(
                                  iconColor: WidgetStateProperty.all(
                                      Theme.of(context).colorScheme.primary),
                                ),
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.chevron_right_sharp,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 14),
                        Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                LucideIcons.map,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "View Itinerary",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.push('/viewitinery', extra: {
                                    "trekname": trek.trekName,
                                    "itinerary": trek.trekItinerary,
                                    "gear": trek.recommendedGear,
                                    "essentials": trek.recommendedEssentials,
                                  });
                                },
                                style: ButtonStyle(
                                  iconColor: WidgetStateProperty.all(
                                      Theme.of(context).colorScheme.primary),
                                ),
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.chevron_right_sharp,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _infoIcon(
                        Icons.timer_outlined,
                        "${trek.trekDuration} hrs",
                      ),
                      _infoIcon(
                        Icons.directions_walk,
                        trek.trekDistance.toString(),
                      ),
                      _infoIcon(
                        Icons.terrain,
                        trek.trekAltitude.toString(),
                      ),
                      _infoIcon(Icons.error_outline, trek.trekDifficulty),
                    ],
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      'Overview',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: MarkdownBody(
                      data: trek.trekOverview,
                      selectable: false, // Allows text selection
                      styleSheet: MarkdownStyleSheet(
                        h1: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown),
                        h2: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                        p: TextStyle(fontSize: 18, color: Colors.black87),
                        strong: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        em: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.blue),
                        listBullet:
                            TextStyle(fontSize: 18, color: Colors.green),
                      ),
                    ),
                  ),
                  //payment widget
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          // Main Content Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                trek.trekName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Price
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Starting from ',
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                    TextSpan(
                                      text: '₹ ${trek.trekCost.toString()}',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 12),

                              // Feature
                              SizedBox(width: 16),
                              Text(
                                '🔥 Limited Slots!',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 16),

                              // Book Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to Payment or Booking Flow
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) => PaymentMethodModal(
                                        trekDate: trek.trekDate.toString(),
                                        trekName: trek.trekName,
                                        trekCost: trek.trekCost,
                                        trekId: trek.trekId,
                                        userId: _auth.currentUser!.uid,
                                        trekDifficulty: trek.trekDifficulty,
                                        trekImage: trek.trekImages.isNotEmpty
                                            ? trek.trekImages[0]
                                            : 'https://via.placeholder.com/236',
                                        trekLocation: trek.trekLocation,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                  ),
                                  child: const Text(
                                    'Book a Trek Now',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Positioned Action Buttons (Top-Right)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Column(
                              children: [
                                _actionButton(
                                  icon: Icons.send,
                                  label: 'Share',
                                  onTap: () {
                                    // Handle share functionality
                                  },
                                ),
                                const SizedBox(height: 8),
                                _actionButton(
                                  icon: Icons.call,
                                  label: 'Call Now',
                                  onTap: () {
                                    // Handle call functionality
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _infoIcon(IconData icon, String text) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Icon(
            icon,
            size: 30,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.brown),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.brown),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.brown,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

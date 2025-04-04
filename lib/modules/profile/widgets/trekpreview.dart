import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/modules/module_exports.dart';

class TrekPreview extends StatefulWidget {
  final String trekName;
  final double trekCost;
  final String trekLocation;
  final DateTime trekDate;
  final String trekOverview;
  final List<File> trekImages;
  final String trekDuration;
  final double trekDistance;
  final double trekElevation;
  final String trekDifficulty;
  final String trekItinerary;
  final String recommendedGear;
  final String recommendedEssentials;
  const TrekPreview({
    super.key,
    required this.trekName,
    required this.trekLocation,
    required this.trekDate,
    required this.trekOverview,
    required this.trekImages,
    required this.trekItinerary,
    required this.recommendedGear,
    required this.recommendedEssentials,
    required this.trekDuration,
    required this.trekDistance,
    required this.trekElevation,
    required this.trekDifficulty,
    required this.trekCost,
  });

  @override
  State<TrekPreview> createState() => _TrekdetailsState();
}

class _TrekdetailsState extends State<TrekPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ImageSliderWithIndicatorswithassets(
                    imageUrls: widget.trekImages,
                    title: widget.trekName,
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
                                Theme.of(context).colorScheme.primary,
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
                            widget.trekName,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              //bookmark action
                            },
                            icon: Icon(
                              LucideIcons.bookmark,
                              color: Theme.of(context).colorScheme.primary,
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
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(4),
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "{4.8}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "[reviews]",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.tertiary,
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
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(4),
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
                                "trekname": widget.trekName,
                                "itinerary": widget.trekItinerary,
                                "gear": widget.recommendedGear,
                                "essentials": widget.recommendedEssentials
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
                  _infoIcon(Icons.timer, "${widget.trekDuration} hrs"),
                  _infoIcon(
                      Icons.directions_walk, widget.trekDistance.toString()),
                  _infoIcon(Icons.terrain, widget.trekElevation.toString()),
                  _infoIcon(Icons.error_outline, widget.trekDifficulty),
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
                  data: widget.trekOverview,
                  selectable: false, // Allows text selection
                  styleSheet: MarkdownStyleSheet(
                    h1: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary),
                    h2: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary),
                    p: TextStyle(
                        fontSize: 18,
                        height: 1.5, // Increase line height for better spacing
                        color: Theme.of(context).colorScheme.primary),
                    strong: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary),
                    em: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.primary),
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
                            widget.trekName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
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
                                  text: '₹ ${widget.trekCost.toString()}',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
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
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
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
        ),
      ),
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
}

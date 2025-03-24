import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/modules/home/widgets/imagesliderwithindicator.dart';

class Trekdetails extends StatefulWidget {
  final String trekLocation;
  final String trekId;
  const Trekdetails(
      {super.key, required this.trekLocation, required this.trekId});

  @override
  State<Trekdetails> createState() => _TrekdetailsState();
}

class _TrekdetailsState extends State<Trekdetails> {
  @override
  Widget build(BuildContext context) {
//temp
    final String itineraryData = "";

    final String recommendationData = "";

    final String markdownText = "";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ImageSliderWithIndicators(
                    imageUrls: [
                      'https://cloud.appwrite.io/v1/storage/buckets/67b092f00017108f379d/files/N5Il73UVVPU2CQ2ov4O7nfim59I2/view?project=67b091bf001f46b44886&mode=admin',
                      'https://cloud.appwrite.io/v1/storage/buckets/67b092f00017108f379d/files/N5Il73UVVPU2CQ2ov4O7nfim59I2/view?project=67b091bf001f46b44886&mode=admin',
                      'https://cloud.appwrite.io/v1/storage/buckets/67b092f00017108f379d/files/N5Il73UVVPU2CQ2ov4O7nfim59I2/view?project=67b091bf001f46b44886&mode=admin',
                    ],
                    title: "Rainbow Trek",
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
                                Theme.of(context).colorScheme.inversePrimary,
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
                            "[Trek name]",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              //bookmark action
                            },
                            icon: Icon(
                              LucideIcons.bookmark,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
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
                                "trekname": '[trekName]',
                                "itinerary": itineraryData,
                                "recommendations": recommendationData,
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
                  _infoIcon(Icons.timer, "1.2 hr"),
                  _infoIcon(Icons.directions_walk, "3 km"),
                  _infoIcon(Icons.terrain, "469 ft"),
                  _infoIcon(Icons.error_outline, "Easy"),
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
                  data: markdownText,
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
                    listBullet: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ),
              ),
              //payment widget
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                margin: EdgeInsets.all(14),
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "🔥 Limited Slots!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Text(
                            "Starting from ",
                            style: TextStyle(
                              fontSize: 20, // Slightly reduced font size
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "{widget.trekprice}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16, // Slightly reduced font size
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

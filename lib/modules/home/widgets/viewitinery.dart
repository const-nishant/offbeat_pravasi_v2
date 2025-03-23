// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class ViewItinerary extends StatefulWidget {
  final String? trekName;
  final String? itineraryData;
  final String? recommendedGear;
  final String? recommendedEssentials;
  const ViewItinerary({
    super.key,
    required this.trekName,
    required this.itineraryData,
    this.recommendedGear,
    this.recommendedEssentials,
  });

  @override
  State<ViewItinerary> createState() => _ViewItineraryState();
}

class _ViewItineraryState extends State<ViewItinerary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.trekName} Trek Itinerary',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Plan your adventure step by step!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16),
                  Divider(
                    color: Theme.of(context).colorScheme.tertiary,
                    thickness: 1.6,
                  ),
                  SizedBox(height: 16),

                  // Itinerary Markdown
                  Markdown(
                    data: widget.itineraryData!,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary),
                      strong: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary),
                      em: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).colorScheme.primary),
                      listBullet: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Gear Section
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommended Gear :',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Markdown(
                          data: widget.recommendedGear!,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          styleSheet: MarkdownStyleSheet(
                            h1: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary),
                            h2: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary),
                            p: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary),
                            strong: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary),
                            em: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Theme.of(context).colorScheme.primary),
                            listBullet: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // Essentials Section (Blue Background)
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommended Essentials :',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Markdown(
                          data: widget.recommendedEssentials!,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          styleSheet: MarkdownStyleSheet(
                            h1: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary),
                            h2: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary),
                            p: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary),
                            strong: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary),
                            em: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Theme.of(context).colorScheme.primary),
                            listBullet: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

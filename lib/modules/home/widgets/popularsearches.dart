import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Popularsearches extends StatefulWidget {
  final String trekId;
  final String trekName;
  final String trekLocation;
  final String trekElevation;
  final String trekRating;
  final String trekImageUrl; // Add image URL

  const Popularsearches({
    super.key,
    required this.trekId,
    required this.trekName,
    required this.trekLocation,
    required this.trekElevation,
    required this.trekRating,
    required this.trekImageUrl, // Add image URL
  });

  @override
  State<Popularsearches> createState() => _PopularsearchesState();
}

class _PopularsearchesState extends State<Popularsearches> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 3,
      child: Container(
        width: 286,
        height: 178,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Network Image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: widget.trekImageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            // Content
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Top Row: Rating & Elevation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _infoChip(
                            LucideIcons.star,
                            widget.trekRating,
                            true,
                            context,
                          ),
                          SizedBox(width: 10),
                          _infoChip(
                            LucideIcons.mountainSnow,
                            widget.trekElevation,
                            false,
                            context,
                          ),
                        ],
                      ),
                      Icon(
                        // Add bookmark logic here and change the icon
                        LucideIcons.bookmark,
                        size: 20,
                        weight: 2,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Spacer(),
                  // Title & Location
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.trekName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                LucideIcons.mapPin,
                                size: 14,
                                color: Colors.grey[300],
                              ),
                              SizedBox(width: 4),
                              Text(
                                widget.trekLocation,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      // Action Button
                      FloatingActionButton(
                        onPressed: () {
                          // Handle action button press
                          context.push("/trekdetails", extra: {
                            'trekId': widget.trekId,
                          });
                        },
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(22),
                          ),
                        ),
                        elevation: 2,
                        mini: true,
                        child: Icon(
                          LucideIcons.moveRight,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _infoChip(
    IconData icon, String text, bool israting, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(
          icon,
          size: 16,
          color:
              israting ? Colors.amber : Theme.of(context).colorScheme.primary,
        ),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    ),
  );
}

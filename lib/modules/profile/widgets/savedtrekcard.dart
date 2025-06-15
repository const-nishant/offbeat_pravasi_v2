import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SavedtrekCard extends StatelessWidget {
  final String title;
  final String location;
  final String elevation;
  final String rating;
  final String trekId;
  final String trekImage;

  const SavedtrekCard({
    super.key,
    required this.title,
    required this.location,
    required this.elevation,
    required this.rating,
    required this.trekId,
    required this.trekImage,
  });

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
          image: DecorationImage(
            image: CachedNetworkImageProvider(trekImage),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _infoChip(LucideIcons.star, rating, true, context),
                    const SizedBox(width: 10),
                    _infoChip(
                        LucideIcons.mountainSnow, elevation, false, context),
                  ],
                ),
                Icon(
                  LucideIcons.bookmarkCheck,
                  size: 20,
                  weight: 2,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.mapPin,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    context.push("/trekdetails", extra: {
                      'trekId': trekId,
                    });
                  },
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  elevation: 2,
                  mini: true,
                  child: const Icon(
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
    );
  }

  Widget _infoChip(
      IconData icon, String text, bool isRating, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                isRating ? Colors.amber : Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 6),
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
}

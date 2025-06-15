import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class UpcomingTreksCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String dateTime;
  final String rating;
  final String altitude;
  final VoidCallback onTap;

  const UpcomingTreksCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.dateTime,
    required this.rating,
    required this.altitude,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Trek Details
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(LucideIcons.mapPin,
                        color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      location,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(LucideIcons.calendar,
                        color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      dateTime,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _infoChip(
                      LucideIcons.star,
                      rating,
                      true,
                      context,
                    ),
                    const SizedBox(width: 10),
                    _infoChip(
                      LucideIcons.mountainSnow,
                      altitude,
                      false,
                      context,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Arrow Button
          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  LucideIcons.moveRight,
                  size: 18,
                  color: Colors.black,
                ),
                onPressed: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(
      IconData icon, String text, bool isRating, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white12,
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

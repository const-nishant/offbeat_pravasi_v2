import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PastTreksCard extends StatelessWidget {
  const PastTreksCard({super.key});

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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1506744038136-46273834b3fb'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient overlay
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Completed Chip at Top Right
          Positioned(
            top: 12,
            right: 12,
            child: _buildCompletedStat("Completed on Jan 20, 2024", context),
          ),

          // Content
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  "Raigad Fort",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Location
                Row(
                  children: [
                    const Icon(LucideIcons.mapPin,
                        color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                    const Text(
                      "Raigad, Maharashtra",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Rating and Elevation chips
                Row(
                  children: [
                    _infoChip(
                      LucideIcons.star,
                      "4.8",
                      true,
                      context,
                    ),
                    const SizedBox(width: 10),
                    _infoChip(
                      LucideIcons.mountainSnow,
                      "449 ft",
                      false,
                      context,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Completed Chip with • bullet
  Widget _buildCompletedStat(String text, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "• $text",
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

// Reusable info chip (Rating & Elevation)
Widget _infoChip(
    IconData icon, String text, bool isRating, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.8),
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

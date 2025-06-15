import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrekCard extends StatelessWidget {
  final String trekId;
  final String title;
  final String location;
  final String dateTime;
  final String imageUrl;
  final double rating;
  final String altitude;
  final String distance;
  final String state;
  final String duration;
  final String difficulty;

  const TrekCard({
    super.key,
    required this.title,
    required this.location,
    required this.dateTime,
    required this.imageUrl,
    required this.rating,
    required this.altitude,
    required this.distance,
    required this.state,
    required this.duration,
    required this.difficulty,
    required this.trekId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/trekdetails", extra: {
          'trekId': trekId,
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        height: 600,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter:
                const ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on,
                      color: Colors.white70, size: 20),
                  const SizedBox(width: 6),
                  Text(location,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      color: Colors.white70, size: 20),
                  const SizedBox(width: 6),
                  Text(dateTime,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 22),
                  const SizedBox(width: 6),
                  Text(rating.toString(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(width: 24),
                  const Icon(Icons.terrain, color: Colors.white, size: 22),
                  const SizedBox(width: 6),
                  Text("$altitude ft",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoColumn(distance, "Km"),
                  _infoColumn(state, "State"),
                  _infoColumn(duration, "Avg Time"),
                  _infoColumn(difficulty, "Level"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoColumn(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}

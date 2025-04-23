import 'package:flutter/material.dart';

class RatingCard extends StatelessWidget {
  final double rating;
  final int totalReviews;
  final List<double> ratingDistribution;

  const RatingCard({
    super.key,
    required this.rating,
    required this.totalReviews,
    required this.ratingDistribution,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating.round() ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Based on $totalReviews reviews",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                5,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: [
                      Text("${5 - index}"),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 150,
                        child: LinearProgressIndicator(
                          value: ratingDistribution[index],
                          backgroundColor: Colors.grey[300],
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

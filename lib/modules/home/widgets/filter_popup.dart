import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FilterPopup extends StatefulWidget {
  const FilterPopup({super.key});

  @override
  State<FilterPopup> createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  double trekLength = 3;
  double elevationGain = 410;
  double rating = 0;
  int selectedDifficulty = 0;

  final List<String> difficultyLevels = ["Easy", "Moderate", "Hard"];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Left alignment
          children: [
            // Difficulty Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                difficultyLevels.length,
                (index) {
                  final isSelected = selectedDifficulty == index;
                  return ChoiceChip(
                    label: Text(
                      difficultyLevels[index],
                      style: TextStyle(
                        color: isSelected
                            ? Theme.of(context).colorScheme.inversePrimary
                            : Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: isSelected ? 2 : 0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    showCheckmark: false,
                    onSelected: (_) {
                      setState(() {
                        selectedDifficulty = index;
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Trek Length
            _buildLabelWithValue(
                'Trek length:', '${trekLength.toStringAsFixed(0)} km'),
            Slider(
              min: 1,
              max: 30,
              value: trekLength,
              onChanged: (value) {
                setState(() {
                  trekLength = value;
                });
              },
              activeColor: Theme.of(context).colorScheme.secondary,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('1 km'), Text('5 km'), Text('30 km')],
            ),

            const SizedBox(height: 24),

            // Elevation Gain
            _buildLabelWithValue(
                'Elevation Gain:', '${elevationGain.toStringAsFixed(0)} ft'),
            Slider(
              min: 10,
              max: 500,
              divisions: 5,
              value: elevationGain,
              onChanged: (value) {
                setState(() {
                  elevationGain = value;
                });
              },
              activeColor: Theme.of(context).colorScheme.secondary,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('10 ft'),
                Text('500 ft'),
              ],
            ),

            const SizedBox(height: 24),

            // Minimum Rating - LEFT aligned
            const Text('Minimum Rating:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            RatingBar.builder(
              initialRating: rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 32,
              unratedColor: Theme.of(context).colorScheme.tertiary,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onRatingUpdate: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Apply Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelWithValue(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(value, style: const TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Popularsearches extends StatefulWidget {
  const Popularsearches({super.key});

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
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              MainAxisAlignment.end, // Align children at the bottom
          children: [
            // Top Row: Rating & Elevation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _infoChip(
                      LucideIcons.star,
                      "4.8",
                      true,
                      context,
                    ),
                    SizedBox(width: 10),
                    _infoChip(
                        LucideIcons.mountainSnow, "449 ft", false, context),
                  ],
                ),
                Icon(
                  //add bookmark logic here and change the icon
                  LucideIcons.bookmark,
                  size: 20,
                  weight: 2,
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
                      "Raigad Fort",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.mapPin,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Raigad, Maharashtra",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                // Action Button
                FloatingActionButton(
                  onPressed: () {},
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

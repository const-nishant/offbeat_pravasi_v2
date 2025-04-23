import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../constants/images.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Close Button (Top Left)
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  style: ButtonStyle(
                    side: WidgetStateProperty.all(
                      BorderSide(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        width: 2,
                      ),
                    ),
                    iconColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  icon: Icon(
                    LucideIcons.x,
                    size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),

              const SizedBox(height: 70),

              // Image
              Image.asset(
                Images.points,
                height: 230,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 32),

              // Title
              const Text(
                "Points have power. Get ready.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 16),

              // Description Text
              const Text(
                "We're building something big for you. Stay tuned for an exciting update!",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 180),

              // Learn More Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Learn More",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

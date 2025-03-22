import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../constants/images.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Close Button
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
                Images.achivements,
                height: 250,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 32),

              // Title
              const Text(
                "Achievements are coming soon!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Description
              const Text(
                "We're introducing achievements to help you stay motivated and celebrate your progress. Stay tuned for more details.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 80),

              // Learn More Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Learn More",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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

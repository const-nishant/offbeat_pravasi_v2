import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/modules/profile/widgets/savedtrekcard.dart';

class Savedtreks extends StatefulWidget {
  const Savedtreks({super.key});

  @override
  State<Savedtreks> createState() => _SavedtreksState();
}

class _SavedtreksState extends State<Savedtreks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  IconButton(
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
                    icon: const Icon(
                      LucideIcons.chevronLeft,
                      size: 20,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  const SizedBox(width: 50),
                  const Text(
                    'Saved Treks',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ListView wrapped with Expanded
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Savedtrekcard(),
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

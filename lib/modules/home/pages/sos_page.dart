import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
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
            LucideIcons.chevronLeft,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 60),
                Text(
                  'Emergency Help Needed?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Just tap the button to call',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            ),
            SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                // TODO: Trigger call functionality
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 110,
                    backgroundColor: Colors.red.shade300, // Outer lighter red
                  ),
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.red.shade700, // Inner darker red
                    child: const Icon(LucideIcons.phone,
                        size: 50, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 200),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _contactCard(name: 'Nishant Patil', phone: '099 678 4567'),
                  const SizedBox(width: 10),
                  _contactCard(name: 'Nishant Patil', phone: '099 678 4567'),
                  const SizedBox(width: 10),
                  _addcontactCard(title: 'Add New Contact'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactCard({required String name, required String phone}) {
    return GestureDetector(
      onTap: () {
        context.push('/contactsScreen');
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(LucideIcons.circleUserRound, size: 38),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  phone,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _addcontactCard({required String title}) {
    return GestureDetector(
      onTap: () {
        context.push('/addContactScreen');
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(LucideIcons.circlePlus, size: 38),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

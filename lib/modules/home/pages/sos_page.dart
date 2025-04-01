import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../module_exports.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  @override
  Widget build(BuildContext context) {
    final sosService =
        Provider.of<SOSService>(context); // Fetch contacts dynamically
    final contacts = sosService.contacts;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
          icon: const Icon(
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centers content vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centers horizontally
            children: [
              const Text(
                'Emergency Help Needed?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Just tap the button to call',
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  // Provider.of<SOSService>(context, listen: false)
                  // .callFirstContact();
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
              const SizedBox(height: 200),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Keeps everything centered
                  children: [
                    ...contacts.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _contactCard(context, entry.key),
                      );
                    }),
                    _addcontactCard(
                        title: 'Add New Contact'), // Add button back
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    final sosService = Provider.of<SOSService>(context, listen: false);
    final contact = sosService.contacts[index];

    String name = contact["name"] ?? "Unknown";
    String phone = contact["phone"] ?? "No Number";
    String imagePath = contact["imagePath"] ?? "";

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
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.shade300,
              backgroundImage:
                  imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
              child: imagePath.isEmpty
                  ? const Icon(LucideIcons.circleUserRound, size: 38)
                  : null,
            ),
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

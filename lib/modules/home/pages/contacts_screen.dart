import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../module_exports.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sosService = Provider.of<SOSService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contacts',
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
      body: Column(
        children: [
          const SizedBox(height: 16),
          ListTile(
            leading:
                const Icon(LucideIcons.circlePlus, color: Colors.red, size: 36),
            title: const Text('Add New Contact',
                style: TextStyle(fontSize: 18, color: Colors.red)),
            onTap: () => context.push('/addContactScreen'),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: sosService.contacts.isEmpty
                ? const Center(child: Text("No contacts available"))
                : ListView.builder(
                    itemCount: sosService.contacts.length,
                    itemBuilder: (context, index) {
                      final contact = sosService.contacts[index];
                      return _contactTile(
                        name: contact['name'] ?? '',
                        phone: contact['phone'] ?? '',
                        imagePath: contact['imagePath'],
                        onDelete: () => _showDeleteConfirmationDialog(
                            context, () => sosService.removeContact(index)),
                        context: context,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _contactTile({
    required String name,
    required String phone,
    String? imagePath,
    required VoidCallback onDelete,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.transparent,
            backgroundImage: (imagePath != null && imagePath.isNotEmpty)
                ? FileImage(File(imagePath))
                : null,
            child: (imagePath == null || imagePath.isEmpty)
                ? const Icon(LucideIcons.circleUserRound, size: 36)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  children: [
                    Icon(LucideIcons.phone,
                        size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(phone,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              LucideIcons.trash,
              color: Colors.black,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Contact"),
        content: const Text("Are you sure you want to delete this contact?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              onDelete();
              Navigator.of(context).pop();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}

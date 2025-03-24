import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
          _contactTile(name: 'Nishant Patil', phone: '099 678 4567'),
        ],
      ),
    );
  }

  Widget _contactTile({required String name, required String phone}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.yellow.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.circleUserRound, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(phone, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const Icon(LucideIcons.ellipsisVertical),
        ],
      ),
    );
  }
}

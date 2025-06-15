import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        centerTitle: true,
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
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Need help or have questions?',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 18),
          Text(
            'We’re here for you! Contact us through any of the methods below or check out our FAQs.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _contactInfo(),
          const SizedBox(height: 32),
          Text('FAQs', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          _faqTile('How do I book a trek?',
              'Open any trek, see a batch/date to match your schedule, and proceed with payment.'),
          _faqTile('Can I cancel a booking?',
              'Cancellations depend on the trek host’s policy. Check the trek details for cancellation rules.'),
          _faqTile('What is the SOS feature?',
              'It allows you to send emergency alerts to your saved contacts with your live location.'),
          _faqTile('How do I earn points?',
              'Points are earned through activity like bookings, completing treks, and profile engagement But they will some be avialable in upcoming updates.'),
          const SizedBox(height: 180),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to a feedback or report issue form
            },
            icon: const Icon(
              Icons.feedback_outlined,
              color: Colors.white,
            ),
            label: const Text('Send Feedback / Report Issue'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('📧 Email: offbeatpravasi@gmail.com'),
        SizedBox(height: 8),
        Text('🌐 Website: www.offbeatpravasi.com'),
        SizedBox(height: 8),
        Text('📍 Location: Mumbai, India'),
      ],
    );
  }

  Widget _faqTile(String question, String answer) {
    return ExpansionTile(
      title: Text(question, style: const TextStyle(fontSize: 15)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(answer, style: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}

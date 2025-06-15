import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
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
            'Effective Date: 20 April 2025',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          _section('1. Acceptance of Terms',
              'By using this app, you agree to follow these Terms & Conditions, our Privacy Policy, and any other policies shown.'),
          _section('2. User Eligibility',
              'Users must be 13+ years old. If under 18, use only under parental or guardian supervision.'),
          _section('3. Account Registration',
              'Keep your account info accurate and secure. You’re responsible for all activity under your account.'),
          _section('4. Trek Booking',
              'Treks are hosted by third-party organizers or approved hosts. Details like pricing and availability may change. We are not responsible for any mishaps during treks.'),
          _section('5. Achievements & Points',
              'Earned points or achievements are for fun—they do not hold cash value unless otherwise noted.'),
          _section('6. Content & Conduct',
              'Please DO NOT:\n• Post offensive or illegal content\n• Abuse emergency features\n• Violate laws or user rights'),
          _section('7. SOS & Emergency Use',
              'SOS is for real emergencies only. You must set up your emergency contacts correctly. We are not liable if the SOS fails due to signal/device issues.'),
          _section('8. Third-party Services',
              'We use tools like Appwrite and other APIs. Use of these is subject to their respective terms.'),
          _section('9. Intellectual Property',
              'All app content and visuals are owned/licensed by OffBeat Pravasi. Don’t copy or reuse without permission.'),
          _section('10. Account Termination',
              'We can suspend or terminate accounts that break these rules—without warning.'),
          _section('11. Changes to Terms',
              'We may update these terms anytime. Using the app after updates = accepting the new terms.'),
          _section('12. Limitation of Liability',
              'We are not responsible for any damages, losses, or issues caused by your use of the app.'),
          _section('13. Governing Law',
              'These terms follow the laws of India, Maharashtra.'),
          _section('14. Need Help?',
              '📧 offbeatpravasi@gmail.com\n🌐 www.offbeatpravasi.com'),
        ],
      ),
    );
  }

  Widget _section(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

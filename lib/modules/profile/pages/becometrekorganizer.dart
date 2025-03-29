import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:offbeat_pravasi_v2/modules/profile/data/exports.dart';
import 'package:provider/provider.dart';

class BecomeTrekOrganizerScreen extends StatefulWidget {
  const BecomeTrekOrganizerScreen({super.key});

  @override
  State<BecomeTrekOrganizerScreen> createState() =>
      _BecomeTrekOrganizerScreenState();
}

class _BecomeTrekOrganizerScreenState extends State<BecomeTrekOrganizerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final profileservices =
          Provider.of<ProfileService>(context, listen: false);

      profileservices.sendOrganizerRequest(
        email: _emailController.text.trim(),
        message: _messageController.text.trim(),
        context: context,
      );
    }
    _emailController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Move IconButton here at the top inside the Scaffold
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 14.0),
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
                  icon: const Icon(
                    LucideIcons.chevronLeft,
                    size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text(
                      'Become a Trek Organizer',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please fill out the form below to apply. We will review your profile and get back to you if we think you are a good fit.',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 24),
                    const Text('Contact Email:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    CommonTextfield(
                      hintText: 'Your email',
                      controller: _emailController,
                      readOnly: false,
                      obscureText: false,
                    ),
                    const SizedBox(height: 24),
                    const Text('Message:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    // Make the message field big using minLines & maxLines
                    CommonTextfield(
                      hintText: 'Write your message here',
                      controller: _messageController,
                      readOnly: false,
                      obscureText: false,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: LargeButton(
                        onPressed: _handleSubmit,
                        text: 'Submit',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

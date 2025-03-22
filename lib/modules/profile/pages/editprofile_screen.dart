import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({super.key});

  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  final nameController = TextEditingController(text: "Ansh Jadhav");
  final usernameController = TextEditingController(text: "JadhavAnsh");
  final phoneController = TextEditingController(text: "8380948968");
  final locationController = TextEditingController(text: "Mumbai, Maharashtra");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // Back Button, Title, Add Banner
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
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      size: 28,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  SizedBox(width: 22.0),
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 40.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add banner logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.onInverseSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Add banner",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              // Profile Image with Edit Icon
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(
                      LucideIcons.circleUserRound,
                      size: 80,
                      color: Colors.black,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      radius: 16,
                      child:
                          const Icon(Icons.edit, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Using CommonTextfield
              _buildLabel("Name:"),
              CommonTextfield(
                hintText: "",
                controller: nameController,
                readOnly: true,
                obscureText: false,
              ),

              const SizedBox(height: 15),
              _buildLabel("Username:"),
              CommonTextfield(
                hintText: "",
                controller: usernameController,
                readOnly: true,
                obscureText: false,
              ),

              const SizedBox(height: 15),
              _buildLabel("Phone no:"),
              CommonTextfield(
                hintText: "",
                controller: phoneController,
                keyboardType: TextInputType.phone,
                readOnly: true,
                obscureText: false,
              ),

              const SizedBox(height: 15),
              _buildLabel("Location:"),
              CommonTextfield(
                hintText: "",
                controller: locationController,
                readOnly: true,
                obscureText: false,
              ),

              const SizedBox(height: 170),

              // Save Button
              LargeButton(onPressed: () {}, text: "Save"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
      ),
    );
  }
}

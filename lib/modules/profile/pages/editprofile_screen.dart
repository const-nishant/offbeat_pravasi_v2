import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:provider/provider.dart';
import '../../../helpers/helper_exports.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({super.key});

  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  File? image;
  File? bannerImage;

  @override
  Widget build(BuildContext context) {
    final helperServices = Provider.of<Helperservices>(context);
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
                    iconSize: 28,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                      size: 28,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  const SizedBox(width: 22.0),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      await helperServices.pickImage();
                      setState(() {
                        bannerImage = helperServices.image;
                      });
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

              const SizedBox(height: 30),

              // Banner and Floating Profile Picture
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Banner Preview
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      borderRadius: BorderRadius.circular(12),
                      image: bannerImage != null
                          ? DecorationImage(
                              image: FileImage(bannerImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: bannerImage == null
                        ? const Center(
                            child: Text(
                              'Banner Preview',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          )
                        : null,
                  ),

                  // Circular Avatar floating
                  Positioned(
                    bottom: -68, // Half of avatar radius to float
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 66,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                image != null ? FileImage(image!) : null,
                            child: image == null
                                ? Icon(
                                    LucideIcons.circleUserRound,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 96,
                                  )
                                : null,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                              onPressed: () async {
                                await helperServices.pickImage();
                                setState(() {
                                  image = helperServices.image;
                                });
                              },
                              icon: CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                  height: 80), // Space to accommodate the floating avatar

              // Text Fields
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

              const SizedBox(height: 50),

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
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

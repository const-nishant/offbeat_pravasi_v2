import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:offbeat_pravasi_v2/modules/profile/data/exports.dart';
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

  File? profileImage;
  File? bannerImage;

  Future<File?> pickProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // Optional: compress image quality
    );

    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final helperServices = Provider.of<Helperservices>(context);
    return Consumer<ProfileService>(builder: (context, profileservice, child) {
      if (profileservice.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      void updateUserData() async {
        await profileservice.updateUserData(
          context: context,
          name: nameController.text,
          username: usernameController.text,
          phone: phoneController.text,
          profileImage: profileImage,
          bannerImage: bannerImage,
          location: locationController.text,
        );
        nameController.clear();
        usernameController.clear();
        phoneController.clear();
        locationController.clear();
        profileImage = null;
        bannerImage = null;
      }

      final userData = profileservice.userData!;
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
                            : (userData.bannerImage != null
                                ? DecorationImage(
                                    image: NetworkImage(userData.bannerImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null),
                      ),
                      child: bannerImage == null && userData.bannerImage == null
                          ? const Center(
                              child: Text(
                                'Banner Preview',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            )
                          : null,
                    ),

                    // Circular Avatar floating
                    Transform.translate(
                      offset: const Offset(0, 52),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 66,
                              backgroundColor: Colors.transparent,
                              backgroundImage: profileImage != null
                                  ? FileImage(profileImage!)
                                  : (userData.profileImage != null
                                      ? NetworkImage(userData.profileImage!)
                                      : null),
                              child: profileImage == null &&
                                      userData.profileImage == null
                                  ? Icon(
                                      LucideIcons.circleUserRound,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 96,
                                    )
                                  : null,
                            ),
                            Positioned(
                              right: 6,
                              bottom: 6,
                              child: GestureDetector(
                                onTap: () async {
                                  final pickedImage =
                                      await pickProfileImage(); // Call the new function
                                  if (pickedImage != null) {
                                    setState(() {
                                      profileImage = pickedImage;
                                    });
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  child: const Icon(
                                    LucideIcons.pen,
                                    size: 20,
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
                  hintText: userData.name ?? "",
                  controller: nameController,
                  readOnly: false,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                _buildLabel("Username:"),
                CommonTextfield(
                  hintText: userData.username ?? "",
                  controller: usernameController,
                  readOnly: false,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username cannot be empty";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                _buildLabel("Phone no:"),
                CommonTextfield(
                  hintText: userData.phone ?? "",
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  readOnly: false,
                  maxLength: 10,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone number cannot be empty";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),
                _buildLabel("Location:"),
                CommonTextfield(
                  hintText: userData.location ?? "",
                  controller: locationController,
                  readOnly: true,
                  obscureText: false,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.location_on_rounded,
                      size: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      // Implement location selection logic
                      helperServices.getUserLocation().then((location) {
                        locationController.text = location;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 50),

                // Save Button
                LargeButton(
                  onPressed: updateUserData,
                  text: "Save",
                ),
              ],
            ),
          ),
        ),
      );
    });
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

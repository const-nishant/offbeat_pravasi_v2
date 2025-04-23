import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helper_exports.dart';
import '../../module_exports.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Helperservices>(context, listen: false).resetImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final helperServices = Provider.of<Helperservices>(context);
    final sosService = Provider.of<SOSService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Contacts',
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 68,
                    backgroundColor: Colors.transparent,
                    backgroundImage: helperServices.image != null
                        ? FileImage(helperServices.image!)
                        : null,
                    child: helperServices.image == null
                        ? Icon(
                            LucideIcons.circleUserRound,
                            color: Theme.of(context).colorScheme.primary,
                            size: 100,
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
                          // After picking the image, print the image path for debugging
                          if (helperServices.image != null) {
                            debugPrint(
                                "Picked image path: ${helperServices.image!.path}");
                          } else {
                            debugPrint("No image selected.");
                          }
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
            const SizedBox(height: 24),
            CommonTextfield(
              hintText: 'Name',
              controller: nameController,
              prefixIcon: const Icon(LucideIcons.penLine),
              readOnly: false,
              obscureText: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CommonTextfield(
              hintText: 'Mobile Number',
              controller: phoneController,
              prefixIcon: const Icon(LucideIcons.phone),
              readOnly: false,
              keyboardType: TextInputType.numberWithOptions(),
              obscureText: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your mobile number";
                }
                return null;
              },
            ),
            const Spacer(),
            LargeButton(
              text: 'Save',
              onPressed: () {
                if (nameController.text.isEmpty ||
                    phoneController.text.isEmpty) {
                  _showErrorDialog(context, "Please fill in all fields.");
                  return;
                }

                sosService.addContact(
                  name: nameController.text,
                  phone: phoneController.text,
                  image: helperServices
                      .image, // Pass the image directly from helperServices
                );
                helperServices.resetImage(); // Reset the stored image
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}

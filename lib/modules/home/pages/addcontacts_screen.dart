import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helper_exports.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    File? image;
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final helperServices = Provider.of<Helperservices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                          : null),
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
                            )),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 24),
            CommonTextfield(
              hintText: 'Name',
              controller: nameController,
              prefixIcon: Icon(LucideIcons.penLine),
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
              prefixIcon: Icon(LucideIcons.phone),
              readOnly: false,
              obscureText: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your mobile number";
                }
                return null;
              },
            ),
            const Spacer(),
            LargeButton(onPressed: () {}, text: 'Save'),
          ],
        ),
      ),
    );
  }
}

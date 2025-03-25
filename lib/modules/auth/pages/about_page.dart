import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:offbeat_pravasi_v2/modules/auth/auth_exports.dart';
import 'package:provider/provider.dart';
import '../../../helpers/helper_exports.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final aboutFormKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController dobTextEditingController = TextEditingController();
  TextEditingController mobileNumberTextEditingController =
      TextEditingController();
  DateTime? date;
  File? image;
  String? gender;

  void saveProfile() async {
    if (aboutFormKey.currentState!.validate() &&
        image == null &&
        gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a profile picture")),
      );
    } else if (aboutFormKey.currentState!.validate() &&
        image != null &&
        gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select your gender")),
      );
    } else {
      await Provider.of<OnboardingServices>(context, listen: false)
          .pushUserInfo(
              phone: mobileNumberTextEditingController.text.trim(),
              dob: dobTextEditingController.text.trim(),
              name: nameTextEditingController.text.trim(),
              gender: gender!,
              image: image,
              context: context);
      // ignore: use_build_context_synchronously
      // setState(() {
      //   Phoenix.rebirth(context);
      // });
    }
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    dobTextEditingController.dispose();
    mobileNumberTextEditingController.dispose();
    image = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final helperServices = Provider.of<Helperservices>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.only(top: 48),
          child: Form(
            key: aboutFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Text(
                  "About Yourself",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text("Fill in the details to create your profile",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w400,
                    )),
                SizedBox(height: 20),
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
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  "Enter your name",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CommonTextfield(
                  hintText: "Name",
                  controller: nameTextEditingController,
                  readOnly: false,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.edit_note_rounded),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                ),
                Text(
                  "Select your gender",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonRadio(
                      value: 'Male',
                      groupValue: gender ?? '',
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                    Text(
                      "Male",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    CommonRadio(
                      value: 'Female',
                      groupValue: gender ?? '',
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                    Text(
                      "Female",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    CommonRadio(
                      value: 'Other',
                      groupValue: gender ?? '',
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                    Text(
                      "Other",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Enter your Birthdate",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CommonTextfield(
                  hintText: "DD/MM/YYYY",
                  controller: dobTextEditingController,
                  readOnly: true,
                  obscureText: false,
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    await helperServices.datePicker(context);
                    setState(() {
                      if (helperServices.date != null) {
                        dobTextEditingController.text =
                            helperServices.formatDate(helperServices.date!);
                      }
                    });
                  },
                  suffixIcon: IconButton(
                      onPressed: () async {
                        await helperServices.datePicker(context);
                        setState(() {
                          if (helperServices.date != null) {
                            dobTextEditingController.text =
                                helperServices.formatDate(helperServices.date!);
                          }
                        });
                      },
                      icon: Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Birthdate cannot be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                Text(
                  "Enter your mobile number",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CommonTextfield(
                  hintText: "Mobile Number",
                  controller: mobileNumberTextEditingController,
                  readOnly: false,
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mobile number cannot be empty";
                    }
                    return null;
                  },
                  maxLength: 10,
                ),
                SizedBox(height: 8),
                LargeButton(onPressed: saveProfile, text: "Save"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

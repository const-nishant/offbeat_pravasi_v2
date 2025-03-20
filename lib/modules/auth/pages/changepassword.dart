import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:provider/provider.dart';

import '../auth_exports.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  bool obscureTextConfirm = true;
  bool obscureTextCurrent = true;
  bool obscureTextNew = true;
  final changePasswordFormKey = GlobalKey<FormState>();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TextEditingController newPasswordTextEditingController =
      TextEditingController();
  TextEditingController currentPasswordTextEditingController =
      TextEditingController();

  void changePassword() async {
    if (changePasswordFormKey.currentState!.validate()) {
      await Provider.of<AuthServices>(context, listen: false).changePassword(
          currentPasswordTextEditingController.text.trim(),
          newPasswordTextEditingController.text.trim(),
          context);
      currentPasswordTextEditingController.clear();
      newPasswordTextEditingController.clear();
      confirmPasswordTextEditingController.clear();
    }
  }

  @override
  void dispose() {
    currentPasswordTextEditingController.dispose();
    newPasswordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Change Password",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        leadingWidth: 80,
        leading: CommonExitbutton(
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: changePasswordFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Text(
                "Enter your current password",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              CommonTextfield(
                hintText: "Current Password",
                controller: currentPasswordTextEditingController,
                readOnly: false,
                obscureText: obscureTextCurrent,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icon(LucideIcons.lockKeyholeOpen),
                suffixIcon: IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    setState(() {
                      obscureTextCurrent = !obscureTextCurrent;
                    });
                  },
                  icon: obscureTextCurrent
                      ? Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Icon(
                          Icons.visibility,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your current password";
                  }
                  return null;
                },
              ),
              Text(
                "Enter your new password",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              CommonTextfield(
                hintText: "New Password",
                controller: newPasswordTextEditingController,
                readOnly: false,
                obscureText: obscureTextNew,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icon(LucideIcons.lockKeyhole),
                suffixIcon: IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    setState(() {
                      obscureTextNew = !obscureTextNew;
                    });
                  },
                  icon: obscureTextNew
                      ? Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Icon(
                          Icons.visibility,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),
              Text(
                "Confirm your new password",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              CommonTextfield(
                hintText: "Confirm Password",
                controller: confirmPasswordTextEditingController,
                readOnly: false,
                obscureText: obscureTextConfirm,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icon(LucideIcons.lockKeyhole),
                suffixIcon: IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    setState(() {
                      obscureTextConfirm = !obscureTextConfirm;
                    });
                  },
                  icon: obscureTextConfirm
                      ? Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Icon(
                          Icons.visibility,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your password";
                  } else if (value != newPasswordTextEditingController.text) {
                    return "Password does not match";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              LargeButton(
                onPressed: changePassword,
                text: "Change Password",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

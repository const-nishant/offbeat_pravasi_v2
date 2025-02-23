import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/common_exports.dart';
import '../auth_exports.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController forgetpasswordTextEditingController =
      TextEditingController();

  void sendLink() async {
    await Provider.of<AuthServices>(context, listen: false).resetPassword(
        forgetpasswordTextEditingController.text.trim(), context);
    forgetpasswordTextEditingController.clear();
    // Future.delayed(const Duration(milliseconds: 1500), () {
    //   context.go('/');
    // });
  }

  @override
  void dispose() {
    forgetpasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Reset Password",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leadingWidth: 80,
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          iconSize: 24,
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              "Please enter your E-mail to  receive The reset password link",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Enter Your Details",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            CommonTextfield(
              controller: forgetpasswordTextEditingController,
              hintText: "Enter Your E-mail",
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              readOnly: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your E-mail';
                }
                return null;
              },
            ),
            LargeButton(onPressed: sendLink, text: "Send Link"),
          ],
        ),
      ),
    );
  }
}

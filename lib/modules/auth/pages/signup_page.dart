import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:provider/provider.dart';

import '../auth_exports.dart';

class SignupPage extends StatefulWidget {
  final void Function()? onTap;
  const SignupPage({super.key, this.onTap});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool obscureText = true;
  bool obscureTextConfirm = true;

  final GlobalKey<FormState> signupformkey = GlobalKey<FormState>();
  final TextEditingController usernameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  Future signup() async {
    if (signupformkey.currentState!.validate()) {
      Provider.of<AuthServices>(context, listen: false).signup(
        usernameTextEditingController.text.trim(),
        emailTextEditingController.text.trim(),
        passwordTextEditingController.text.trim(),
        context,
      );
    }
  }

  @override
  void dispose() {
    usernameTextEditingController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: signupformkey,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.16,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    "Create a new Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  CommonTextfield(
                      hintText: "Create your username",
                      controller: usernameTextEditingController,
                      keyboardType: TextInputType.text,
                      readOnly: false,
                      obscureText: false,
                      prefixIcon: const Icon(Icons.edit_note_rounded),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      }),
                  CommonTextfield(
                    hintText: "Enter your E-mail",
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: false,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  CommonTextfield(
                    hintText: "Enter Your Password",
                    controller: passwordTextEditingController,
                    readOnly: false,
                    obscureText: obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icon(LucideIcons.lockKeyholeOpen),
                    suffixIcon: IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: obscureText
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
                  CommonTextfield(
                    hintText: "Confirm Your Password",
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
                      } else if (value != passwordTextEditingController.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  // Consumer(
                  //   builder: (context, AuthServices authServices, child) =>
                  //       LargeButton(onPressed: (){
                  //         if(signupformkey.currentState!.validate()){
                  //           authServices.signup(
                  //             usernameTextEditingController.text.trim(),
                  //             emailTextEditingController.text.trim(),
                  //             passwordTextEditingController.text.trim(),
                  //             context,
                  //           );
                  //         }
                  //       }, text: "Sign Up"),
                  // ),
                  LargeButton(onPressed: signup, text: "Sign Up"),
                  SizedBox(
                    height: 6.0,
                  ),
                  CustomDivider(text: "Or Sign Up With"),
                  SizedBox(
                    height: 6.0,
                  ),
                  ContinueWithGoogle(),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Log In Now",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/modules/auth/auth_exports.dart';

class Loginorsignup extends StatefulWidget {
  const Loginorsignup({super.key});

  @override
  State<Loginorsignup> createState() => _LoginorsignupState();
}

class _LoginorsignupState extends State<Loginorsignup> {
  bool showLogInScreen = true;
  //function to toggle between screens
  void toggleScreen() {
    setState(() {
      showLogInScreen = !showLogInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogInScreen) {
      return LoginPage(onTap: toggleScreen);
    } else {
      return SignupPage(onTap: toggleScreen);
    }
  }
}

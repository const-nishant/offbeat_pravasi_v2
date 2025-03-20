import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/router/navbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth_exports.dart';

class Authwrapper extends StatefulWidget {
  const Authwrapper({super.key});

  @override
  State<Authwrapper> createState() => _AuthwrapperState();
}

class _AuthwrapperState extends State<Authwrapper> {
  Future<bool> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isFirstTime") ?? true;
  }

  Future<void> setFirstTimeFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isFirstTime", false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkFirstTime(),
      builder: (context, firstTimeSnapshot) {
        if (firstTimeSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        bool isFirstTime = firstTimeSnapshot.data ?? true;

        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, authSnapshot) {
            if (authSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (authSnapshot.hasData) {
              return Consumer<AuthServices>(
                builder: (context, authServices, child) {
                  return FutureBuilder<bool>(
                    future: authServices.checkSignupStatus(
                        authSnapshot.data!.uid, context),
                    builder: (context, signupSnapshot) {
                      if (signupSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (signupSnapshot.hasError ||
                          !signupSnapshot.hasData) {
                        return const Loginorsignup();
                      } else {
                        return signupSnapshot.data!
                            ? const OnboardingPage()
                            : Navbar();
                      }
                    },
                  );
                },
              );
            } else {
              if (isFirstTime) {
                debugPrint("Navigating to Mainonboarding");
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setFirstTimeFalse();
                });
                return const Mainonboarding();
              } else {
                return const Loginorsignup();
              }
            }
          },
        );
      },
    );
  }
}

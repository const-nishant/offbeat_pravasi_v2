import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:offbeat_pravasi_v2/modules/module_exports.dart';

class AuthServices with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//login function
  Future login(String email, String password, BuildContext context) async {
    _showLoader(context);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showError(context, e.toString());
    } finally {
      if (context.mounted) Navigator.pop(context); // Close the loader
    }
    notifyListeners();
  }

  //signup function
  Future signup(String username, String email, String password,
      BuildContext context) async {
    _showSignupLoader(context);
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserData userInfo = UserData(
        username: username,
        email: email,
        phone: '', // Add phone if available
        uid: userCredential.user!.uid,
        profileImage: '', // Add profile image if available
      );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userInfo.toMap());
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    } finally {
      if (_dialogContext != null && _dialogContext!.mounted) {
        Navigator.pop(_dialogContext!); // Close the loader
        _dialogContext = null; // Reset after closing
      }
    }

    notifyListeners();
  }

//continue with google function
  Future<dynamic> continueWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserData googleUserInfo = UserData(
        username: googleUser.displayName!,
        email: googleUser.email,
        phone: '', // Add phone if available
        uid: _auth.currentUser?.uid ?? googleUser.id,
        profileImage:
            googleUser.photoUrl ?? '', // Add profile image if available
      );

      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid ?? googleUser.id)
          .set(googleUserInfo.toMap());

      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    }

    notifyListeners();
  }

  //loader
  void _showLoader(BuildContext context) {
    Future.microtask(() {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
    });
  }

  BuildContext? _dialogContext; // Store context of dialog

  //loader for signup
  void _showSignupLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        _dialogContext = dialogContext; // Store context of dialog
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  //error function
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  //logout function
  void logout(BuildContext context) async {
    await _auth.signOut();

    notifyListeners();
  }
}

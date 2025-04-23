import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:offbeat_pravasi_v2/modules/module_exports.dart';

class AuthServices with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;
  String? get uid => _auth.currentUser?.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // // Get user document from Firestore
  // Future<DocumentSnapshot> getUserDocument(String uid) async {
  //   return await _firestore.collection('users').doc(uid).get();
  // }

  // Login function
  Future login(String email, String password, BuildContext context) async {
    _showSignupLoader(context);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Update FCM token after login
      await PushNotifications.getDeviceToken();
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
  }

  // Signup function
  Future signup(String username, String email, String password,
      BuildContext context) async {
    _showSignupLoader(context);
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String? notificationToken = await FirebaseMessaging.instance.getToken();

      UserData userInfo = UserData(
        dob: '',
        gender: '',
        name: '',
        username: username,
        email: email,
        phone: '', // Add phone if available
        uid: userCredential.user!.uid,
        authProvider: 'email',
        isSignup: true,
        notificationToken: notificationToken,
        profileImage: '', // Add profile image if available
      );

      // Start listening for token refresh
      PushNotifications.listenForTokenRefresh();

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

  // Check signup status
  Future<bool> checkSignupStatus(String uid, BuildContext context) async {
    try {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        return userSnapshot['isSignup'] ?? false;
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    }
    notifyListeners();
    return false;
  }

  // Continue with Google function
  Future<dynamic> continueWithGoogle(BuildContext context) async {
    _showSignupLoader(context);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);

      String? notificationToken = await FirebaseMessaging.instance.getToken();

      DocumentSnapshot userSnapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid ?? '')
          .get();
      if (!userSnapshot.exists) {
        UserData googleUserInfo = UserData(
          username: '',
          dob: '',
          gender: '',
          name: googleUser.displayName!,
          email: googleUser.email,
          phone: '', // Add phone if available
          uid: _auth.currentUser?.uid ?? '',
          authProvider: 'google',
          notificationToken: notificationToken,
          profileImage:
              googleUser.photoUrl ?? '', // Add profile image if available
          isSignup: true,
        );

        await _firestore
            .collection('users')
            .doc(_auth.currentUser?.uid ?? googleUser.id)
            .set(googleUserInfo.toMap());
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        _showError(context, e.message ?? 'An error occurred');
      }
    } finally {
      if (_dialogContext != null && _dialogContext!.mounted) {
        Navigator.pop(_dialogContext!); // Close the loader
        _dialogContext = null; // Reset after closing
      }
    }

    notifyListeners();
  }

  // Reset password function
  Future resetPassword(String email, BuildContext context) async {
    bool isLinksent = false;
    _showLoader(context);
    try {
      await _auth.sendPasswordResetEmail(email: email);
      isLinksent = true;
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      isLinksent = false;
      if (context.mounted) {
        _showError(context, e.message ?? 'An error occurred');
      }
    } finally {
      if (context.mounted) {
        if (isLinksent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password reset link sent to your email'),
            ),
          );
        }
      }
    }
  }

//change password
  Future<void> changePassword(
      String currentPassword, String newPassword, BuildContext context) async {
    _showSignupLoader(context);
    try {
      if (user == null || user!.email == null) {
        throw Exception('User not Found');
      }

      //re-authenticate user
      final credential = EmailAuthProvider.credential(
          email: user!.email!, password: currentPassword);
      await user!.reauthenticateWithCredential(credential);
      await _auth.currentUser?.updatePassword(newPassword);
      if (context.mounted) Navigator.pop(context);
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        _showError(context, e.toString());
      }
    }
  }

  // Loader
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

  // Loader for signup
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

  // Error function
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // Logout function
  void logout(BuildContext context) async {
    await _auth.signOut();
    notifyListeners();
  }
}

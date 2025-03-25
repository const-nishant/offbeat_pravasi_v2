import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../auth/auth_exports.dart';

class ProfileService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserData? _userData;
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  UserData? get userData => _userData;

  ProfileService() {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      if (doc.exists) {
        _userData = UserData.fromDocument(doc);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error fetching user data: $e");
    }
  }
}

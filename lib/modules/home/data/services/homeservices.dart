import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../auth/auth_exports.dart';
import '../../home_exports.dart';

class HomeServices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> get states => _states;
  List<TrekData> _treks = [];
  TrekData? _singleTrek;
  UserData? _userData;
  bool _isLoading = true;
  bool _isSingleTrekLoading = false;

  List<TrekData> get treks => _treks;
  TrekData? get singleTrek => _singleTrek;
  bool get isLoading => _isLoading;
  bool get isSingleTrekLoading => _isSingleTrekLoading;
  UserData? get userData => _userData;

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

  HomeServices() {
    listenToTreks();
    fetchUserData();
  }

  void listenToTreks({String? field, dynamic value}) {
    _isLoading = true;
    notifyListeners(); // Notify UI before fetching data

    Query query = _firestore.collection('treks');

    // Apply filter only if field is not null/empty and value is not null
    if (field?.isNotEmpty == true && value != null) {
      query = query.where(field!, isEqualTo: value);
    }

    query.snapshots().listen((snapshot) {
      _treks = snapshot.docs.map((doc) => TrekData.fromDocument(doc)).toList();
      _isLoading = false;
      notifyListeners(); // Notify UI about the change
    }, onError: (error) {
      _isLoading = false;
      notifyListeners(); // Ensure UI updates even on failure
      debugPrint("Error fetching treks: $error");
    });
  }

  Future<void> fetchTrekById(String trekId) async {
    _isSingleTrekLoading = true;
    notifyListeners();

    try {
      final doc = await _firestore.collection('treks').doc(trekId).get();

      if (doc.exists) {
        _singleTrek = TrekData.fromDocument(doc);
      } else {
        _singleTrek = null;
      }
    } catch (e) {
      // Handle any errors that occur during the fetch
      debugPrint("Error fetching trek by ID: $e");
      _singleTrek = null;
    } finally {
      _isSingleTrekLoading = false;
      notifyListeners(); // Notify UI about the change
    }
  }

  final List<String> _states = [
    "Maharashtra",
    "Meghalaya",
    "Karnataka",
    "Tamil Nadu",
    "Kerala",
    "Andhra Pradesh",
    "Telangana",
    "Himachal Pradesh",
    "Uttarakhand",
    "Nagaland",
    "Manipur",
    "Sikkim",
    "West Bengal",
    "Arunachal Pradesh",
  ];
}

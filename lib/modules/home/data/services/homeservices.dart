import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../home_exports.dart';

class HomeServices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> get states => _states;
  List<TrekData> _treks = [];
  bool _isLoading = true;

  List<TrekData> get treks => _treks;
  bool get isLoading => _isLoading;

  HomeServices() {
    listenToTreks();
  }

  void listenToTreks() {
    _firestore.collection('treks').snapshots().listen((snapshot) {
      _treks = snapshot.docs.map((doc) => TrekData.fromDocument(doc)).toList();
      _isLoading = false;
      notifyListeners(); // Notify UI about the change
    });
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

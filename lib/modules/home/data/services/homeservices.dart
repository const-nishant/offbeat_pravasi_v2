import 'package:flutter/material.dart';

class HomeServices extends ChangeNotifier {
  List<String> get states => _states;

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

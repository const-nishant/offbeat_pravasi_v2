import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SOSService extends ChangeNotifier {
  List<Map<String, String>> _contacts = [];

  List<Map<String, String>> get contacts => _contacts;

  SOSService() {
    loadContacts();
  }

  Future<void> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> storedContacts = prefs.getStringList('contacts') ?? [];
    _contacts = storedContacts
        .map((contact) => Map<String, String>.from(jsonDecode(contact)))
        .toList();
    notifyListeners();
  }

  Future<void> addContact({
    required String name,
    required String phone,
    File? image,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final newContact = {
      "name": name,
      "phone": phone,
      "imagePath": image?.path ?? "",
    };

    _contacts.add(newContact);
    List<String> encodedContacts =
        _contacts.map((contact) => jsonEncode(contact)).toList();
    await prefs.setStringList('contacts', encodedContacts);

    notifyListeners();
  }

  Future<void> removeContact(int index) async {
    final prefs = await SharedPreferences.getInstance();

    _contacts.removeAt(index);
    List<String> encodedContacts =
        _contacts.map((contact) => jsonEncode(contact)).toList();
    await prefs.setStringList('contacts', encodedContacts);

    notifyListeners();
  }

  // Future<void> callFirstContact() async {
  //   if (_contacts.isEmpty) {
  //     debugPrint("No contacts available.");
  //     return;
  //   }

  //   final String phoneNumber = _contacts.first["phone"] ?? "";

  //   // Request CALL_PHONE permission
  //   PermissionStatus status = await Permission.phone.request();

  //   if (status.isGranted) {
  //     bool? callSuccess = await DirectCallPlus.makeCall(phoneNumber);
  //     if (callSuccess == false) {
  //       debugPrint("Failed to make a direct call.");
  //     }
  //   } else {
  //     debugPrint("Call permission denied.");
  //   }
  // }
}

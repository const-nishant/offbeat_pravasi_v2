import 'dart:convert';
import 'dart:io';

import 'package:direct_call_plus/direct_call_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SOSService extends ChangeNotifier {
  List<Map<String, String>> _contacts = [];

  List<Map<String, String>> get contacts => _contacts;

  static const platform = MethodChannel('sms_channel');

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

  Future<void> callFirstContact() async {
    if (_contacts.isEmpty) {
      debugPrint("No contacts available.");
      return;
    }

    final String phoneNumber = _contacts.first["phone"] ?? "";

    PermissionStatus status = await Permission.phone.request();

    if (status.isGranted) {
      bool? callSuccess = await DirectCallPlus.makeCall(phoneNumber);
      if (callSuccess == false) {
        debugPrint("Failed to make a direct call.");
      }
    } else {
      debugPrint("Call permission denied.");
    }
  }

  Future<void> sendLocationMessage() async {
    if (_contacts.isEmpty) {
      debugPrint("No contacts available.");
      return;
    }

    // Check & Request SMS Permission
    PermissionStatus smsPermission = await Permission.sms.request();
    if (!smsPermission.isGranted) {
      debugPrint("SMS permission not granted.");
      return;
    }

    // Check Location Service
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location services are disabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("Location permission permanently denied.");
      return;
    }

    // Get Current Location
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ));

    // Generate Location Message
    String googleMapsLink =
        "https://www.google.com/maps?q=${position.latitude},${position.longitude}";
    String message = "SOS! This is my current location: $googleMapsLink";

    // Extract Phone Numbers
    List<String> phoneNumbers = _contacts
        .map((contact) => contact["phone"] ?? "")
        .where((phone) => phone.isNotEmpty)
        .toList();

    for (String phoneNumber in phoneNumbers) {
      await sendSms(phoneNumber, message);
    }
  }

  Future<void> sendSms(String phoneNumber, String message) async {
    try {
      final String result = await platform.invokeMethod('sendSms', {
        "phoneNumber": phoneNumber,
        "message": message,
      });
      debugPrint(result);
    } catch (e) {
      debugPrint("Failed to send SMS: $e");
    }
  }
}

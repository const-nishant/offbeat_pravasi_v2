import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import 'package:shared_preferences/shared_preferences.dart';

class Helperservices extends ChangeNotifier {
  late SharedPreferences prefs;

  Future<void> initialization() async {
    prefs = await SharedPreferences.getInstance();
  }

  Helperservices() {
    initialization();
  }

  File? _image;
  final List<File> _images = [];
  DateTime? _date;
  String? latitude;
  String? longitude;

  File? get image => _image;
  DateTime? get date => _date;
  List<File> get images => _images;

  //trek points calculator
  double calculateTrekPoints({
    required double trekAltitude,
    required String trekDifficulty,
    required double trekDuration,
    required double trekDistance,
    required double trekCost,
  }) {
    // Assign points based on difficulty level
    Map<String, int> difficultyPoints = {
      "Easy": 10,
      "Moderate": 20,
      "Difficult": 30,
      "Extreme": 40,
    };

    int difficultyScore = difficultyPoints[trekDifficulty] ?? 0;

    // Calculate points
    double altitudeScore = trekAltitude / 100; // 1 point per 100m altitude
    double durationScore = trekDuration * 2; // 2 points per day
    double distanceScore = trekDistance * 1.5; // 1.5 points per km
    double costScore =
        (trekCost <= 5000) ? 10 : 5; // More points for budget treks

    // Total points calculation
    double totalPoints = altitudeScore +
        difficultyScore +
        durationScore +
        distanceScore +
        costScore;

    return totalPoints;
  }

//get user location
  Future<String> getUserLocation() async {
    try {
      // Step 1: Get current position
      Position position = await _getCurrentPosition();

      // Store lat/lng as string
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();

      //store lat and long in shared prefrences
      if (prefs.getString('latitude') == null &&
          prefs.getString('longitude') == null) {
        prefs = await SharedPreferences.getInstance();
        prefs.setString('latitude', latitude!);
        prefs.setString('longitude', longitude!);
      }

      // Step 2: Get human-readable address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;
      // Format: District, State
      String location =
          "${place.subAdministrativeArea}, ${place.administrativeArea}";

      return location;
    } catch (e) {
      debugPrint('Location Error: $e');
      return "Location not available";
    }
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: permission == LocationPermission.always
            ? LocationAccuracy.best
            : LocationAccuracy.high,
      ),
    );
  }

  // Reset the image variable
  void resetImage() {
    _image = null;
    notifyListeners();
  }

  //image compreser
  Future<File?> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/${basename(file.path)}.jpg';

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, // Input file path
      targetPath, // Output file path
      quality: 60, // Adjust quality (0-100)
    );

    return result != null ? File(result.path) : null;
  }

  /// Compress multiple images
  Future<List<File>> compressImages(List<File> files) async {
    final dir = await getTemporaryDirectory();
    List<File> compressedFiles = [];

    for (File file in files) {
      final targetPath =
          '${dir.absolute.path}/${basename(file.path)}_compressed.jpg';

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 70,
      );

      if (result != null) {
        compressedFiles.add(File(result.path));
      }
    }

    return compressedFiles;
  }

  /// Pick up to 4 images
  Future<bool> pickImages(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (pickedImages.isNotEmpty) {
      if (pickedImages.length > 4) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You can select up to 4 images only.'),
          ),
        );
        return false;
      }
      _images.clear(); // Clear previous images
      _images.addAll(pickedImages.map((img) => File(img.path))); // Store images
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Pick a single image
  Future<bool> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _image = File(pickedImage.path);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  /// Pick a date in the past
  Future<void> datePicker(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _date = picked;
      notifyListeners();
    }
  }

  /// Pick a date in the future
  Future<void> futureDatePicker(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _date = picked;
      notifyListeners();
    }
  }

  /// Format date
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

//time ago formater
  String formatTimestamp(Timestamp timestamp) {
    DateTime postDate = timestamp.toDate();
    DateTime now = DateTime.now();
    Duration difference = now.difference(postDate);

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds}s ago";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return DateFormat('dd MMM yyyy').format(postDate); // Example: 10 Mar 2025
    }
  }
}

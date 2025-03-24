import 'dart:io';
import "package:path_provider/path_provider.dart";
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import "package:path/path.dart";

class Helperservices extends ChangeNotifier {
  File? _image;
  final List<File> _images = [];
  DateTime? _date;

  File? get image => _image;
  DateTime? get date => _date;
  List<File> get images => _images;

  //image compreser
  Future<File?> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/${basename(file.path)}.jpg';

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, // Input file path
      targetPath, // Output file path
      quality: 70, // Adjust quality (0-100)
    );

    return result != null ? File(result.path) : null;
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
}

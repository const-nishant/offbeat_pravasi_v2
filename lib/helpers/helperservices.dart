import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Helperservices extends ChangeNotifier {
  File? _image;

  File? get image => _image;

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

  DateTime? _date;

  DateTime? get date => _date;

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

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}

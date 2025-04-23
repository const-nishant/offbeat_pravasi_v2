import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/modules/module_exports.dart';
import '../../../../config/configs.dart';
import '../../../../helpers/helper_exports.dart';
import '../../../../main.dart';

class Trekservices extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = Storage(client);
  BuildContext? _dialogContext;
  final Helperservices _helperservices = Helperservices();

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

//convert to markdown
  String convertToMarkdown(String inputText) {
    final StringBuffer markdownBuffer = StringBuffer();
    final List<String> lines = inputText.split('\n');

    bool previousWasEmpty = false;

    for (String line in lines) {
      String trimmedLine = line.trimRight(); // Preserve leading spaces

      if (trimmedLine.isEmpty) {
        if (!previousWasEmpty) {
          markdownBuffer.writeln(); // Preserve paragraph spacing
          previousWasEmpty = true;
        }
        continue;
      }
      previousWasEmpty = false;

      // Detect prefix (emoji, symbol, or bullet)
      RegExp prefixPattern =
          RegExp(r'^([\p{So}\p{L}\p{N}\W]+)\s+', unicode: true);
      Match? match = prefixPattern.firstMatch(trimmedLine);

      if (match != null) {
        String prefix = match.group(1) ?? '';
        String content = trimmedLine.substring(prefix.length).trim();

        // Headings: If it starts with 📍 or contains a colon (like Day 1:), treat as heading
        if (prefix.contains('📍') || content.contains(':')) {
          markdownBuffer
              .writeln('\n## $prefix $content\n'); // Proper Markdown heading
        } else {
          markdownBuffer.writeln('- $prefix $content'); // List formatting
        }
      } else {
        markdownBuffer.writeln(trimmedLine); // Preserve normal text
      }
    }

    return markdownBuffer.toString().trim();
  }

//convert to markdown paragraph
  String convertToMarkdownParagraph(String inputText) {
    final StringBuffer markdownBuffer = StringBuffer();
    final List<String> paragraphs = inputText.trim().split('\n');

    for (String paragraph in paragraphs) {
      if (paragraph.isNotEmpty) {
        markdownBuffer.writeln(paragraph.trim());
        markdownBuffer.writeln(); // Add a blank line for proper spacing
      }
    }

    return markdownBuffer.toString().replaceAll('\n', '\n\n').trim();
  }

//add trek
  Future<void> addTreks({
    required BuildContext context,
    required String trekName,
    required String trekLocation,
    required DateTime trekDate,
    required String trekOverview,
    required List<File> trekImages,
    required double trekRating,
    required double trekReviews,
    required int trekAltitude,
    required String trekDifficulty,
    required String trekDuration,
    required double trekDistance,
    required double trekCost,
    required String trekItinerary,
    required String trekStateLocation,
    required String recommendedGear,
    required String recommendedEssentials,
  }) async {
    _showLoader(context);
    try {
      // Generate a unique trekId
      String trekId =
          '${trekLocation.substring(0, 1)}${DateTime.now().millisecondsSinceEpoch.toString()}';
      // Upload trek images
      List<String> trekImagesUrls = [];
      for (File image in trekImages) {
        String fileId = ID.unique(); // Truncate to 36 characters
        await storage.createFile(
          bucketId: Configs.appWriteTrekImageStorageBucketId,
          fileId: fileId,
          file: InputFile.fromPath(path: image.path),
        );
        // Get the image URL
        String imageUrl =
            'https://cloud.appwrite.io/v1/storage/buckets/${Configs.appWriteTrekImageStorageBucketId}/files/$fileId/view?project=${Configs.appWriteProjectId}&mode=admin';
        // Add the image URL to the list
        trekImagesUrls.add(imageUrl);
      }
      final DocumentSnapshot userSnapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      final userData = userSnapshot.data() as Map<String, dynamic>?;

      String trekOrganizer = userData?['name'] ?? 'Unknown';
      String trekOrganizerContact = userData?['phone'] ?? 'not available';
      double trekPoints = _helperservices.calculateTrekPoints(
        trekAltitude: trekAltitude.toDouble(),
        trekDifficulty: trekDifficulty,
        trekDuration: double.parse(trekDuration),
        trekDistance: trekDistance,
        trekCost: trekCost,
      );

      Trek trek = Trek(
        isEvent: false,
        trekId: trekId,
        trekName: trekName,
        trekLocation: trekLocation,
        trekStateLocation: trekStateLocation,
        trekDate: trekDate,
        trekOverview: trekOverview,
        trekImages: trekImagesUrls,
        trekRating: trekRating,
        trekReviews: trekReviews,
        trekAltitude: trekAltitude,
        trekDifficulty: trekDifficulty,
        trekDuration: trekDuration,
        trekDistance: trekDistance,
        trekCost: trekCost,
        trekItinerary: trekItinerary,
        recommendedGear: recommendedGear,
        recommendedEssentials: recommendedEssentials,
        trekOrganizer: trekOrganizer,
        trekUploadTimestamp: Timestamp.now(),
        trekOrganizerContact: trekOrganizerContact,
        trekPoints: trekPoints,
      );

      await _firestore.collection('treks').doc(trekId).set(trek.toMap());

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Trek added successfully!')),
      );
      notifyListeners();
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

//get trek by id
  Future<Map<String, dynamic>?> getTrekById(String trekId) async {
    final doc = await _firestore.collection('treks').doc(trekId).get();
    return doc.exists ? doc.data() : null;
  }

// Loader
  void _showLoader(BuildContext context) {
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
}

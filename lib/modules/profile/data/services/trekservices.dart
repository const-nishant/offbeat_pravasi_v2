import 'package:flutter/material.dart';

class Trekservices extends ChangeNotifier {
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

  Future<void> addTreks({
    required BuildContext context,
    required String trekId,
    required String trekName,
    required String trekLocation,
    required DateTime trekDate,
    required String trekOverview,
    required List<String> trekImages,
    required double trekRating,
    required List<String> trekReviews,
    required int trekAltitude,
    required String trekDifficulty,
    required String trekDuration,
    required double trekDistance,
    required double trekCost,
    required String trekItinerary,
    required List<String> recommendedGear,
    required List<String> recommendedEssentials,
    required String trekOrganizer,
    required String trekOrganizerContact,
  }) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Trek added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding trek: $e')),
      );
    }
  }
}

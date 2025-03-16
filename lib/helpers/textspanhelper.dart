import 'package:flutter/material.dart';

class Textspanhelper {
  static List<TextSpan> buildDescriptionTextSpans(
      String description, BuildContext context) {
    List<TextSpan> spans = [];
    List<String> words = description.split(' ');

    for (String word in words) {
      if (word.startsWith('#')) {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$word ',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        );
      }
    }

    return spans;
  }
}

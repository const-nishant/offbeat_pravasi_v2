import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerModel {
  final String uid; // User ID to link answers to a user
  final Map<String, String>
      selectedAnswers; // Stores question & selected answer

  AnswerModel({
    required this.uid,
    required this.selectedAnswers,
  });

  // Convert object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'selectedAnswers': selectedAnswers,
    };
  }

  // Create an object from Firestore document
  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      uid: map['uid'] ?? '',
      selectedAnswers: Map<String, String>.from(map['selectedAnswers'] ?? {}),
    );
  }

  // Create an object from Firestore document snapshot
  factory AnswerModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AnswerModel.fromMap(data);
  }
}

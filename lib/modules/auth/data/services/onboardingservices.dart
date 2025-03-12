import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offbeat_pravasi_v2/config/configs.dart';
import 'package:offbeat_pravasi_v2/main.dart';
import '../../auth_exports.dart';

class OnboardingServices extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = Storage(client);

  // Onboarding logic
  int _currentQuestionIndex = 0;
  final Map<String, String> _selectedAnswers = {};

  final List<Map<String, dynamic>> _onboardingQuestions = [
    {
      "question": "How experienced are you with trekking?",
      "options": [
        {"text": "Beginner", "value": "Beginner"},
        {"text": "Intermediate", "value": "Intermediate"},
        {"text": "Expert", "value": "Expert"},
      ],
    },
    {
      "question": "How often do you trek?",
      "options": [
        {"text": "Once a day", "value": "Once a day"},
        {"text": "Once a week", "value": "Once a week"},
        {"text": "Once a month", "value": "Once a month"},
      ],
    },
    {
      "question": "How long can you trek for?",
      "options": [
        {"text": "2-4 hours", "value": "2-4 hours"},
        {"text": "4-6 hours", "value": "4-6 hours"},
        {"text": "6-8 hours", "value": "6-8 hours"},
      ],
    },
    {
      "question": "Which season are you most likely to trek?",
      "options": [
        {"text": "Spring", "value": "Spring"},
        {"text": "Summer", "value": "Summer"},
        {"text": "Fall", "value": "Fall"},
        {"text": "Winter", "value": "Winter"},
      ],
    },
  ];

  // Getters
  int get currentQuestionIndex => _currentQuestionIndex;
  Map<String, String> get selectedAnswers => _selectedAnswers;
  List<Map<String, dynamic>> get onboardingQuestions => _onboardingQuestions;
  bool get isLastQuestion =>
      _currentQuestionIndex == _onboardingQuestions.length - 1;
  Map<String, dynamic> get currentQuestion =>
      _onboardingQuestions[_currentQuestionIndex];

  // Select answer and save immediately
  void selectAnswer(String question, String value) async {
    _selectedAnswers[question] = value;
    notifyListeners();
  }

  // Save answers
  Future<void> saveAnswerToFirestore(BuildContext context) async {
    if (_auth.currentUser != null) {
      _showLoader(context);
      await _firestore
          .collection('userOnboarding') // Collection name
          .doc(_auth.currentUser!.uid) // User ID as document name
          .set({
        'selectedAnswers': _selectedAnswers, // Store as a Map
      }, SetOptions(merge: true)); // Merge to update without overwriting
      if (context.mounted) {
        Navigator.pop(context);
        context.go('/about');
      }
    }
    notifyListeners();
  }

  // Move to next question
  void nextQuestion() {
    if (_currentQuestionIndex < _onboardingQuestions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  // Move to previous question
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  // Reset answers

  void resetAnswers() {
    _selectedAnswers.clear();
    _currentQuestionIndex = 0;
    notifyListeners();
  }

  Future<void> pushUserInfo({
    File? image,
    required String phone,
    required String dob,
    required String name,
    required String gender,
    required BuildContext context,
  }) async {
    _showSignupLoader(context);
    try {
      if (image != null) {
        await storage.createFile(
          bucketId: Configs.appWriteUserProfileStorageBucketId,
          fileId: _auth.currentUser!.uid,
          file: InputFile.fromPath(path: image.path),
        );

        String downloadUrl =
            'https://cloud.appwrite.io/v1/storage/buckets/${Configs.appWriteUserProfileStorageBucketId}/files/${_auth.currentUser!.uid}/view?project=${Configs.appWriteProjectId}&mode=admin';

        // Get existing user data
        DocumentSnapshot userSnapshot = await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .get();

        Map<String, dynamic> existingData = userSnapshot.exists
            ? userSnapshot.data() as Map<String, dynamic>
            : {};

        UserData userInfo = UserData(
          uid: _auth.currentUser!.uid,
          email: _auth.currentUser!.email ?? existingData['email'],
          isSignup: false,
          authProvider: existingData['authProvider'] ?? '',
          profileImage: downloadUrl,
          name: name,
          phone: phone,
          dob: dob,
          gender: gender,
          username: existingData['username'],
        );

        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .set(userInfo.toMap(), SetOptions(merge: true));

        if (context.mounted) {
          Navigator.pop(context);
        }
        // ignore: use_build_context_synchronously
        //  Phoenix.rebirth(context);
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    } finally {
      // ignore: use_build_context_synchronously
      context.go('/');
    }
    notifyListeners();
  }
}

// Show loading dialog
void _showLoader(BuildContext context) {
  Future.microtask(() {
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  });
}

// Show error message
void _showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

// ignore: unused_element
BuildContext? _dialogContext;

void _showSignupLoader(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      _dialogContext = dialogContext; // Store context of dialog
      return const Center(child: CircularProgressIndicator());
    },
  );
}

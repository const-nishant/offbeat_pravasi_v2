import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../dataexports.dart';

class ReviewServices with ChangeNotifier {
  List<ReviewModel> _reviews = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<ReviewModel> get reviews => _reviews;

  //add a review to the trek
  Future<void> addreviewandratingtotrek(
      String trekId, double rating, String review) async {
    await FirebaseFirestore.instance.collection('treks').doc(trekId).update({
      'trekRating': FieldValue.increment(rating),
      'trekReviews': FieldValue.increment(1),
    });
  }

  Future<void> fetchReviews(String trekId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('treks')
        .doc(trekId)
        .collection('reviews')
        .get();

    _reviews =
        snapshot.docs.map((doc) => ReviewModel.fromMap(doc.data())).toList();
    notifyListeners();
  }

  Future<void> addReview(
      String trekId, ReviewModel review, BuildContext context) async {
    _isLoading = true;
    await FirebaseFirestore.instance
        .collection('treks')
        .doc(trekId)
        .collection('reviews')
        .add(review.toMap());
    _reviews.add(review);
    _isLoading = false;
    notifyListeners();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Review added successfully'),
    ));
  }
}

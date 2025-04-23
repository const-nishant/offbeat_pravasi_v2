import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Bookmarkservices extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  List<String> _bookmarks = [];

  List<String> get bookmarks => _bookmarks;

  Future<void> fetchBookmarks() async {
    final uid = _auth.currentUser!.uid;

    final snapshot = await _firestore.collection('bookmarks').doc(uid).get();

    if (snapshot.exists) {
      _bookmarks = List<String>.from(snapshot.data()!['bookmarks']);
      notifyListeners();
    }
  }

  bool isBookmarked(String trekId) => _bookmarks.contains(trekId);

  Future<void> toggleBookmark(String trekId) async {
    final uid = _auth.currentUser!.uid;

    if (_bookmarks.contains(trekId)) {
      _bookmarks.remove(trekId);
    } else {
      _bookmarks.add(trekId);
    }

    await _firestore.collection('bookmarks').doc(uid).set({
      'bookmarks': _bookmarks,
    }, SetOptions(merge: true));

    notifyListeners();
  }
}

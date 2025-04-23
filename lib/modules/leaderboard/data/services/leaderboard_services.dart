import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../exports.dart';

class LeaderboardServices extends ChangeNotifier {
  final List<LeaderboardUser> _users = [];

  List<LeaderboardUser> get users => _users;

  /// Fetches users and calculates their ranks based on userPoints
  Future<void> fetchAndRankUsers() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      // Step 1: Get current user's document
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      final userData = userDoc.data();
      if (userData == null || userData['friendsIds'] is! List) return;

      final List<dynamic> friendsIds = userData['friendsIds'];

      if (friendsIds.isEmpty) {
        _users.clear();
        notifyListeners();
        return;
      }

      // Step 2: Query only users whose UID is in friendsIds
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, whereIn: friendsIds)
          .get();

      List<LeaderboardUser> fetchedUsers = [];

      for (var doc in querySnapshot.docs) {
        final data = doc.data();

        final username = data['username'] ?? 'Unknown';
        final name = data['name'] ?? '';
        final profileImage = data['profileImage'] ?? '';

        final points = (data['userPoints'] is int)
            ? data['userPoints']
            : (data['userPoints'] is double)
                ? (data['userPoints'] as double).toInt()
                : 0;

        fetchedUsers.add(
          LeaderboardUser(
            uid: doc.id,
            username: username,
            name: name,
            points: points,
            profileImage: profileImage,
            rank: 0,
          ),
        );
        debugPrint('Fetched Friend: ${doc.id}');
      }

      // Sort and rank
      fetchedUsers.sort((a, b) => b.points.compareTo(a.points));
      for (int i = 0; i < fetchedUsers.length; i++) {
        fetchedUsers[i] = fetchedUsers[i].copyWith(rank: i + 1);
      }

      _users
        ..clear()
        ..addAll(fetchedUsers);

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching leaderboard friends: $e');
    }
  }
}

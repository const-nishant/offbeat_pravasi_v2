import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderboardUser {
  final String uid;
  final String username;
  final String name;
  final int points;
  final String profileImage;
  final int rank;

  LeaderboardUser({
    required this.uid,
    required this.username,
    required this.name,
    required this.points,
    required this.profileImage,
    required this.rank,
  });
}

class LeaderboardServices extends ChangeNotifier {
  final List<LeaderboardUser> _users = [];

  List<LeaderboardUser> get users => _users;

  /// Fetches users and calculates their ranks based on userPoints
  Future<void> fetchAndRankUsers() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

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
        debugPrint('Fetched User: ${doc.id}, UID: ${doc.id}');
      }

      // Sort users by userPoints in descending order
      fetchedUsers.sort((a, b) => b.points.compareTo(a.points));

      // Assign ranks
      for (int i = 0; i < fetchedUsers.length; i++) {
        fetchedUsers[i] = LeaderboardUser(
          uid: fetchedUsers[i].uid,
          username: fetchedUsers[i].username,
          name: fetchedUsers[i].name,
          points: fetchedUsers[i].points,
          profileImage: fetchedUsers[i].profileImage,
          rank: i + 1,
        );
      }

      _users.clear();
      _users.addAll(fetchedUsers);

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching leaderboard users: $e');
    }
  }
}

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

  // ✅ Add this method
  LeaderboardUser copyWith({
    String? uid,
    String? username,
    String? name,
    int? points,
    String? profileImage,
    int? rank,
  }) {
    return LeaderboardUser(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      name: name ?? this.name,
      points: points ?? this.points,
      profileImage: profileImage ?? this.profileImage,
      rank: rank ?? this.rank,
    );
  }

  // Optional: for mapping to/from Firestore
  factory LeaderboardUser.fromMap(Map<String, dynamic> map, String uid) {
    return LeaderboardUser(
      uid: uid,
      username: map['username'] ?? 'Unknown',
      name: map['name'] ?? '',
      points: map['userPoints'] is int
          ? map['userPoints']
          : (map['userPoints'] is double)
              ? (map['userPoints'] as double).toInt()
              : 0,
      profileImage: map['profileImage'] ?? '',
      rank: map['rank'] is int
          ? map['rank']
          : (map['rank'] is double)
              ? (map['rank'] as double).toInt()
              : 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'name': name,
      'userPoints': points,
      'profileImage': profileImage,
      'rank': rank,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String userId;
  final String username;
  final double rating;
  final String review;
  final String trekId;
  final String profileImage;
  final Timestamp timestamp;

  ReviewModel({
    required this.trekId,
    required this.userId,
    required this.username,
    required this.rating,
    required this.review,
    required this.profileImage,
    required this.timestamp,
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      userId: map['userId'] as String? ?? '',
      username: map['username'] as String? ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      review: map['review'] as String? ?? '',
      profileImage: map['profileImage'] as String? ?? '',
      trekId: map['trekId'] as String? ?? '',
      timestamp: map['timestamp'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'rating': rating,
      'review': review,
      'profileImage': profileImage,
      'trekId': trekId,
      'timestamp': timestamp,
    };
  }
}

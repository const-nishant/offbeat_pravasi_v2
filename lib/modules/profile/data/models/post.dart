import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String userId;
  final String caption;
  final String imageUrl;
  final String username;
  final String userImageUrl;
  final String location;
  final int comments;
  final List<String> likes;
  final Timestamp uploadTimestamp;

  Post({
    required this.postId,
    required this.userId,
    required this.comments,
    required this.likes,
    required this.username,
    required this.userImageUrl,
    required this.location,
    required this.caption,
    required this.imageUrl,
    required this.uploadTimestamp,
  });

  // Convert object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'caption': caption,
      'imageUrl': imageUrl,
      'comments': comments,
      'likes': likes,
      'uploadTimestamp': uploadTimestamp,
      'username': username,
      'userImageUrl': userImageUrl,
      'location': location,
    };
  }

  // Create an object from Firestore document
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'] ?? '',
      userId: map['userId'] ?? '',
      caption: map['caption'] ?? '',
      comments: map['comments'] ?? 0,
      likes: List<String>.from(map['likes'] ?? []),
      imageUrl: map['imageUrl'] ?? '',
      uploadTimestamp: map['uploadTimestamp'] ?? Timestamp.now(),
      username: map['username'] ?? '',
      userImageUrl: map['userImageUrl'] ?? '',
      location: map['location'] ?? '',
    );
  }

  // Create an object from Firestore document snapshot
  factory Post.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post.fromMap(data);
  }
}

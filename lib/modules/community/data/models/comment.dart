import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String uid;
  final String username;
  final String comment;
  final String userImage;
  final Timestamp time;

  Comment({
    required this.uid,
    required this.username,
    required this.comment,
    required this.userImage,
    required this.time,
  });

  // Convert object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'comment': comment,
      'userImage': userImage,
      'time': time,
    };
  }

  // Create an object from Firestore document
  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      comment: map['comment'] ?? '',
      userImage: map['userImage'] ?? '',
      time: map['time'] is Timestamp ? map['time'] : Timestamp.now(),
    );
  }

  // Create an object from Firestore document snapshot
  factory Comment.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Comment.fromMap(data);
  }
}

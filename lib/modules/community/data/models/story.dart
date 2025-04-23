import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String uid;
  final String username;
  final String imageUrl;
  final Timestamp time;

  Story({
    required this.uid,
    required this.username,
    required this.imageUrl,
    required this.time,
  });

  // Convert object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'imageUrl': imageUrl,
      'time': time,
    };
  }

  // Create an object from Firestore document
  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      time: map['time'] is Timestamp ? map['time'] : Timestamp.now(),
    );
  }

  // Create an object from Firestore document snapshot
  factory Story.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Story.fromMap(data);
  }
}

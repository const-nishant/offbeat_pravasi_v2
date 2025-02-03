import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String username;
  final String email;
  final String phone;
  final String uid;
  final String profileImage;

  UserData({
    required this.username,
    required this.email,
    required this.phone,
    required this.uid,
    required this.profileImage,
  });

  // Convert object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'uid': uid,
      'profileImage': profileImage,
    };
  }

  // Create an object from Firestore document
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      uid: map['uid'] ?? '',
      profileImage: map['profileImage'] ?? '',
    );
  }

  // Create an object from Firestore document snapshot
  factory UserData.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserData.fromMap(data);
  }
}

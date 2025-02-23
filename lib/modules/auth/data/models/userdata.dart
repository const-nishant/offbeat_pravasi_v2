import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String? username;
  final String? email;
  final String? phone;
  final String uid;
  final String authProvider;
  final bool isSignup;
  final String? profileImage;
  final String? gender;
  final String? dob;
  final String? name;

  UserData({
    required this.username,
    required this.email,
    required this.phone,
    required this.uid,
    required this.authProvider,
    required this.isSignup,
  
    required this.profileImage,
    required this.gender,
    required this.dob,
    required this.name,
  });

  // Convert object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'uid': uid,
      'authProvider': authProvider,
      'isSignup': isSignup,
      'profileImage': profileImage,
      'gender': gender,
      'dob': dob,
      'name': name,
    };
  }

  // Create an object from Firestore document
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      uid: map['uid'] ?? '',
      authProvider: map['authProvider'] ?? '',
      isSignup: map['isSignup'] ?? false,
      profileImage: map['profileImage'] ?? '',
      gender: map['gender'] ?? '',
      dob: map['dob'] ?? '',
      name: map['name'] ?? '',
      
    );
  }

  // Create an object from Firestore document snapshot
  factory UserData.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserData.fromMap(data);
  }
}

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
  final String? notificationToken;
  final String? location;
  final bool? isOrganizer;
  final double? userPoints;
  final int? userDistanceTraveled;
  final List<String>? userTrekIds;
  final List<String>? userEventsIds;
  final List<String>? friendsIds;

  UserData({
    required this.username,
    required this.email,
    required this.phone,
    required this.uid,
    required this.authProvider,
    required this.isSignup,
    this.notificationToken,
    this.userPoints,
    this.isOrganizer,
    this.location,
    this.userDistanceTraveled,
    this.userTrekIds,
    this.userEventsIds,
    this.friendsIds,
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
      'isOrganizer': isOrganizer,
      'profileImage': profileImage,
      'notificationToken': notificationToken,
      'gender': gender,
      'dob': dob,
      'name': name,
      'location': location,
      'userPoints': userPoints,
      'userDistanceTraveled': userDistanceTraveled,
      'userTrekIds': userTrekIds,
      'userEventsIds': userEventsIds,
      'friendsIds': friendsIds,
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
      notificationToken: map['notificationToken'] ?? '',
      isOrganizer: map['isOrganizer'] ?? false,
      location: map['location'] ?? '',
      userPoints: map['userPoints'] ?? 0,
      userDistanceTraveled: map['userDistanceTraveled'] ?? 0,
      userTrekIds: List<String>.from(map['userTrekIds'] ?? []),
      userEventsIds: List<String>.from(map['userEventsIds'] ?? []),
      friendsIds: List<String>.from(map['friendsIds'] ?? []),
    );
  }

  // Create an object from Firestore document snapshot
  factory UserData.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserData.fromMap(data);
  }
}

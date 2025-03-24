import 'package:cloud_firestore/cloud_firestore.dart';

class Trek {
  final String trekId;
  final String trekName;
  final String trekLocation;
  final DateTime trekDate;
  final Timestamp trekUploadTimestamp;
  final String trekOverview;
  final bool isEvent;
  final List<String> trekImages;
  final double trekRating;
  final List<String> trekReviews;
  final int trekAltitude;
  final String trekDifficulty;
  final String trekDuration;
  final double trekDistance;
  final double trekCost;
  final String trekItinerary;
  final String recommendedGear;
  final String recommendedEssentials;
  final String trekOrganizer;
  final String trekOrganizerContact;

  Trek({
    required this.trekId,
    required this.trekName,
    required this.trekLocation,
    required this.trekDate,
    required this.trekUploadTimestamp,
    required this.trekOverview,
    required this.trekImages,
    required this.trekRating,
    required this.trekReviews,
    required this.trekAltitude,
    required this.trekDifficulty,
    required this.trekDuration,
    required this.trekDistance,
    required this.trekCost,
    required this.trekItinerary,
    required this.recommendedGear,
    required this.recommendedEssentials,
    required this.trekOrganizer,
    required this.trekOrganizerContact,
    required this.isEvent,
  });

  // Convert object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'trekId': trekId,
      'trekName': trekName,
      'trekLocation': trekLocation,
      'trekDate': trekDate.toIso8601String(),
      'trekUploadTimestamp': trekUploadTimestamp,
      'trekOverview': trekOverview,
      'trekImages': trekImages,
      'trekRating': trekRating,
      'trekReviews': trekReviews,
      'trekAltitude': trekAltitude,
      'trekDifficulty': trekDifficulty,
      'trekDuration': trekDuration,
      'trekDistance': trekDistance,
      'trekCost': trekCost,
      'trekItinerary': trekItinerary,
      'recommendedGear': recommendedGear,
      'recommendedEssentials': recommendedEssentials,
      'trekOrganizer': trekOrganizer,
      'trekOrganizerContact': trekOrganizerContact,
      'isEvent': isEvent
    };
  }

  // Create an object from Firestore document
  factory Trek.fromMap(Map<String, dynamic> map) {
    return Trek(
      trekId: map['trekId'] ?? '',
      trekName: map['trekName'] ?? '',
      trekLocation: map['trekLocation'] ?? '',
      trekDate:
          DateTime.parse(map['trekDate'] ?? DateTime.now().toIso8601String()),
      trekUploadTimestamp: map['trekUploadTimestamp'] ?? Timestamp.now(),
      trekOverview: map['trekOverview'] ?? '',
      trekImages: List<String>.from(map['trekImages'] ?? []),
      trekRating: (map['trekRating'] ?? 0.0).toDouble(),
      trekReviews: List<String>.from(map['trekReviews'] ?? []),
      trekAltitude: map['trekAltitude'] ?? 0,
      trekDifficulty: map['trekDifficulty'] ?? '',
      trekDuration: map['trekDuration'] ?? '',
      trekDistance: (map['trekDistance'] ?? 0.0).toDouble(),
      trekCost: (map['trekCost'] ?? 0.0).toDouble(),
      trekItinerary: map['trekItinerary'] ?? '',
      recommendedGear: map['recommendedGear'] ?? '',
      recommendedEssentials: map['recommendedEssentials'] ?? '',
      trekOrganizer: map['trekOrganizer'] ?? '',
      trekOrganizerContact: map['trekOrganizerContact'] ?? '',
      isEvent: map['isEvent'] ?? false,
    );
  }

  // Create an object from Firestore document snapshot
  factory Trek.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Trek.fromMap(data);
  }
}

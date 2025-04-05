import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/config/configs.dart';
import 'package:offbeat_pravasi_v2/main.dart';
import 'package:offbeat_pravasi_v2/modules/auth/auth_exports.dart';

import '../exports.dart';

class Storyservices extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _storage = Storage(client);

  bool _isLoading = true;
  List<Story> _stories = [];
  List<String> _userIds = [];
  UserData? _users ;

  List<String> get userIds => _userIds;
  bool get isLoading => _isLoading;
  List<Story> get stories => _stories;
  UserData? get users => _users;

  Storyservices() {
    fetchUserIds();
  }

//fetch curent user data from firestore
  Future<void> fetchUserData() async {
    _isLoading = true;
    try {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      if (userDoc.exists) {
        _users = UserData.fromDocument(userDoc);
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }

  ///fetch user ids from firestore
  Future<void> fetchUserIds() async {
    _isLoading = true;
    try {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      if (userDoc.exists) {
        List<String> friendsIds =
            List<String>.from(userDoc.get('friendsIds') ?? []);
        _userIds = [_auth.currentUser!.uid, ...friendsIds];
      } else {
        _userIds = [_auth.currentUser!.uid];
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching user IDs: $e');
    }
  }

  /// Add a new story to Firestore
  Future<void> addStory({
    required String uid,
    required String username,
    required File image,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();
    String fileId = 'file_${DateTime.now().millisecondsSinceEpoch}';
    try {
      // Create a reference to the storage location
      await _storage.createFile(
        bucketId: Configs.appWriteUserStoryStorageBucketId,
        fileId: fileId,
        file: InputFile.fromPath(path: image.path),
      );

      // Get the file URL
      String fileUrl =
          "https://cloud.appwrite.io/v1/storage/buckets/${Configs.appWriteUserStoryStorageBucketId}/files/$fileId/view?project=${Configs.appWriteProjectId}&mode=admin";

      Story story = Story(
        uid: uid,
        username: username,
        imageUrl: fileUrl,
        time: Timestamp.now(),
      );

      await _firestore.collection('stories').add(story.toMap());
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding story: $e');
    }
  }

  /// Fetch stories from Firestore for a specific user
  Future<void> fetchStoriesForUser(String uid) async {
    _isLoading = true;
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('stories')
          .where('uid', isEqualTo: uid)
          .get();
      _stories = snapshot.docs.map((doc) => Story.fromDocument(doc)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching stories for user: $e');
    }
  }

  /// Fetch stories from Firestore
  Future<void> fetchStoriesForUserIds() async {
    _isLoading = true;
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('stories')
          .where('uid', whereIn: userIds)
          .get();
      _stories = snapshot.docs.map((doc) => Story.fromDocument(doc)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching stories for user IDs: $e');
    }
  }
}

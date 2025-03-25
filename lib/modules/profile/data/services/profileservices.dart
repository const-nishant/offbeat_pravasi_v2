import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offbeat_pravasi_v2/config/configs.dart';
import 'package:offbeat_pravasi_v2/modules/profile/data/models/post.dart';

import '../../../../main.dart';
import '../../../auth/auth_exports.dart';

class ProfileService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = Storage(client);
  BuildContext? _dialogContext;

  UserData? _userData;
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  UserData? get userData => _userData;

  ProfileService() {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      if (doc.exists) {
        _userData = UserData.fromDocument(doc);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Error fetching user data: $e");
    }
  }

  Future<void> addpost(
    BuildContext context,
    String userId,
    String caption,
    File image,
  ) async {
    _showLoader(context);
    try {
      String fileId = DateTime.now().millisecondsSinceEpoch.toString();
      await storage.createFile(
        bucketId: Configs.appWriteUserPostsStorageBucketId,
        fileId: fileId,
        file: InputFile.fromPath(path: image.path),
      );

      String downloadUrl =
          'https://cloud.appwrite.io/v1/storage/buckets/${Configs.appWriteUserPostsStorageBucketId}/files/$fileId/view?project=${Configs.appWriteProjectId}&mode=admin';

      final userdoc = await _firestore.collection('users').doc(userId).get();

      if (userdoc.exists) {
        _userData = UserData.fromDocument(userdoc);
      }

      Post post = Post(
        caption: caption,
        imageUrl: downloadUrl,
        uploadTimestamp: Timestamp.now(),
        userId: userId,
        postId: fileId,
        comments: 0,
        likes: [],
        username: _userData?.name ?? 'default_username',
        userImageUrl: _userData?.profileImage ?? '',
        location: _userData?.location ?? '',
      );

      await _firestore.collection('posts').doc(fileId).set(
            post.toMap(),
          );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post added successfully!'),
        ),
      );

      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    } finally {
      if (_dialogContext != null && _dialogContext!.mounted) {
        Navigator.pop(_dialogContext!); // Close the loader
        _dialogContext = null; // Reset after closing
      }
    }
  }

  // Loader
  void _showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        _dialogContext = dialogContext; // Store context of dialog
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // Error function
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
